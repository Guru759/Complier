#include<stdio.h>
int i = 2;
int f = 1;
int n = 0;
int fac(int n)
{
	while (i <= n)
	{
		f = f * i;
		i = i + 1;
	}
	return f;
}
int main()
{
	scanf("%d",&n);
    printf("%d", fac(n));

    return 0;
}