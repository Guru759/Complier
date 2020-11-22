%option noyywrap
%top{
#include<math.h>
}
%{
    int chars=0, words=0, lines=0;
%}

word [a-zA-Z]+
line \n
char .

%%

{word} {words++;chars+=strlen(yytext);}
{line} {lines++;}
{char} {chars++;}

%%
int main(){
    yylex();
    fprintf(yyout,"%8d%8d%8d\n",lines,words,chars);
    return 0;
}