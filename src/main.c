#include "main.h"
#include "second_file.h"
#include "third_file.h"
#include <stdio.h>

int main()
{
	if(returns_true() != true)
	{
		puts("this shouldn't have happened");
	}
	else
	{
		puts("i expect no less");
	}

	puts(">>");
	return 0;
}
