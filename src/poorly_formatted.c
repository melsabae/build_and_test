#include <stdlib.h>
void Bad_function_Naming(void* Parameter);
int camelCase(void* nothing, int something);
int nospaces(void) {
	return 0;
}

int camelCase(void* nothing, int something)
{
	if(0)
		nospaces();

	/*
	  asdf
	 */

	else
		Bad_function_Naming(NULL);

	do {
		;;
	} while(0);

	switch(0)
	{
		case 0:
			break;
		case 1:
			break;
		case 2:
			{
				;;
			}
			break;
default:
			break;
	}

	for(int i = 0; i < 7; i++);
	{
		;
	}

	int longname;
	int shortername_not, whatever;


	return 7;
}
