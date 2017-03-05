BIN_DIR						=		bin
BUILD_DIR					=		build
DOC_DIR						=		doc
INC_DIR						=		include
LIB_DIR 					=		lib
SPIKE_DIR 				=		spike
SRC_DIR 					=		src
DBG_DIR						=		$(BUILD_DIR)/debug

CC								=		gcc
CFLAGS						=		-O3 -Wall -Wextra -std=gnu11
DFLAGS						=		-Wall -Wextra -std=gnu11 -ggdb3 -Og -pg -coverage

IDIR							=		-I $(INC_DIR)
LDIR							=		-L $(LIB_DIR)
LFLAGS						=

_RELEASE					=		the_program
RELEASE 					=		$(patsubst %, $(BIN_DIR)/%, $(_RELEASE))
DEBUG							=		$(patsubst %, %_dbg, $(RELEASE))

_SOURCES					+=	main.c
_SOURCES					+=	second_file.c
_SOURCES					+=	third_file.c
SOURCES 					=		$(patsubst %, $(SRC_DIR)/%, $(_SOURCES))
HEADERS						=		$(patsubst %.c, $(INC_DIR)/%.h, $(_SOURCES))
COMPILED_HEADERS	=		$(patsubst $(INC_DIR)/%, $(BUILD_DIR)/%.gch, $(HEADERS))
OBJECTS						=		$(patsubst %.c, $(BUILD_DIR)/%.o, $(_SOURCES))
DOBJECTS					=		$(patsubst %.c, $(DBG_DIR)/%.o, $(_SOURCES))
GCNOS 						=		$(patsubst %.o, %.gcno, $(DOBJECTS))
DOXYFILE 					=		Doxyfile

all: tree_setup $(RELEASE) $(DEBUG)

tree_setup:
	@mkdir -p $(BIN_DIR) $(BUILD_DIR) $(DOC_DIR) $(INC_DIR) $(LIB_DIR) \
		$(SPIKE_DIR) $(SRC_DIR) $(DBG_DIR)

test: $(OBJECTS)
release: $(RELEASE)
debug: $(DEBUG)

$(RELEASE): $(OBJECTS)
	$(CC) -o $(RELEASE) $(CFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS) $(OBJECTS)
	strip -sxX $(RELEASE)
	doxygen $(DOXYFILE)

$(DEBUG): $(DOBJECTS)
	$(CC) -o $(DEBUG) $(DFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS) $(DOBJECTS)
	doxygen $(DOXYFILE)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(BUILD_DIR)/%.h.gch
	$(CC) -c -o $@ $(IDIR) $(CFLAGS) $<

$(DBG_DIR)/%.o: $(SRC_DIR)/%.c $(BUILD_DIR)/%.h.gch
	$(CC) -c -o $@ $(IDIR) $(DFLAGS) $<

$(BUILD_DIR)/%.h.gch: $(INC_DIR)/%.h
	$(CC) -c -x c-header -o $@ $<

clean:
	$(RM) $(RELEASE) $(DEBUG) $(OBJECTS) $(COMPILED_HEADERS) $(DBG_DIR)/*
	$(RM) gmon.out *.gcov

profile: $(DEBUG)
	./tools/profile.sh 100

coverage: $(DEBUG)
	$(DEBUG) 2>&1 > /dev/null
	$(foreach i, $(GCNOS), gcov -bar -s $(SRC_DIR) $i;)


