#include <criterion/criterion.h>
#include "third_file.h"

Test(test_third, compile_check)
{
	cr_assert_not(1 == returns_true(), "This should fail.");
}
