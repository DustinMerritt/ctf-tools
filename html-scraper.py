#!/usr/bin/env python3
"""
html_scraper.py

A flexible web scraping tool for extracting text from a specific HTML tag and optional class.

Usage:
    Run the script and enter the required inputs when prompted:
      - Full URL of the page to scrape
      - HTML tag (e.g., strong, span, h3)
      - Optional class name (leave blank if not needed)

Example:
    $ python3 html_scraper.py
    Enter URL: https://example.com/meet-the-team
    Enter HTML tag to search: strong
    Enter class name (or leave blank): 
"""

import requests
from bs4 import BeautifulSoup

def scrape_elements(url, tag, class_name=None):
    try:
        headers = {'User-Agent': 'Mozilla/5.0'}
        response = requests.get(url, headers=headers)
        response.raise_for_status()
    except requests.RequestException as e:
        print(f"[!] Error fetching URL: {e}")
        return

    soup = BeautifulSoup(response.text, 'html.parser')

    if class_name:
        elements = soup.find_all(tag, class_=class_name)
    else:
        elements = soup.find_all(tag)

    if elements:
        print(f"\n[+] Text found in <{tag}> tag{' with class "' + class_name + '"' if class_name else ''}:")
        for el in elements:
            text = el.get_text(strip=True)
            if text:
                print(f"{text}")
    else:
        print(f"[!] No <{tag}> elements found{' with class ' + class_name if class_name else ''}.")

if __name__ == "__main__":
    url = input("Enter URL: ").strip()
    tag = input("Enter HTML tag to search (e.g., strong, h3, span): ").strip()
    class_name = input("Enter class name (or leave blank): ").strip()
    class_name = class_name if class_name else None
    scrape_elements(url, tag, class_name)
