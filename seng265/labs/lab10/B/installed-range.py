#!/usr/bin/env python3

import re
import sys

def main():
    if len(sys.argv) < 2:
        sys.exit(0)

    date_from = sys.argv[1]
    date_to   = sys.argv[2] 
    from_mon = int(re.search(r"(\d\d\d\d)-(\d\d)-(\d\d)",sys.argv[1]).group(2))*30
    from_date = int(re.search(r"(\d\d\d\d)-(\d\d)-(\d\d)",sys.argv[1]).group(3))
    from_time = from_mon+from_date
    to_mon = int(re.search(r"(\d\d\d\d)-(\d\d)-(\d\d)",sys.argv[2]).group(2))*30
    to_date = int(re.search(r"(\d\d\d\d)-(\d\d)-(\d\d)",sys.argv[2]).group(3))
    to_time = to_mon+to_date
    # TODO: Complete your code here as described at the end of video # 2 for Lab 10.
    line_number = 0

    pattern = re.compile(r" installed ((.+):(.+)) .*")
    switch = False
    for line in sys.stdin:
        line = line.rstrip()
        date = re.search(r"(\d\d\d\d)-(\d\d)-(\d\d)",line)
        log_mon = int(date.group(2))*30
        log_date = int(date.group(3))
        log_time = log_mon+log_date
        
        line_number += 1

        m = pattern.search(line)
        if m and log_time >= from_time and log_time<= to_time:
            print("%s : %s" % (date.group(0), m.group(2)))

if __name__ == "__main__":
    main()
