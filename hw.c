#include <stdio.h>
#include <vector>

int nomain()
{
	printf("hello world\n");
	return 2+2;
}

struct Foo
{
	int i;
	double d;
	std::vector<double> values;
};

struct Foo foo;
