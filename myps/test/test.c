#include <lib.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>
#include <minix/rs.h>

int main(int argc, char** argv) {
    if (argc < 2)
        exit(1);

    int uid = atoi(argv[1]);
    myps(uid);

    return 0;
}
