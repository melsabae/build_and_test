#include "third_file.h"
#include <stdio.h>

void third_print(void)
{
	puts(__FILE__);
}

bool third_true_generator(void)
{
	return true;
}

bool third_false_generator(void)
{
	return false;
}
