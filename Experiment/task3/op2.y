//bison -d op2.y
//gcc -o op2 op2.tab.c
//./op2


// 识别忽略空白字符以及识别多位十进制数字
%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%


lines : lines expr ';' { printf("%f\n", $2); }
 | lines ';'
 |
 ;
 
expr : expr '+' expr { $$ = $1 + $3; }
 | expr '-' expr { $$ = $1 - $3; }
 | expr '*' expr { $$ = $1 * $3; }
 | expr '/' expr { $$ = $1 / $3; }
 | '(' expr ')' { $$ = $2; }
 | '-' expr %prec UMINUS { $$ = -$2; }
 | NUMBER
 ;



%%

// programs section

int yylex()
{
// place your token retrieving code here
    int t;
    while(1){
        t = getchar();
        if (t == ' ' || t == '\t' || t == '\n')
            ;
        else if(isdigit(t)){
            yylval = 0;
            while(isdigit(t)){
            yylval = yylval * 10 + t - '0';
            t = getchar();
        }
        ungetc(t , stdin); // t如果不是数字，要退回到缓冲区
        return NUMBER;
        }
        else{
        return t; }
    // return getchar();
    }
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