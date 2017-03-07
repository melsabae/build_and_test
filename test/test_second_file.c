#include "second_file.h"
#include <criterion/criterion.h>

int test_second_printer(void);

int test_second_printer()
{
	second_print();
	return 0;
}

Test(test_second, api_check)
{
	cr_assert_eq(true, second_true_generator());
	cr_assert_eq(false, second_false_generator());
	cr_assert_eq(0, test_second_printer());
}

