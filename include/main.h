#ifndef __MAIN_H__
#define __MAIN_H__

/*! \file main.h
 *  \brief Contains globally accessible items throughout the program
 *
 *  Contains macros for doubling numeric types, a global state variable
 *  and a typedef'd structure for no particular reason.
 *
 *  \remark <inttypes.h> for uintx_t, intx_t types and their printing macros
 *	\remark <stdbool.h> for boolean access
 *	\remark <arpa/inet.h> for ntohs and htons functions
 */
#include <inttypes.h>
#include <stdbool.h>
#include <arpa/inet.h>

/*! \fn main_param_generator(bool PARAM)
 * \brief A software buffer
 * \param PARAM The boolean to be generated
 *
 * \return PARAM.
 */
bool main_param_generator(const bool PARAM);


/*! \struct example_struct_t
 * \brief	This struct represents nothing at all.
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
 * \return x * 2, without modifying x.
 */
#define DOUBLE_RESULT(x) (2.0f * x)

/*! \def DOUBLE_STORE
 * \param x a numeric type
 * \return x * 2, and changes x.
 */
#define DOUBLE_STORE(x) (x *= 2.0f)


/*! \fn main_param_negator(bool, bool*)
 * \brief A software NOT gate
 * \param PARAM any boolean
 * \param[out] param a pointer to a boolean
 * \return PARAM not
 *
 * Notice this link?
 * #DOUBLE_RESULT
 */
bool main_param_negator(const bool PARAM, bool* const param);


/*! \fn buggy_needs_testing(void)
 * \brief a dummy function by dummy programmer that returns 2
 * \test Returns 0
 * \bug Does not do the function it was supposed to
 */
int buggy_needs_testing(void);


/*! \fn pointy_function(void*, void*)
 * \brief A function that takes input and puts it in output
 * \param[in] input the input
 * \param[out] output the input once again
 * @pre input not NULL, output not NULL
 * @post output has input, input not modified
 * @side well i modified your pointers, sir or madam, you tell me
 * \invariant input not gonna be mutated i promise
 */
void pointy_function(void* input, void* output);

#endif
