#ifndef __MAIN_H__
#define __MAIN_H__

/*! \file main.h
 *  \brief Contains globally accessible items throughout the program
 *
 *  Contains macros for doubling numeric types, a global state variable
 *  and a typedef'd structure for no particular reason.
 */


/*! \namespace \<inttypes.h>
 * \brief for uintx_t and intx_t types and their printing macros
 */
#include <inttypes.h>


/*! \namespace \<stdbool.h>
 * \brief for booleans
 */
#include <stdbool.h>


/*! \namespace \<arpa/inet.h>
 * \brief for htons and ntohs functions
 */
#include <arpa/inet.h>


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

/*! \var global_int
 * \brief A global state likely to be abused
 *
 * Take good care of side effects.
 */
volatile int global_int = 0; /*!< additional information, like why 0 is cool
	or why volatile was necessary */


/*! \def DOUBLE_RESULT
 * \param x a numeric type
 *
 * Returns x * 2, without modifying x.
 */
#define DOUBLE_RESULT(x) (2.0f * x)

/*! \def DOUBLE_STORE
 * \param x a numeric type
 *
 * Returns x * 2, and changes x.
 */
#define DOUBLE_STORE(x) (x *= 2.0f)


/*! \fn main_param_generator(bool PARAM)
 * \brief Returns PARAM.
 * \param PARAM The boolean to be generated
 *
 * Returns PARAM. Cannot modify PARAM. State is guaranteed to not change
 * by this function call.
 */
bool main_param_generator(const bool PARAM);

#endif
