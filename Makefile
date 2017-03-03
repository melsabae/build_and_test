BIN_DIR				=		bin
BUILD_DIR			=		build
DOC_DIR				=		doc
INC_DIR				=		include
LIB_DIR 			=		lib
SPIKE_DIR 		=		spike
SRC_DIR 			=		src

CC						=		gcc
CFLAGS				=		-O3 -Wall -std=gnu11
DFLAGS				=		-Wall -std=gnu11 -ggdb

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

all: .PHONY $(RELEASE) $(DEBUG)

release: $(RELEASE)
debug: $(DEBUG)

.PHONY: tree_setup check
tree_setup:
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(DOC_DIR)
	@mkdir -p $(INC_DIR)
	@mkdir -p $(LIB_DIR)
	@mkdir -p $(SPIKE_DIR)
	@mkdir -p $(SRC_DIR)

check: $(OBJECTS) $(HEADERS)


$(RELEASE): $(OBJECTS)
	$(CC) -o $(RELEASE) $(OBJECTS) $(CFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS)
	strip -sxX $(RELEASE)

$(DEBUG): $(OBJECTS)
	$(CC) -o $(DEBUG) $(OBJECTS) $(DFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) -c -o $@ $? $(IDIR)

$(SRC_DIR)/%.c: $(INC_DIR)/%.h

clean:
	$(RM) $(RELEASE) $(DEBUG) $(OBJECTS)

