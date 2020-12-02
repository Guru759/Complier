%option noyywrap
%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno = 1;
%}

delim       [ \t]
WHITESPACE  {delim}+
BLOCKCOMMENT(\/\*(.|\n)*\/)
LINECOMMENT (\/\/[^\n]*) 
EOL	        (\r\n|\r|\n)
letter      [A-Za-z]
digit       [0-9]
INTEGER     [0-9]+

CHARS \'.?\'
STRINGS \".+\"

IDENTIFIER  ({letter}|_)({letter}|{digit})*


%%

{WHITESPACE}    /* do nothing */
{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}   /* do nothing */



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
"string"      { return T_STRING; }
"void"        { return T_VOID; }

"true"        { return TRUE; }
"false"       { return FALSE; }


"<"         { return LOP_LT; }
"<="        { return LOP_LE; }
"<>"|"!="   { return LOP_NE; }
">"         { return LOP_GT; }
">="        { return LOP_GE; }
"=="        { return LOP_EQ; }

";"         { return SEMI; }
","         { return COMMA; }


"="         { return LOP_ASSIGN; }

"+"         { return LOP_ADD; }
"-"         { return LOP_SUB; }
"*"         { return LOP_MUL; }
"/"         { return LOP_DIV; }
"%"         { return LOP_REM; }

"&&"        { return LOP_AND; }
"||"        { return LOP_OR; }
"!"         { return LOP_NOT; }

"("         { return LP; }
")"         { return RP; }
"["         { return LB; }
"]"         { return RB; }
"{"         { return LC; }
"}"         { return RC; }



{INTEGER} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}

{CHARS} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->str_val = yytext[1];
    //node->int_val = yytext[1];
    yylval = node;
    return CHARS;
}

{STRINGS} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_STRING;
    node->str_val = string(yytext);
    yylval = node;
    return STRINGS;
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