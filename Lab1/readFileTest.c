# include <stdio.h>
# include <stdlib.h>
# include <string.h>

int main(){
    FILE *file_ptr;

    // character buffer that stores the read character 
    // til the next iteration
    char ch;

    // opening file in read mode 
    file_ptr = fopen("test.txt", "r");

    if (NULL == file_ptr){
        printf("File can't be opened\n");
            return EXIT_FAILURE;
    }

    printf("Content of the file are:-: \n");

    // printing what is written in file 
    // character by character using loop
    while ((ch = fgetc(file_ptr)) != EOF){
        printf("%c", ch);
    }

    // closing the file 
    fclose(file_ptr);
    return 0;
}