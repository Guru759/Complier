#include<stdio.h>
void fac(int n)
{
	int i, f;
	i = 2;
	f = 1;
	while (i <= n)
	{
		f = f * i;
		i = i + 1;
	}
	printf("%d", f);
}