#include "poorly_formatted.h"
#include <criterion/criterion.h>

Test(poorly_formatted, garbage_stuff)
{
	Bad_function_Naming(NULL);
	cr_assert_eq(0, nospaces());
	cr_assert_eq(7, camelCase(NULL, NULL));
}
