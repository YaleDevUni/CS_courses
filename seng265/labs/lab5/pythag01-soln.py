#!/usr/bin/env python

import sys

def main():
    if len(sys.argv) < 3:
        print("Need two lengths")
        sys.exit(0)

    a = float(sys.argv[1])
    b = float(sys.argv[2])

    c = (a ** 2 + b ** 2) ** 0.5
    print(c)


if __name__ == "__main__":
    main()
