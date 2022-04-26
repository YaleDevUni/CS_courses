#!/usr/bin/env python

import sys

def main():
    if (len(sys.argv) == 1):
        print("Hello, whoever you are!")
    else:
        print("Hello,", sys.argv[1])

if __name__ == "__main__":
    main()
