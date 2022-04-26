#!/usr/bin/env python3

import re
import sys

def main():
    if len(sys.argv) < 2:
        sys.exit(0)

    line_number = 0

    pattern = re.compile(r" installed ((.+):(.+)) .*")

    for line in sys.stdin:
        line = line.rstrip()
        line_number += 1

        m = pattern.search(line)
        if m:
            print("%d: %s" % (line_number, m.group(2)))

if __name__ == "__main__":
    main()
