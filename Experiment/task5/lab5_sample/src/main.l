%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno = 1;

/* 明示常量的定义 */
#define IF 1
#define THEN 2
#define ELSE 3
#define ID 4
#define NUMBER 5
#define EQ 6
#define DO 7
#define WHILE 8
#define SEMI 9
#define COMMA 10
#define ASSIGN 11
#define PLUS 12
#define MINUS 13
#define STAR 14
#define DIV 15
#define AND 16
#define OR 17
#define DOT 18
#define NOT 19
#define INT 20
#define LP 21
#define RP 22
#define LB 23
#define RB 24
#define LC 25
#define RC 26
#define STRUCT 28
#define RETURN 29
#define LT 30
#define LE 31
#define GT 32
#define GE 33
#define NE 34
%}

/*
BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
EOL	(\r\n|\r|\n)
WHILTESPACE [[:blank:]]

INTEGER [0-9]+
DOUBLE ([0-9]+)?(\.[0-9]+)([eE](\+|-)?[0-9]+)?

CHAR \'.?\'
STRING \".+\"

IDENTIFIER [[:alpha:]_][[:alpha:][:digit:]_]*
RESERVED "auto"|"enum"|"signed"|"sizeof"|"static"|"struct"|"typedef"|"union"|"unsigned"|"volatile"
%%

{BLOCKCOMMENT}  /* do nothing */
/*{LINECOMMENT}  /* do nothing */

/*
{RESERVED} cerr<<"[line"<<lineno<<"] reserve token:"<<yytext<<endl;

"int" return T_INT;
"bool" return T_BOOL;
"char" return T_CHAR;

"=" return LOP_ASSIGN;

";" return  SEMICOLON;
*/
/* 正则表达式的定义 */
delim       [ \t\n]
WHITESPACE  {delim}+
EOL	        (\r\n|\r|\n)
letter      [A-Za-z]
digit       [0-9]
INTEGER     [0-9]+
/* 合法id开头是字母或下划线*/
IDENTIFIER  ({letter}|_)({letter}|{digit})*
NUMBER      {digit}+(\.{digit}+)?(E[+-]?{digit}+)?

/*识别多行注释*/
commentbegin "/*"
commentelement .|\n
commentend "*/"
%x COMMENT
/*识别单行注释*/
commbegin "//"
commelement .
commend  \n
%x COMM

%%

{WHITESPACE} /* do nothing */
/*{ws}        {  }*/
if          { return K_IF; }
else        { return K_ELSE; }
then        { return K_THEN; }
while       { return K_WHILE; }
do          { return K_DO; }
for         { return K_FOR; }
return      { return K_RETURN; }

scanf       { return F_RETURN; }
printf      { return F_RETURN; }

skip        { return K_SKIP; }
struct      { return K_STRUCT; }

int         { return T_INT; }
bool        { return T_BOOL; }
char        { return T_CHAR; }

true        { return TRUE; }
false       { return FALSE; }
/*{id}        { return(ID); }*/
{NUMBER}    { return(NUMBER); }
"<"         { return(LT); }
"<="        { return(LE); }
"<>"|"!="   { return(NE); }
">"         { return(GT); }
">="        { return(GE); }
"=="        { return(EQ); }
";"         { return(SEMI); }
","         { return(COMMA); }
"="         { return(ASSIGN); }
"+"         { return(PLUS); }
"-"         { return(MINUS); }
"*"         { return(STAR); }
"/"         { return(DIV); }
"&&"        { return(AND); }
"||"        { return(OR); }
"."         { return(DOT); }
"!"         { return(NOT); }
"("         { return(LP); }
")"         { return(RP); }
"["         { return(LB); }
"]"         { return(RB); }
"{"         { return(LC); }
"}"         { return(RC); }

{commentbegin} {BEGIN COMMENT;}
<COMMENT>{commentelement} {}
<COMMENT>{commentend} {BEGIN INITIAL;}
{commbegin} {BEGIN COMM;}
<COMM>{commelement} {}
<COMM>{commend} {BEGIN INITIAL;}


{INTEGER} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}
{INT} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = yytext[1];
    yylval = node;
    return INT;
}
{BOOL} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_BOOL;
    node->int_val = yytext[1];
    yylval = node;
    return BOOL;
}
{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->int_val = yytext[1];
    yylval = node;
    return CHAR;
}
{IDENTIFIER} {
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    return IDENTIFIER;
}

/*{WHITESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%