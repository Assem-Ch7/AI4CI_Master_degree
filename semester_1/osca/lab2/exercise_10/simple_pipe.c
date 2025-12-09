#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/wait.h>

int main(void)
{
 int pipe[2];
 pid_t pid;
 char buffer[128];
 const char *msg = "Hello from parent!";

        if (pipe(pipefd) == -1) {
               perror("pipe");
               exit(EXIT_FAILURE);
        }

	pid = fork();

	
	if (pid == 0) 
	{
		close(pipefd[1]);
		ssize_t n = read(pipefd[0], buffer, sizeof(buffer) - 1);

		if (n == -1)
		{
			perror("read");
			exit(EXIT_FAILURE);
		}

		buffer[n] = '\0';
		printf("Child received: %s\n", buffer);

		close(pipefd[0]);
		exit(EXIT_SUCCESS);
	}
	else {
		close(pipefd[0]);

		ssize_t w = write(pipefd[1], msg, strlen(msg));
		if (w == -1)
		{
			perror("write");
			exit(EXIT_FAILURE);
		}
		printf("Parent sent: %s (%zd bytes)\n", msg, w);
		close(pipefd[1]);
		wait(NULL);
	}
	return EXIT_SUCCESS;
}
