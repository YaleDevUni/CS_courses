#!/usr/bin/env python3


# TODO: Complete this function
import math
def pythag(side_a, side_b):
	hyp_side = math.sqrt(side_a**2+side_b**2)
	return hyp_side


def main():
    print("Sides %.3f and %.3f, hypotenuse %.4f" 
        % (10, 13, pythag(10, 13)) )

    print("Sides %.3f and %.3f, hypotenuse %.4f" 
        % (21.9, 31.2, pythag(21.9, 31.2)) )

    print("Sides %.3f and %.3f, hypotenuse %.4f" 
        % (719.21, 21.2, pythag(719.21, 21.2)) )


if __name__ == "__main__":
    main()
