/* 
 * CSC 225 - Assignment 3
 * Name: Yeil Park
 * Student number: V00962281
 */
 
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.NoSuchElementException;
import java.util.Arrays;


public class ArrayMatch {
	/*
	 * subArray
	 * Purpose: get sub array from the given range
	 * Parameters: int[] array, int beg, int end 
	 * Returns: int[] 
	 */
    public static int[] subArray(int[] array, int beg, int end) {
        return Arrays.copyOfRange(array, beg, end + 1);
    }
	/*
	 * match
	 * Purpose: Determine if the two given arrays 'match'
	 * Parameters: int[] a, int[] b - the two arrays
	 * Returns: boolean - true if arrays 'match', false otherwise
	 * Preconditions: a and b have the same number of elements
	 */
	public static boolean match(int[] a, int[] b) {
		boolean isMatch = false;

		if(a.length%2!=0 || b.length%2!=0){
			isMatch = Arrays.equals(a, b);
			return isMatch;
		}

		int[] subA1 = subArray(a,0,a.length/2-1);
		int[] subA2 = subArray(a,a.length/2,a.length-1);
		int[] subB1 = subArray(b,0,b.length/2-1);
		int[] subB2 = subArray(b,b.length/2,b.length-1);

		if(Arrays.equals(subA1, subB1)&&Arrays.equals(subA2, subB2)){
			return true;
		}

		if(Arrays.equals(subA1, subB1)&&Arrays.equals(subA1, subB2)){
			return true;
		}

		if(Arrays.equals(subA2, subB1)&&Arrays.equals(subA2, subB2)){
			return true;
		}

		if(subA1.length%2==0){ //if sub arrays of a and b are divibled by 2, proceed a recursion 
			isMatch = match(subA1, subB1);

			if(isMatch){		//to avoid next fuction change the boolean value 
				return true;
			}

			isMatch = match(subA2, subB2);
		}

		return isMatch;
	}

	/*
	 * fillArray
	 * Purpose: Fills arrays with contents read from Scanner
	 * Parameters: int[] x, Scanner fileReader
	 * Returns: nothing
	 */
	public static void fillArray(int[] x, Scanner fileReader) throws NoSuchElementException {
		Scanner f = new Scanner(fileReader.nextLine());
		for (int i = 0; i < x.length; i++) {
			x[i] = f.nextInt();
		}
	}
		
	/*
	 * a3Setup
	 * Purpose: Initializes the input arrays for Assignment 3 match detection
	 *          by reading data from the text file named fname
	 * Parameters: String fname - name of the file containig input data
	 * Returns: nothing
	 */
	public static void a3Setup(String fname) {
		Scanner fileReader = null;
		int[] A = null;
		int[] B = null;
		
		try {
			fileReader = new Scanner(new File(fname));
		} catch (FileNotFoundException e) {
			System.out.println("Error finding input file");
			e.printStackTrace();
			return;
		}
		
		try {
			int size = Integer.parseInt(fileReader.nextLine());
			A = new int[size];
			B = new int[size];
			fillArray(A, fileReader);
			fillArray(B, fileReader);
		} catch (NoSuchElementException e) {
			System.out.println("Error reading input file data");
			e.printStackTrace();
		}
		
		if (match(A,B)) {
			System.out.println("match found");
		} else {
			System.out.println("no matches");
		}
	}
	
	public static void main(String[] args) {
		if (args.length < 1) {
			System.out.println("Incorrect usage, should be:");
			System.out.println("java MysteryArray filename.txt");
			return;
		}
		a3Setup(args[0]);
	}
}