#ifndef __MAIN_H__
#define __MAIN_H__

#include <inttypes.h>

/*! \brief example_struct_t
 *	This struct represents nothing at all.
 *
 * Use to your heart's content.
 */
typedef struct
{
	uint8_t byte;
	uint16_t two_byte;
	uint32_t three_byte;
} example_struct_t;

int global_int; //!< a global state to be abused


/*! \def DOUBLE_RESULT
 *
 * Returns x * 2, without modifying x.
 */
#define DOUBLE_RESULT(x) (2.0f * x)

/*! \def DOUBLE_STORE
 *
 * Returns x * 2, and changes x.
 */
#define DOUBLE_STORE(x) (x *= 2.0f)

#endif
