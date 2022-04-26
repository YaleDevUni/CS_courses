#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{

        // variable to store the final answer
        long factorial = 1;
	

        // WRITE YOUR CODE TO DO COMMAND LINE INPUT CHECKING HERE

	if(atoi(argv[1])<0){
		printf("wrong input variable!! It must be positive int number"); 
		return 0;
	}


        // Takes the command line input and converts it into int.
        int num = atoi(argv[1]);


        // WRITE YOUR CODE TO DO THE FACTORIAL CALCULATIONS HERE
	for(int i=0;i<num+1;i++){
		factorial = factorial * num;
		num = num-1;
	}

        printf("%ld\n", factorial);
}
