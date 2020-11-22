//bison -d op3.y
//gcc -o op3 op3.tab.c
//./op3
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

// 为每个单词定义一种单词类别，且识别忽略空白字符以及识别多位十进制数字
%token NUMBER
%token ADD
%token SUB
%token MUL
%token DIV
%left ADD SUB
%left MUL DIV
%right UMINUS

%%


lines   :   lines expr ';' { printf("%f\n", $2); }
    | lines ';'
    |
    ;

expr    :   expr ADD expr { $$ = $1 + $3; }         // $n:第n个语法符号属性值
    | expr SUB expr { $$ = $1 - $3; }
    | expr MUL expr { $$ = $1 * $3; }
    | expr DIV expr { $$ = $1 / $3; }
    | '(' expr ')'  { $$ = $2; }
    | SUB expr %prec UMINUS { $$ = -$2; }           // %prec表示产生式的优先级和UMINUS一样,因为符号和减法一样，所以要设定一下
    | NUMBER
    ;


%%

// programs section

int yylex()
{
    // place your token retrieving code here
    int t ;
    while(1){
        t = getchar();
        // 识别空白符
        if (t == ' ' || t== '\t' || t == '\n')
            ;
        // 识别标识符
        else if(t == '+'){
            return ADD;
        }else if(t == '-'){
            return SUB;
        }else if(t == '*'){
            return MUL;
        }else if(t == '/'){
            return DIV;
        // 识别多位整数
        }else if (isdigit(t)) {
            yylval = 0;
            while (isdigit(t)) {
                yylval = yylval * 10 + t - '0';
                t = getchar ();
            }
            ungetc(t , stdin);          // t如果不是数字，要退回到缓冲区
            return NUMBER;
        }else {
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