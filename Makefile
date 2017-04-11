all: calc.y calc.lex
	bison -d calc.y
	flex  -o calc.lex.c calc.lex
	gcc  -o calc calc.lex.c calc.tab.c -lm -std=c99
