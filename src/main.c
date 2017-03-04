#include "main.h"
#include "second_file.h"
#include "third_file.h"
#include <stdio.h>

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


	return 0;
}
