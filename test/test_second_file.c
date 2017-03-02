#include "criterion.h"
#include "second_file.h"

Test(second_file, compile_test)
{
	cr_assert_fail("This should be a failure");
}

