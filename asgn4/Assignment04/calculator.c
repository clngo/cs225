#include <stdio.h>
#include "operations.h"

int main(void) {
    int operations, num1, num2, op, result;
    char choice;
    printf("Welcome to the Calculator program.\n");
    printf("Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift\n");

    operations = 0;
    choice = 'y';

    while (choice != 'n') {
        printf("\nNumber of operations performed: %d\n", operations);

        printf("Enter number: ");
        scanf("%d", &num1);
        printf("Enter second number: ");
        scanf("%d", &num2);
        printf("Select operation: ");
        scanf("%d", &op);

        switch (op) {
            case 1:
                result = addnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 2:
                result = subnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 3:
                result = multnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 4:
                result = divnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 5:
                result = andnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 6:
                result = ornums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 7:
                result = xornums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 8:
                result = lshiftnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            case 9:
                result = rshiftnums(num1, num2);
                printf("Result: %d\n", result);
                break;
            default:
                printf("Result: Invalid Operation\n");
                break;
        }

        printf("Continue (y/n)?: ");
        scanf(" %c", &choice);
        operations++;
    }

    printf("\nNumber of operations performed: %d\n", operations);
    printf("Exiting\n");

    return 0;
}
