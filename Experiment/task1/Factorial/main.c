#include<stdio.h>
#define mul(a, b) a * b
int i;
void fac(int n);
int main()
{
	int n;

	scanf("%d",&n);
	fac(n);

    return 0;
}
void fac(int n)
{
	int f;
	i = 2;
	f = 1;
	while (i <= n)
	{
		f = mul(f, i);
		i = i + 1;
	}
	printf("%d", f);
}