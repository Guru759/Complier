#include<stdio.h>
int a = 0;
int b = 1;
void fib(int n, int a, int b)
{
    int i = 1;
    int t;
    printf("%d",a);
    printf("%d",b);

	while (i < n)
	{
		t = b;
		b = a + b;
		printf("%d",b);
		a = t;
		i = i + 1;
	}
}
int main()
{
	int n;
	scanf("%d",&n);

    fib(n, a, b);

    return 0;
}