%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno = 1;
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


/*{ws}        {  }*/
/*"struct"      { return K_STRUCT; }*/
/*{id}        { return(ID); }*/
/*{NUMBER}    { return NUMBER; }*/
/*"then"        { return K_THEN; }*/
/*"."         { return DOT; }*/
/*
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
*/
/*{WHITESPACE} /* do nothing */


/* 正则表达式的定义 */
delim       [ \t\n]
WHITESPACE  {delim}+
EOL	        (\r\n|\r|\n)
letter      [A-Za-z]
digit       [0-9]
/* 这里只保留了整形变量*/
INTEGER     [0-9]+

CHAR \'.?\'
STRING \".+\"

/* 合法id开头是字母或下划线*/
IDENTIFIER  ({letter}|_)({letter}|{digit})*
/*NUMBER      {digit}+(\.{digit}+)?(E[+-]?{digit}+)?*/

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

"if"          { return K_IF; }
"else"        { return K_ELSE; }

"while"       { return K_WHILE; }
"do"          { return K_DO; }
"for"         { return K_FOR; }
"return"      { return K_RETURN; }

"scanf"       { return F_SCANF; }
"printf"      { return F_PRINTF; }

"skip"        { return K_SKIP; }


"int"         { return T_INT; }
"bool"        { return T_BOOL; }
"char"        { return T_CHAR; }

"true"        { return TRUE; }
"false"       { return FALSE; }


"<"         { return OP_LT; }
"<="        { return OP_LE; }
"<>"|"!="   { return OP_NE; }
">"         { return OP_GT; }
">="        { return OP_GE; }
"=="        { return OP_EQ; }

";"         { return SEMI; }
","         { return COMMA; }


"="         { return OP_ASSIGN; }

"+"         { return OP_ADD; }
"-"         { return OP_SUB; }
"*"         { return OP_MUL; }
"/"         { return OP_DIV; }

"&&"        { return OP_AND; }
"||"        { return OP_OR; }
"!"         { return OP_NOT; }

"("         { return LP; }
")"         { return RP; }
"["         { return LB; }
"]"         { return RB; }
"{"         { return LC; }
"}"         { return RC; }

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

{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->int_val = yytext[1];
    yylval = node;
    return CHAR;
}

{STRING} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_STRING;
    node->str_val = string(yytext);
    yylval = node;
    return STRING;
}

{IDENTIFIER} {
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    return IDENTIFIER;
}



{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%