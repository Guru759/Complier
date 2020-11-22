#include<stdio.h>
#include"fac.h"
int main()
{
	int n;

	scanf("%d",&n);
	fac(n);

    return 0;
}


sun@DESKTOP-GSMT9U1:~/Complier/Experiment/task1/Factorial$ ar rcs main.a main.o
sun@DESKTOP-GSMT9U1:~/Complier/Experiment/task1/Factorial$ gcc fac.c -E -o fac.i
sun@DESKTOP-GSMT9U1:~/Complier/Experiment/task1/Factorial$ gcc -O0 -o fac.S -S -masm=att fac.i
sun@DESKTOP-GSMT9U1:~/Complier/Experiment/task1/Factorial$ gcc -O0 -c -o fac.o fac.S
sun@DESKTOP-GSMT9U1:~/Complier/Experiment/task1/Factorial$ ar rcs fac.a fac.o
sun@DESKTOP-GSMT9U1:~/Complier/Experiment/task1/Factorial$ gcc app.c -static ./fac.a -o app