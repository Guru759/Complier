%option noyywrap
%{
    #include"common.h"
    #include"main.tab.hh"
%}

INTEGER [0-9]+
ID [[:alpha:]_][[:alpha:][:digit:]_]*

EOL (\r\n|\n)
WHITE [\t ]
%%

"true" {
    TreeNode *node = new TreeNode(NODE_BOOL);
    node->bool_val = true;
    yylval = node;
    return TRUE;
}
"false" {
    TreeNode *node = new TreeNode(NODE_BOOL);
    node->bool_val = false;
    yylval = node;
    return FALSE;
}

"int" return INT;
"void" return VOID;

"if" return IF;
"while" return WHILE;
"else" return ELSE;

"printf" return PRINTF;
"scanf" return SCANF;

"=" return ASSIGN;

"+" return ADD;

"!" return NOT;
"==" return EQUAL;

";" return SEMICOLON;
"(" return LPAREN;
")" return RPAREN;
"{" return LBRACE;
"}" return RBRACE;

{INTEGER} {
    TreeNode *node = new TreeNode(NODE_CONST);
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}
{ID} {
    TreeNode *node = new TreeNode(NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    return ID;
}
{EOL}
{WHITE}

%%



%option noyywrap
%option yylineno
%{
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
//yylineno = 0;
int i = 0;      // 跟踪符号表的index

int t = 0;      // 临时变量，暂存结果

// 结构体型符号表
struct SymbolTable{
    char *ID_name;
    int num;
    } ST[100];

%}

/* 正则表达式的定义 */
delim       [ \t\n]
ws          {delim}+
letter      [A-Za-z]
digit       [0-9]
/* 合法id开头是字母或下划线*/
id          ({letter}|_)({letter}|{digit})*
number      {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
/*number      [+-]?{digit}+(\.{digit}+)?(E[+-]?{digit}+)?*/
/*type        int|float*/

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

{ws}        {  }
if          { return(IF); }
then        { return(THEN); }
while       { return(WHILE); }
do          { return(DO); }
else        { return(ELSE); }
struct      { return(STRUCT); }
return      { return(RETURN); }
int         { return(INT); }
{id}        { return(ID); }
{number}    { return(NUMBER); }
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

%%

void writeout(int c){
    switch(c){
        case LT: fprintf(yyout, "LT        %s\n", yytext);break;
        case LE: fprintf(yyout, "LE        %s\n", yytext);break;
        case GT: fprintf(yyout, "GT        %s\n", yytext);break;
        case GE: fprintf(yyout, "GE        %s\n", yytext);break;
        case EQ: fprintf(yyout, "EQ        %s\n", yytext);break;
        case NE: fprintf(yyout, "NE        %s\n", yytext);break;
        case WHILE: fprintf(yyout, "WHILE     %s\n", yytext);break;
        case DO: fprintf(yyout, "DO        %s\n", yytext);break;
        case NUMBER: fprintf(yyout, "NUMBER    %s       %s\n", yytext,yytext);break;
        case ID: 
            if(i == 0){
                ST[i].ID_name = yytext;
                t = i;
                i++;
                //fprintf(yyout, "%d%s\n",i,"(1)");
            }
            else{
                int j = 0;
                while(j < i){
                    //fprintf(yyout, "%d%s\n",i,"(21)");
                    if(*ST[j].ID_name == *yytext){
                        t = j;
                        //fprintf(yyout, "%d%s\n",i,"(2)");
                        break;
                    }
                    j++;
                }
                if(j == i){
                    ST[i].ID_name = yytext;
                    t = i;
                    //fprintf(yyout, "%d%s\n",i,"(3)");
                    i++;
                }
            }
            fprintf(yyout, "ID        %s       %d\n", yytext, t);break;
        //case ID: fprintf(yyout, "ID        %s       %d\n", yytext,yylineno);break;
        case STRUCT: fprintf(yyout, "STRUCT    %s\n", yytext);break;
        case RETURN: fprintf(yyout, "RETURN    %s\n", yytext);break;
        case INT: fprintf(yyout, "INT       %s\n", yytext);break;
        case SEMI: fprintf(yyout, "SEMI      %s\n", yytext);break;
        case COMMA: fprintf(yyout, "COMMA     %s\n", yytext);break;
        case ASSIGN: fprintf(yyout, "ASSIGN    %s\n", yytext);break;
        case PLUS: fprintf(yyout, "PLUS      %s\n", yytext);break;
        case MINUS: fprintf(yyout, "MINUS     %s\n", yytext);break;
        case STAR: fprintf(yyout, "STAR      %s\n", yytext);break;
        case DIV: fprintf(yyout, "DIV       %s\n", yytext);break;
        case AND: fprintf(yyout, "AND       %s\n", yytext);break;
        case OR: fprintf(yyout, "OR        %s\n", yytext);break;
        case DOT: fprintf(yyout, "DOT       %s\n", yytext);break;
        case NOT: fprintf(yyout, "NOT       %s\n", yytext);break;
        case LP: fprintf(yyout, "LP        %s\n", yytext);break;
        case RP: fprintf(yyout, "RP        %s\n", yytext);break;
        case LB: fprintf(yyout, "LB        %s\n", yytext);break;
        case RB: fprintf(yyout, "RB        %s\n", yytext);break;
        case LC: fprintf(yyout, "LC        %s\n", yytext);break;
        case RC: fprintf(yyout, "RC        %s\n", yytext);break;
        default:break;
    }
    return;
}

int main (int argc, char ** argv){
    int c;
    int i = 0;
    if (argc>=2){
        if ((yyin = fopen(argv[1], "r")) == NULL){
            printf("Can't open file %s\n", argv[1]);
            return 1;
        }
        if (argc>=3){
            yyout=fopen(argv[2], "w");
        }
    }

    /* yyin和yyout是lex中定义的输入输出文件指针，它们指明了
     * lex生成的词法分析器从哪里获得输入和输出到哪里。
     * 默认：stdin，stdout。
     */
    while ((c = yylex()) != 0) {
        writeout(c);
        //fprintf(yyout, "%d\n", yylineno);
    }

    if(argc>=2){
        fclose(yyin);
        if (argc>=3) fclose(yyout);
    }
    return 0;
}