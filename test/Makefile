BUILD_DIR			=		../build
INC_DIR				=		../include
LIB_DIR 			=		../lib
SRC_DIR 			=		../src
TEST_DIR 			=		.
DBG_DIR				=		$(BUILD_DIR)/debug

CC						=		gcc
CFLAGS				=		-Wall -std=gnu11 -ggdb3 -O0 -coverage

IDIR					=		-I $(INC_DIR)
LDIR					=		-L $(LIB_DIR)
LFLAGS				=		-lcriterion

PRE 					=		test_
_SOURCE 			=		$(wildcard $(SRC_DIR)/*.c)
SOURCES 			=		$(patsubst %main.c, , $(_SOURCE))
HEADERS       =   $(patsubst $(SRC_DIR)/%.c, $(INC_DIR)/%.h, $(SOURCES))
OBJECTS       =   $(patsubst $(SRC_DIR)/%.c, $(DBG_DIR)/%.o, $(SOURCES))

_TEST_SOURCE 	+=	$(PRE)second_file.c
_TEST_SOURCE 	+=	$(PRE)third_file.c
_TEST_SOURCE 	+=	$(PRE)poorly_formatted.c

TEST_SOURCES 	=		$(patsubst %.c, $(TEST_DIR)/%.c, $(_TEST_SOURCE))
TEST_OBJECTS 	= 	$(patsubst %.c, %.o, $(TEST_SOURCES))
COV_OBJECTS		=		$(patsubst %.c, %.gcno, $(TEST_OBJECTS))

TESTS 				= 	$(patsubst %.c, $(TEST_DIR)/$(PRE)%, $(TEST_SOURCES))
ALL_TEST			=		test_all

all: $(ALL_TEST)

$(OBJECTS):
	cd .. && $(MAKE) debug

$(ALL_TEST): $(OBJECTS) $(TEST_OBJECTS)
	$(CC) -o $(ALL_TEST) $(TEST_OBJECTS) $(OBJECTS) $(CFLAGS) $(LDIR) $(LFLAGS)

$(TEST_DIR)/%.o: $(TEST_DIR)/%.c
	$(CC) -c -o $@ $< $(CFLAGS) $(IDIR)

$(TEST_DIR)/$(PRE)%.c: $(INC_DIR)/%.h

clean:
	$(RM) $(TESTS) $(TEST_OBJECTS) $(ALL_TEST) *.gcno *.gcda

coverage: $(ALL_TEST) $(COV_OBJECTS)
	./$(ALL_TEST)
	gcov $(TEST_SOURCES)
