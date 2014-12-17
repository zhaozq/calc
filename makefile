MAIN=calc

$(MAIN): $(MAIN).y $(MAIN).lex
	bison --yacc -dv $@.y
	flex $@.lex
	gcc -o $@ y.tab.c lex.yy.c

cla:
	rm -f calc
	make cl

cl:
	rm -f *.c *.output *.h

run:
	calc
