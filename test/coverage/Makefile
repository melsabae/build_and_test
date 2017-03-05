INC_DIR				=		../../include
LIB_DIR 			=		../../lib
SRC_DIR 			=		../../src

CC						=		gcc
CFLAGS				=		-Wall -std=gnu11 -ggdb3 -O0 -coverage

IDIR					=		-I $(INC_DIR)
LDIR					=		-L $(LIB_DIR)

_SOURCE				=		$(wildcard $(SRC_DIR)/*.c)
SOURCES				=		$(patsubst ../../src/%, %, $(_SOURCE))

_HEADER 			=		$(wildcard $(INC_DIR)/*.h)
HEADERS 			=		$(patsubst ../../include/%, %, $(_HEADER))

OBJECTS 			=		$(patsubst %.c, %.o, $(SOURCES))
GCOVS					=		$(patsubst %.c, %.gcno, $(SOURCES))
GCOVS					+=		$(patsubst %.c, %.gcda, $(SOURCES))
GCOVS					+=		$(patsubst %, %.gcov, $(SOURCES))

COVERAGE 			=		coverage

.NOTPARALLEL: all copy $(COVERAGE)
all: copy objects $(COVERAGE)

copy:
	@cp $(_SOURCE) ./
	@cp $(_HEADER) ./
	echo $(OBJECTS)

objects:
	$(CC) -c $(IDIR) $(LDIR) $(CFLAGS) $(SOURCES)

$(COVERAGE): objects
	$(CC) -o $(COVERAGE) $(IDIR) $(LDIR) $(CFLAGS) $(OBJECTS)
	gcov $(SOURCES)
	./$(COVERAGE)
	gcov $(SOURCES)

clean:
	$(RM) $(HEADERS) $(SOURCES) $(OBJECTS) $(COVERAGE) $(GCOVS)
