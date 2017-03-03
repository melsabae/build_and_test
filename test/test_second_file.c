#include "second_file.h"
#include <criterion/criterion.h>

Test(test_second, compile_check)
{
	cr_assert_fail("You are a failure.");
}
