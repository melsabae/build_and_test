BUILD_DIR			=		$(realpath ../build)
INC_DIR				=		$(realpath ../include)
LIB_DIR 			=		$(realpath ../lib)
SRC_DIR 			=		$(realpath ../src)
TEST_DIR 			=		$(realpath .)

CC						=		gcc
CFLAGS				=		-Wall -std=gnu11 -g

IDIR					=		-I $(INC_DIR)
LDIR					=		-L $(LIB_DIR)
LFLAGS				=		-lcriterion

#_SOURCES			+=	main.c
_SOURCES			+=	second_file.c
_SOURCES			+=	third_file.c
SOURCES 			=		$(patsubst %, $(SRC_DIR)/%, $(_SOURCES))
HEADERS				=		$(patsubst %.c, $(INC_DIR)/%.h, $(_SOURCES))
OBJECTS				=		$(patsubst %.c, $(BUILD_DIR)/%.o, $(_SOURCES))

_TEST_SOURCE	+=	second_file.c
_TEST_SOURCE	+=	third_file.c
TEST_PRE			=		test_
TEST_SOURCES	=		$(patsubst %, $(TEST_DIR)/$(TEST_PRE)%, $(_TEST_SOURCE))
TEST_OBJECTS 	= 	$(patsubst %.c, $(TEST_DIR)/$(TEST_PRE)%.o, $(_TEST_SOURCE))
TESTS 				= 	$(patsubst %.c, $(TEST_DIR)/$(TEST_PRE)%, $(_TEST_SOURCE))

.PHONY:
	cd .. && $(MAKE) check

all: .PHONY $(TESTS)

$(TESTS): $(HEADERS) $(OBJECTS) $(TEST_OBJECTS)

$(TEST_DIR)/$(TEST_PRE)%.o: $(TEST_DIR)/$(TEST_PRE)%.c
	$(CC) -c -o $@ $< $(CFLAGS) $(IDIR)
	$(CC) -o $(patsubst %.o, %, $@) $@ $(OBJECTS) $(CFLAGS) $(LDIR) $(LFLAGS)

clean:
	$(RM) $(TESTS) $(TEST_OBJECTS)

