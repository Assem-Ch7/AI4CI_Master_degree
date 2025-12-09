#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void) {
    int pipe_a_to_b[2];
    int pipe_b_to_a[2];
    pid_t pid;
    char buffer[128];
    const char *msg_a = "Hello from A!";
    const char *msg_b = "HEllo from B!";
    // Create pipe
    if (pipe(pipe_a_to_b) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }

    if (pipe(pipe_b_to_a) == -1) {
        perror("pipe");
        exit(EXIT_FAILURE);
    }
    
    // Fork a child
    pid = fork();
    
    if (pid == -1) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if (pid == 0) {
        // Child: close write end, read from pipe
        close(pipe_a_to_b[1]);  // Close write end
        
        // Child: read a message from Parent
        ssize_t n = read(pipe_a_to_b[0], buffer, sizeof(buffer) - 1);
        if (n == -1) {
            perror("read");
            exit(EXIT_FAILURE);
        }
        
        buffer[n] = '\0';
        printf("A received: %s\n", buffer);
        
        close(pipe_a_to_b[0]);

	close(pipe_b_to_a[0]);

	ssize_t written = write(pipe_b_to_a[1], msg_a, strlen(msg_b));
        if (written == -1) {
            perror("write");
            exit(EXIT_FAILURE);
        }

        printf("B sent: %s (%zd bytes)\n", msg_b, written);

        close(pipe_b_to_a[1]);
        wait(NULL);

        exit(EXIT_SUCCESS);
    } else {
        // Parent: close read end, write to pipe
        close(pipe_a_to_b[0]);  // Close read end
        
        // Parent: send a message to Child
        ssize_t written = write(pipe_a_to_b[1], msg_b, strlen(msg_a));
        if (written == -1) {
            perror("write");
            exit(EXIT_FAILURE);
        }
        
        printf("a sent: %s (%zd bytes)\n", msg_b, written);
        
        close(pipe_a_to_b[1]);
        wait(NULL);


        close(pipe_b_to_a[0]);  // Close write end

        // Child: read a message from Parent
        ssize_t n = read(pipe_b_to_a[0], buffer, sizeof(buffer) - 1);
        if (n == -1) {
            perror("read");
            exit(EXIT_FAILURE);
        }

        buffer[n] = '\0';
        printf("B received: %s\n", buffer);

        close(pipe_b_to_a[0]);
    }
    
    return EXIT_SUCCESS;
}
