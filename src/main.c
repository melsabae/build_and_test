#include "main.h"
#include "second_file.h"
#include "third_file.h"
#include <stdio.h>

unsigned int fib(int n)
{
	if(2 >= n)
	{
		return n;
	}

	return fib(n - 1) + fib(n - 2);
}

int main()
{
	second_print();
	third_print();

	if(true == second_true_generator())
	{
		puts("second true generator works fine");
	}
	else
	{
		puts("second true generator does not work fine");
	}

	if(true == third_true_generator())
	{
		puts("third true generator works fine");
	}
	else
	{
		puts("third true generator does not work fine");
	}

	puts("finished checks");


	// can you read this?

	for(int i = 0; i < 30; i++)
	{
		fib(i);
	}


	return 0;
}
