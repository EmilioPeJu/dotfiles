#!/usr/bin/env python
import argparse
import re
import requests
from bs4 import BeautifulSoup


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('url')
    parser.add_argument('--regex', default=None)
    return parser.parse_args()


def main():
    args = parse_args()
    soup = BeautifulSoup(requests.get(args.url).text)

    for x in soup.find_all("a", href=True):
        if (not args.regex and x["href"].startswith("http")) or \
                (args.regex and re.match(args.regex, x["href"])):
            print(x["href"])


if __name__ == "__main__":
    main()
