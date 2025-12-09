#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
    pid_t pid;
    
    pid = fork();
    
    if (pid == -1) {
        perror("fork failed");
        exit(EXIT_FAILURE);
    }
    
    if (pid == 0) {
        // Child terminates quickly
        printf("Child process exiting\n");
        exit(EXIT_SUCCESS);
    } else {
        // Parent does NOT call wait() and continues running
        printf("Parent process running...\n");
	wait(NULL);
        for (;;) {
            sleep(1);
        }
    }
    
    return EXIT_SUCCESS;
}
