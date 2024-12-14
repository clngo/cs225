#include <stdio.h>

void readstring(char str[]) {
    int i = 0;
    char c;
    while ((c = getchar()) != EOF && c != '\n' && i < 20) {
        str[i++] = c;
    }
    str[i] = '\0';
}

void printsort(char str[]) {
    int count[256] = {0};
    int i, j;
    for (i = 0; str[i]; i++) {
        count[(unsigned char)str[i]]++;
    }
    printf("Alphabetized word: ");
    for (i = 0; i < 256; i++) {
        for (j = 0; j < count[i]; j++) {
            putchar(i);
        }
    }
    putchar('\n');
}

int main(void) {
    char str[19];
    while (1) {
        printf("Enter word: ");
        readstring(str);
        if (str[0] == '\0') {
            putchar('\n');
            printf("Exiting\n");
            break;
        }
        printf("Original word: %s\n", str);
        printsort(str);
    }
    return 0;
}
