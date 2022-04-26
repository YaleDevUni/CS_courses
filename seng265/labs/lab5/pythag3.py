#!/usr/bin/env python3

import sys
import math
# TODO: Complete this function

def pythag(side_a, side_b):
	hyp_side = math.sqrt(side_a**2+side_b**2)
	return hyp_side


def main():
    if len(sys.argv) < 3:
        print("You must enter exactly 2 numbers for triangle sides.")
        sys.exit(1)

   # TODO: Complete the code HERE
    try:
        side_a = float(sys.argv[1])
        side_b = float(sys.argv[2]) 

    except ValueError:
        print("Your input must be number!!")
        sys.exit(1)

    print("Sides %.3f and %.3f, hypotenuse %.4f" 
    % (side_a, side_b, pythag(side_a, side_b)) )
if __name__ == "__main__":
    main()
