#!/usr/bin/env python3

import sys

# TODO Complete this function
def main():
    all_words = []
    for line in sys.stdin:
        line = line.strip()
        all_words.extend(line.split(","))
    sorted_list = sorted(all_words, key=str.lower)
    # print(sorted_list[0])
    cnt = 1
    shortest = len(sorted_list[0])
    longest = len(sorted_list[0])
    shortest_word = []
    longest_word = []
    print(sorted_list)
    for word in sorted_list:
        cnt = cnt+1
        if shortest > len(word):
            shortest = len(word)
        if longest < len(word):
            longest = len(word)
    for word in sorted_list:
        if shortest == len(word):
            shortest_word.append(word)
        if longest == len(word):
            longest_word.append(word)
    print("shortest words: ", shortest_word)
    print("longest words: ", longest_word)
if __name__ == "__main__":
    main()
