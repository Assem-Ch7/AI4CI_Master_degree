#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
  pid_t pid;
  pid = fork();

  if (pid == 0) {
     // Child
     // Execute ls-l
     execl("bin/ls", "ls","-l", NULL);
     perror("exec failed"); // Only executes if exec fails
     exit(EXIT_FAILURE);
  } else {
     // Parent
     // Wait for the child
     printf("PArent : CHild PID is %d, ",getpid());
     int status;
     wait(&status);
     if (WIFEXITED(status)) {
            printf("Child finished with exit status %d\n", 
                   WEXITSTATUS(status));
     }
     printf("Parent: Exiting\n");
  }
return EXIT_SUCCESS;
}
