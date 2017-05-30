#include <stdio.h>
#include <stdlib.h>

#include <iostream>
#include <ctime>
#include <cstdio>
#include <iostream>
#include <ctime>
#include <ratio>
#include <chrono>

using namespace std;

void save_file(unsigned int size) {
   

    FILE *f = fopen("benchmark_file", "wb");
    if (f == NULL) {
        printf("Error opening benchmark_file.\n");
        exit(1);
    }
    
    char *buffer = (char *)calloc(sizeof(char), size);
    fwrite(buffer, sizeof(char)*size, 1, f);
    free(buffer);
    
    fclose(f);

    if (remove("benchmark_file") != 0) {
        printf("Error removing file benchmark_file.\n");
        exit(1);
    }
}

void measure_saving_file(unsigned int size, unsigned int times) {
    using namespace std::chrono;
    high_resolution_clock::time_point t1 = high_resolution_clock::now();

	for (unsigned int i = 0; i < times; i++) {
		save_file(size);
	} 

    high_resolution_clock::time_point t2 = high_resolution_clock::now();

	auto duration = duration_cast<microseconds>( t2 - t1 ).count();

    cout << "SIZE: "<< size << "b, TIMES: " << times << ", \t DURATION: " << duration << endl;
}

int main() {
    measure_saving_file(10, 1000);
    measure_saving_file(100, 1000);
    measure_saving_file(1000, 1000);
    measure_saving_file(10000, 1000);
    measure_saving_file(100000, 1000);
	measure_saving_file(1000000, 1000);

    return 0;
}
