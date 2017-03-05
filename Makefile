BIN_DIR						=		bin
BUILD_DIR					=		build
DOC_DIR						=		doc
INC_DIR						=		include
LIB_DIR 					=		lib
SPIKE_DIR 				=		spike
SRC_DIR 					=		src

CC								=		gcc
CFLAGS						=		-O3 -Wall -std=gnu11
DFLAGS						=		-Wall -std=gnu11 -ggdb3 -Og
PFLAGS						=		-fprofile-arcs -ftest-coverage -O0

IDIR							=		-I $(INC_DIR)
LDIR							=		-L $(LIB_DIR)
LFLAGS						=

_SOURCES					+=	main.c
_SOURCES					+=	second_file.c
_SOURCES					+=	third_file.c
SOURCES 					=		$(patsubst %, $(SRC_DIR)/%, $(_SOURCES))
HEADERS						=		$(patsubst %.c, $(INC_DIR)/%.h, $(_SOURCES))
COMPILED_HEADERS	=		$(patsubst $(INC_DIR)/%, $(BUILD_DIR)/%.gch, $(HEADERS))
OBJECTS						=		$(patsubst %.c, $(BUILD_DIR)/%.o, $(_SOURCES))

_RELEASE					=		the_program
RELEASE 					=		$(patsubst %, $(BIN_DIR)/%, $(_RELEASE))
DEBUG							=		$(patsubst %, %_dbg, $(RELEASE))

all: tree_setup check $(RELEASE) $(DEBUG)

tree_setup: $(BIN_DIR) $(BUILD_DIR) $(DOC_DIR) $(INC_DIR) $(LIB_DIR) \
	$(SPIKE_DIR) $(SRC_DIR)

check: $(OBJECTS)

release: $(RELEASE)
debug: $(DEBUG)

.PRECIOUS: $(COMPILED_HEADERS)

$(RELEASE): $(OBJECTS)
	$(CC) -o $(RELEASE) $(CFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS) $(OBJECTS)
	strip -sxX $(RELEASE)

$(DEBUG): $(OBJECTS)
	$(CC) -o $(DEBUG) $(DFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS) $(OBJECTS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(BUILD_DIR)/%.h.gch
	$(CC) -c -o $@ $(IDIR) $(DFLAGS) $<

$(BUILD_DIR)/%.h.gch: $(INC_DIR)/%.h 
	$(CC) -c -x c-header -o $@ $<

clean:
	$(RM) $(RELEASE) $(DEBUG) $(OBJECTS) $(COMPILED_HEADERS)

