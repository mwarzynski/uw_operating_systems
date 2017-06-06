#include <stdio.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <errno.h>

int main( void ) {
    int fd;
    char buf[4]="abcd";

    fd = open("/dev/helloN", O_RDWR);
    if (fd < 0) {
        perror("open: ");
        return 1;
    }
    if (lseek(fd, 1, SEEK_SET) < 0) {
        perror("lseek: ");
        return 1;
    }
    if (write(fd, &buf, 4) < 0) {
        perror("write: ");
        return 1;
    }
    close(fd);
        
    return 0;
}
