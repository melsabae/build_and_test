#include <criterion/criterion.h>
#include "third_file.h"

int test_third_printer(void);

int test_third_printer(void)
{
	third_print();
	return 0;
}

Test(test_third, api_check)
{
	cr_assert_eq(true, third_true_generator(), "third true gen");
	cr_assert_eq(false, third_false_generator(), "third false gen");
	cr_assert_eq(0, test_third_printer());
}
