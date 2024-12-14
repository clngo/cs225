#include <stdio.h>

int main() {
    int myNum;
    int bit = -2147483648;
    char loop;
    printf("Welcome to the Reverse program.");

    while (loop != 'n') {
    int result = 0;
    int counter = 0;
    printf("\nPlease enter a number: ");
    scanf("%d", &myNum);

    while (myNum != 0) { 
        if ((myNum & bit) != 0) {
            result += 1 << counter;
        } 
        myNum = myNum << 1; 
        counter += 1;

    }   

    printf("The bit reversed value in hex is: %x\n", result); // %x to print the result as hexidecimal.
    printf("Continue (y/n)?: ");
    scanf("%s", &loop);  
    }

    printf("Exiting\n");
    return 0;
}