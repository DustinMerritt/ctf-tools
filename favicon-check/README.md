# Favicon Hash Checker

A simple script to identify web technologies and services based on a site's favicon hash using the OWASP Favicon Database.

This tool downloads a favicon file from a direct URL, calculates its MD5 hash, and checks for a match against the OWASP favicon hash list to help identify common services (e.g., Shodan honeypots, Apache, Jenkins, etc.).

## Features

- Uses `md5sum` to fingerprint any `favicon.ico` - Dynamically pulls and parses the OWASP favicon database using Python and BeautifulSoup
- Bash script with minimal dependencies: `curl`, `awk`, `md5sum`, and Python3

## Usage

1. Clone the repository

```bash
git clone https://github.com/your-username/favicon-hash-checker.git
cd favicon-hash-checker
```

2. Make the script executable

```bash
chmod +x favicon_check.sh
```

3. Run the script with a direct favicon URL

```bash
./favicon_check.sh https://example.com/favicon.ico
```

## Example Output

```
[*] Downloading favicon from: https://example.com/favicon.ico
[*] Favicon MD5 hash: d41d8cd98f00b204e9800998ecf8427e
[*] Fetching OWASP favicon database...
[+] Match found: d41d8cd98f00b204e9800998ecf8427e | Shodan honeypot favicon
```

## References

- https://wiki.owasp.org/index.php/OWASP_favicon_database
- https://blog.shodan.io/identifying-technologies-via-favicons/

## Disclaimer

This tool is for educational and ethical use only. Do not use against systems without explicit permission.

## License

MIT License – see `LICENSE` for details.
