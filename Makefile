BIN_DIR				=		bin
BUILD_DIR			=		build
DOC_DIR				=		doc
INC_DIR				=		include
LIB_DIR 			=		lib
SPIKE_DIR 		=		spike
SRC_DIR 			=		src

CC						=		gcc
CFLAGS				=		-O3 -Wall -std=gnu11

IDIR					=		-I $(INC_DIR)
LDIR					=		-L $(LIB_DIR)
LFLAGS				=		

_SOURCES			+=	main.c
_SOURCES			+=	second_file.c
_SOURCES			+=	third_file.c
SOURCES 			=		$(patsubst %, $(SRC_DIR)/%, $(_SOURCES))
HEADERS				=		$(patsubst %.c, $(INC_DIR)/%.h, $(_SOURCES))
OBJECTS				=		$(patsubst %.c, $(BUILD_DIR)/%.o, $(_SOURCES))

_RELEASE			=		the_program
RELEASE 			=		$(patsubst %, $(BIN_DIR)/%, $(_RELEASE))
DEBUG					=		$(patsubst %, %_dbg, $(RELEASE))

all: .PHONY $(RELEASE)

.PHONY: tree_setup 
tree_setup:
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(DOC_DIR)
	@mkdir -p $(INC_DIR)
	@mkdir -p $(LIB_DIR)
	@mkdir -p $(SPIKE_DIR)
	@mkdir -p $(SRC_DIR)

$(RELEASE): $(OBJECTS)
	$(CC) -o $(RELEASE) $(OBJECTS) $(CFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS)

$(TESTS): $(TEST_OBJECTS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c -o $@ $? $(CFLAGS)
	chmod -x $@ $?

$(SRC_DIR)/%.c: $(SRC_DIR)/%.h
	chmod -x $@ $<

$(TEST_BUILD_DIR)/test_%.o: $(TEST_DIR)/test_%.c $(OBJ_DIR)/%.o
	$(CC) -c -o $@ $< $(TEST_CFLAGS) $(TEST_LDIR) $(TEST_IDIR)

	$(CC) -o $(patsubst $(TEST_BUILD_DIR)/%.o, $(TEST_DIR)/%, $@) \
	$< $(patsubst $(TEST_BUILD_DIR)/test_%.o, $(OBJ_DIR)/%.o, $@) \
	$(TEST_CFLAGS) $(TEST_LDIR) $(TEST_IDIR) $(TEST_LFLAGS)

	chmod -x $@ $<

clean:
	$(RM) $(RELEASE) $(OBJECTS) $(TEST_OBJECTS)

