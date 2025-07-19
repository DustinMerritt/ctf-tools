#!/bin/bash

# Usage check
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <favicon_url>"
  echo "Example: $0 https://static-labs.tryhackme.cloud/sites/favicon/images/favicon.ico"
  exit 1
fi

FAVICON_URL="$1"
TMP_ICON=$(mktemp)
TMP_HASH=$(mktemp)

# Download favicon
echo "[*] Downloading favicon from: $FAVICON_URL"
curl -s -L "$FAVICON_URL" -o "$TMP_ICON"

# Check if it downloaded
if [ ! -s "$TMP_ICON" ]; then
  echo "[!] Failed to download favicon."
  exit 1
fi

# Generate MD5 hash
HASH=$(md5sum "$TMP_ICON" | awk '{ print $1 }')
echo "[*] Favicon MD5 hash: $HASH"

# Download OWASP hash list dynamically and check
echo "[*] Fetching OWASP favicon database..."
python3 - "$HASH" << 'EOF'
import requests
from bs4 import BeautifulSoup
import re
import sys

hash_to_check = sys.argv[1]
url = "https://wiki.owasp.org/index.php/OWASP_favicon_database"

res = requests.get(url)
soup = BeautifulSoup(res.text, "html.parser")

found = False
for li in soup.select("li"):
    code = li.find("code")
    if code and re.match(r'^[a-f0-9]{32}$', code.text.strip()):
        md5 = code.text.strip()
        if md5 == hash_to_check:
            desc = li.get_text().replace(md5, "").strip(" -:\u2013")
            print(f"[+] Match found: {md5} | {desc}")
            found = True
            break

if not found:
    print("[-] No match found in OWASP favicon database.")
EOF

# Cleanup
rm -f "$TMP_ICON" "$TMP_HASH"
