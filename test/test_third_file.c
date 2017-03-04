#include <criterion/criterion.h>
#include "third_file.h"

Test(test_third, compile_check)
{
	cr_assert_eq(true, third_true_generator(), "third true gen");
	cr_assert_eq(false, third_false_generator(), "third false gen");
}
