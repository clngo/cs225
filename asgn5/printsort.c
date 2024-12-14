/* Colin Ngo */
/* Bernice Lau */

#include <stdio.h>

void readstring(char str[]) {
    int i = 0;
    char c = getchar();
    while (c != '\n') { 
        str[i] = c;
        i++;
        c = getchar();
    }
    str[i] = '\0'; /* ending of the array*/
}

void printsort(char str[]) {
    char lowest = 'z';
    int j = 0;
    int i = 0;
    while (str[j] != '\0') {
            if (str[j] < lowest) {
            lowest = str[j];
            }
        j++;
        }
    j = 0;
    while (str[j] != '\0') {
        if (str[j] == lowest) {
            putchar(lowest);
         }
        j++;
    }
    while (str[i] != '\0') {
        char next_low = 'z';
        j = 0;
        while (str[j] != '\0') {
            if (lowest < str[j] && str[j] < next_low) { /* lowest >= str[j] && str[j] >= next_low*/
                next_low = str[j];
            }
            j++;
        }

        j = 0;
        while (str[j] != '\0') {
            if (str[j] == next_low) {
                putchar(next_low);
            }
            j++;
        }
        lowest = next_low;
        i++;
    }
    
}

int main() {
    char str[20];
    while (1) {
        printf("Enter word: ");
        readstring(str);
        if (str[0] == '\0') {
            putchar('\n');
            printf("Exiting\n");
            break;

        }
        printf("Original word: %s\n", str);
        printf("Alphabetized word: ");
        printsort(str);
        putchar('\n');

    }
    return 0;
}
