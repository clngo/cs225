#include <stdio.h>

int main() {
    int myNum;
    char loop;
    printf("Welcome to the CountOnes program.");

    while (loop != 'n') {
    int bit = 1;
    int counter = 0;
    printf("\nPlease enter a number: ");
    scanf("%d", &myNum);

    while (bit != 0) { 
        if ((myNum & bit) != 0) {
            counter += 1;
        } 
        bit = bit << 1;
    }   

    printf("The number of bits set is: %d\n", counter);
    printf("Continue (y/n)?: ");
    scanf("%s", &loop);  
    }

    printf("Exiting\n");
    return 0;
}