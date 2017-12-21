BIN_DIR						=		bin
BUILD_DIR					=		build
DOC_DIR						=		doc
INC_DIR						=		src
LIB_DIR 					=		lib
SPIKE_DIR 				=		spike
SRC_DIR 					=		src
COV_DIR						=		gcov
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

SOURCES 					=		$(wildcard $(SRC_DIR)/*.c)
HEADERS						=		$(patsubst $(SRC_DIR)/%.c, $(INC_DIR)/%.h, $(SOURCES))
COMPILED_HEADERS	=		$(patsubst $(INC_DIR)/%, $(BUILD_DIR)/%.gch, $(HEADERS))
OBJECTS						=		$(patsubst $(SRC_DIR)/%.c, $(BUILD_DIR)/%.o, $(SOURCES))
DOBJECTS					=		$(patsubst $(SRC_DIR)/%.c, $(DBG_DIR)/%.o, $(SOURCES))
GCNOS 						=		$(patsubst %.o, %.gcno, $(DOBJECTS))
DOXYFILE 					=		Doxyfile

.PRECIOUS: $(COMPILED_HEADERS)

all: tree_setup $(RELEASE) $(DEBUG) .tags

.tags:
	ctags -R -f .tags

dobjects: $(DOBJECTS)

tree_setup:
	@mkdir -p $(BIN_DIR) $(BUILD_DIR) $(DOC_DIR) $(INC_DIR) $(LIB_DIR) \
		$(SPIKE_DIR) $(SRC_DIR) $(DBG_DIR) $(COV_DIR)

test: $(DEBUG)
release: $(RELEASE)
debug: $(DEBUG)

docs:
	doxygen $(DOXYFILE)

$(RELEASE): $(OBJECTS)
	$(CC) -o $(RELEASE) $(CFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS) $(OBJECTS)
	strip -sxX $(RELEASE)

$(DEBUG): $(DOBJECTS)
	$(CC) -o $(DEBUG) $(DFLAGS) $(LDIR) $(INC_PATH) $(LFLAGS) $(DOBJECTS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c $(BUILD_DIR)/%.h.gch
	$(CC) -c -o $@ $(IDIR) $(CFLAGS) $<

$(DBG_DIR)/%.o: $(SRC_DIR)/%.c $(BUILD_DIR)/%.h.gch
	$(CC) -c -o $@ $(IDIR) $(DFLAGS) $<

$(BUILD_DIR)/%.h.gch: $(INC_DIR)/%.h
	$(CC) -c -x c-header -o $@ $<

clean:
	$(RM) $(RELEASE) $(DEBUG) $(OBJECTS) $(COMPILED_HEADERS) $(DBG_DIR)/* .tags
	$(RM) -rf $(COV_DIR)/* $(DOC_DIR)/html $(DOC_DIR)/latex gmon.out

profile: $(DEBUG)
	./tools/profile.sh 100

coverage: tree_setup $(DEBUG)
	gcov -bfm -o $(GCNOS) -s $(SRC_DIR)
	exec $(DEBUG)
	lcov -c -b . -d $(DBG_DIR) -o $(COV_DIR)/lcov
	genhtml $(COV_DIR)/lcov -o gcov -q --legend --demangle-cpp
	mv gmon.out gcov/

