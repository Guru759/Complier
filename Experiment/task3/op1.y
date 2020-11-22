//bison -d op1.y
//gcc -o op1 op1.tab.c
//./op1


// 为每个单词定义一种单词类别
%{
#include <stdio.h>
#include <stdlib.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

// 更新token,将符号转化为标识符
//%token NUMBER
%token ADD
%token SUB
%token MUL
%token DIV
%left ADD SUB
%left MUL DIV
%right UMINUS

%%

// 由于后面会有对空格,tab,换行进行识别，所以'\n'换为';'
lines   :   lines expr '\n' { printf("%f\n", $2); }
    | lines '\n'
    |
    ;

expr    :   expr ADD expr { $$ = $1 + $3; }         // $n:第n个语法符号属性值
    | expr SUB expr { $$ = $1 - $3; }
    | expr MUL expr { $$ = $1 * $3; }
    | expr DIV expr { $$ = $1 / $3; }
    | '(' expr ')'  { $$ = $2; }
    | SUB expr %prec UMINUS { $$ = -$2; }
    | NUMBER
    ;

NUMBER  :   '0' { $$ = 0.0; }
    | '1'       { $$ = 1.0; }
    | '2'       { $$ = 2.0; }
    | '3'       { $$ = 3.0; }
    | '4'       { $$ = 4.0; }
    | '5'       { $$ = 5.0; }
    | '6'       { $$ = 6.0; }
    | '7'       { $$ = 7.0; }
    | '8'       { $$ = 8.0; }
    | '9'       { $$ = 9.0; }
    ;

%%

// programs section

int yylex()
{
    // place your token retrieving code here
    int t ;
    while (1) {
        t = getchar ();
        if(t == '+'){
            return ADD;
        }else if(t == '-'){
            return SUB;
        }else if(t == '*'){
            return MUL;
        }else if(t == '/'){
            return DIV;
        }
        else {
        return t ;
        }
    }
    // return getchar();
}

int main(void)
{
    yyin = stdin;
    do {
            yyparse();
    } while (! feof (yyin));
    return 0;
}
void yyerror(const char* s) {
    fprintf (stderr , "Parse error : %s\n", s);
    exit(1);
}