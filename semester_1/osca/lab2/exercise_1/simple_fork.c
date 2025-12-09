 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>

int main(void) {
pid_t pid;
pid = fork();

if (pid ==-1) {
perror("fork failed");
exit(EXIT_FAILURE);
}
if (pid == 0) {
// TODO: Child process code
for(;;)
        printf("I am the parent \n");
} else {
// TODO: Parent process code
for(;;)
        printf("I am the child \n");
}
return EXIT_SUCCESS;

}
