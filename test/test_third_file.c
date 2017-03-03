#include <criterion/criterion.h>
#include "third_file.h"

Test(test_third, compile_check)
{
	cr_assert_eq(false, returns_true(), "This should fail.");
}
