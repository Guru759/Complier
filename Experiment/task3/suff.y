//bison -d suff.y
//gcc -o suff suff.tab.c
//./suff


// 中缀表达式转后缀表达式
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
char idStr[50];
char numStr[50];
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

%token NUMBER
%token ID
%token ADD
%token SUB
%token MUL
%token DIV
%left ADD SUB
%left MUL DIV
%right UMINUS

%%


lines   :   lines expr '\n' { printf("%s\n", $2); }
    | lines '\n'
    |
    ;

expr    :   expr ADD expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"+ "); }         // $n:第n个语法符号属性值
    | expr SUB expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"- "); }
    | expr MUL expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"* "); }
    | expr DIV expr { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"/ "); }
    | '(' expr ')'  { $$ = (char *)malloc(50*sizeof(char)); strcpy($$,$2); }
    | SUB expr %prec UMINUS { $$ = (char *)malloc(50*sizeof(char)); strcpy($$, $2); strcat($$,"- "); }
    | NUMBER        { $$ = (char *)malloc(50*sizeof(char)); strcpy($$, $1); strcat($$," ");}
    | ID            { $$ = (char *)malloc(50*sizeof(char)); strcpy($$, $1); strcat($$," ");}
    ;

%%

// programs section

int yylex()
{
    // place your token retrieving code here
    int t;
    while(1){
        t = getchar();
        // 识别到空白符
        if(t == ' ' || t== '\t')            
            ;
        // 识别多位整数
        else if(( t >= '0' && t <= '9' )){
            int ti = 0;
            while(( t >= '0' && t <= '9' )){
                numStr[ti] = t;
                t = getchar();
                ti++;
            }
            // 字符串后加\0表示结束
            numStr[ti] = '\0';
            yylval = numStr;
            // 识别到的不是数字退回
            ungetc(t, stdin);
            return NUMBER;
        }
        // 识别标识符（首元素可以是字母或下划线）
        else if(( t >= 'a' && t <= 'z' ) || ( t >= 'A' && t<= 'Z' ) || ( t == '_' )){
            int ti = 0;
            while(( t >= 'a' && t <= 'z' ) || ( t >= 'A' && t<= 'Z' ) || ( t == '_') || ( t >= '0' && t <= '9' )){
                idStr[ti] = t;
                ti++;
                t = getchar();
            }
            idStr[ti] = '\0';
            yylval = idStr;
            ungetc(t, stdin);
            return ID;
        }
        // 识别运算符
        else if(t == '+')
        return ADD;
        else if(t == '-')
        return SUB;
        else if(t == '*')
        return MUL;
        else if(t == '/')
        return DIV;
        // 识别完毕退出
        else { return t; }
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