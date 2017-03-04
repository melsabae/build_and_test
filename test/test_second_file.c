#include "second_file.h"
#include <criterion/criterion.h>

Test(test_second, compile_check)
{
	cr_assert_eq(true, second_true_generator());
	cr_assert_eq(false, second_false_generator());
}
