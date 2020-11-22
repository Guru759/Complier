.PHONY: lc, lcc, clean

lc:
	flex sysy.l
	gcc lex.yy.c -o lc.out
	./lc.out

lcc:
	flex -+ sysycc.l
	g++ lex.yy.cc -o lcc.out
	./lcc.out

1:
	flex 1.l
	gcc lex.yy.c -o 1.out
	./1.out testin testout

2:
	flex  1.l
	gcc lex.yy.c -o 2.out
	./2.out test testout

3:
	flex 1.l
	gcc lex.yy.c -o 3.out
	./3.out <testin >testout

clean:
	rm *.out