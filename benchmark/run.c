#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void save_file(unsigned int size) {
	clock_t begin = clock();

    FILE *f = fopen("benchmark_file", "wb");
    if (f == NULL) {
        printf("Error opening benchmark_file.\n");
        exit(1);
    }
    
    char *buffer = calloc(sizeof(char), size);
    fwrite(buffer, sizeof(char)*size, 1, f);
    free(buffer);
    
    fclose(f);
	
	clock_t end = clock();

    printf("SIZE: %db, \t TIME: %ld\n", size, end - begin);

    if (remove("benchmark_file") != 0) {
        printf("Error removing file benchmark_file.\n");
        exit(1);
    }
}

int main() {
    save_file(10);
    save_file(100);
    save_file(1000);
    save_file(10000);
    save_file(100000);

    return 0;
}
