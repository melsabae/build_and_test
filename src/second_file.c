#include <stdio.h>
#include "second_file.h"

void second_print(void)
{
	puts(__FILE__);
}

bool second_true_generator(void)
{
	return true;
}

bool second_false_generator(void)
{
	return false;
}

