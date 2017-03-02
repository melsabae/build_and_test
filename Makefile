CC						=		gcc
CFLAGS				=		-O3 -Wall -std=gnu11
TEST_CFLAGS		=		-Wall 

SRC_DIR				=		src
OBJ_DIR				=		obj
TEST_DIR			=		test
TEST_OBJ_DIR	=		$(TEST_DIR)/obj
LIB_DIR				=		lib

IDIR					=		-I $(SRC_DIR)/
LDIR					=
LFLAGS				=		

TEST_IDIR			=		$(IDIR) -I $(LIB_DIR)/criterion/include/criterion/
TEST_LDIR			=		$(LDIR) -L $(LIB_DIR)/criterion/build/
TEST_LFLAGS		=		$(LIB_DIR)/criterion/build/libcriterion.so

_SOURCES			+=	main.c
_SOURCES			+=	second_file.c
_SOURCES			+=	third_file.c
SOURCES 			=		$(patsubst %, $(SRC_DIR)/%, $(_SOURCES))
HEADERS				=		$(SOURCE:.c=.h)
OBJECTS				=		$(patsubst %.c, $(OBJ_DIR)/%.o, $(_SOURCES))

_TEST_SOURCES	+=	test_second_file.c
_TEST_SOURCES	+=	test_third_file.c
TEST_SOURCES	=		$(patsubst %, $(TEST_DIR)/%, $(_TEST_SOURCES))
TEST_OBJECTS	=		$(patsubst %.c, $(TEST_OBJ_DIR)/%.o, $(_TEST_SOURCES))

EXECUTABLE		=		the_program
TESTS 				=		$(patsubst %.c, $(TEST_DIR)/%, $(TEST_SOURCES))

all: .PHONY $(EXECUTABLE) $(TESTS)

.PHONY: tree_setup 
tree_setup:
	@mkdir -p $(SRC_DIR)
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(TEST_DIR)
	@mkdir -p $(TEST_OBJ_DIR)
	@mkdir -p $(LIB_DIR)

$(EXECUTABLE): $(OBJECTS)
	$(CC) -o $(EXECUTABLE) $(OBJECTS) $(CFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS)

$(TESTS): $(TEST_OBJECTS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c -o $@ $? $(CFLAGS)
	chmod -x $@ $?

$(SRC_DIR)/%.c: $(SRC_DIR)/%.h
	chmod -x $@ $<

$(TEST_OBJ_DIR)/test_%.o: $(TEST_DIR)/test_%.c $(OBJ_DIR)/%.o
	$(CC) -c -o $@ $< $(TEST_CFLAGS) $(TEST_LDIR) $(TEST_IDIR)

	$(CC) -o $(patsubst $(TEST_OBJ_DIR)/%.o, $(TEST_DIR)/%, $@) \
	$< $(patsubst $(TEST_OBJ_DIR)/test_%.o, $(OBJ_DIR)/%.o, $@) \
	$(TEST_CFLAGS) $(TEST_LDIR) $(TEST_IDIR) $(TEST_LFLAGS)

	chmod -x $@ $<

clean:
	$(RM) $(EXECUTABLE) $(OBJECTS) $(TEST_OBJECTS)

