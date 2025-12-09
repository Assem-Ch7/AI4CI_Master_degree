#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


int main(void) {
 printf("Before exec: PID = %d\n", getpid());
 // Execute ls-l
 execl("/bin/ls", "ls", "-l", NULL);

 printf("After exec: PID = %d\n", getpid());
 perror("exec");
 exit(EXIT_FAILURE);
}
