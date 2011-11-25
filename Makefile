LEX=flex
BISON=bison
CCFLAGS=-Wall
CC=gcc

.PHONY: test

test: src/main
	test/all.sh src/main test/samples

src/main: src/main.o src/parse.o src/lex.o

%.c %.h: %.y
	$(BISON) $(BISONFLAGS) '$<' -o '$*.c' --defines='$*.h'

src/lex.c: src/parse.h

clean:
	rm -f src/*.o src/parse.c src/parse.h src/lex.c src/main
