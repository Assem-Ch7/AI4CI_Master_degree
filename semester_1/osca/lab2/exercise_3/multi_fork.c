#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <time.h>

int main() {
    pid_t pid;
    int i;

    srand(time(NULL));
    
    printf("Parent: My PID is %d\n", getpid());

    for (i = 1; i <= 5; i++) {
        pid = fork();

        if (pid == -1) {
            perror("fork failed");
            return 1;
        } else if (pid == 0) {
            int sleep_time = (rand() % 5) + 1;
            
            printf("Child %d: My PID is %d, Parent PID is %d.\n", i, getpid(), getppid());
            
            sleep(sleep_time);
            
            exit(i); 
        }
    }
    
    for (i = 1; i <= 5; i++) {
        int status;
        pid_t child_pid = wait(&status);

        if (child_pid > 0) {
            if (WIFEXITED(status)) {
                int exit_status = WEXITSTATUS(status);
                printf("Parent: Child with PID %d terminated with exit status %d.\n", child_pid, exit_status);
            } else {
                printf("Parent: Child with PID %d terminated abnormally.\n", child_pid);
            }
        } else if (child_pid == -1) {
            perror("wait failed");
            break;
        }
    }

    return 0;
}













