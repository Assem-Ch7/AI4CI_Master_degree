#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(void) {
	pid_t pid;
	pid = fork();

	if (pid == -1)
	{
		perror("fork failed");
		exit(EXIT_FAILURE);
	}

	if (pid == 0)
	{
		printf("Child : My PID is %d, Child PID is %d\n",getpid(), getppid());
	} else {
		printf("Parent : My PID is %d, Parent PID is %d\n" , getpid(), getppid());
		wait(NULL);
	}
	return EXIT_SUCCESS;
}
