%option noyywrap
%top{
#include<map>
#include<iomanip>
#include<fstream>
using namespace std;
}
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


//map<charint> ID_name;
//ID_name.insert(pair<charint>('a'100));

/*pair<map<charint>::iteratorbool> ret;
ret = mymap.insert(pair<charint>('z'500));
    if (ret.second == false) {
        cout << "element 'z' already existed";
        cout << " with a value of " << ret.first->second << '\n';
    }
*/



%}

delim       [ \t\n]
ws          {delim}+
letter      [A-Za-z]
digit       [0-9]
id          {letter}({letter}|{digit})*
/*number      [+-]?{digit}+(\.{digit}+)?(E[+-]?{digit}+)?*/
number      {digit}+(\.{digit}+)?(E[+-]?{digit}+)?
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
    ofstream output("./testout");
    switch(c){
        case LT: output<<setw(8)<<"LT"<<setw(8)<<yytext<<endl;break;
        case LE: output<<setw(8)<<"LE"<<setw(8)<<yytext<<endl;break;
        case GT: output<<setw(8)<<"GT"<<setw(8)<<yytext<<endl;break;
        case GE: output<<setw(8)<<"GE"<<setw(8)<<yytext<<endl;break;
        case EQ: output<<setw(8)<<"EQ"<<setw(8)<<yytext<<endl;break;
        case NE: output<<setw(8)<<"NE"<<setw(8)<<yytext<<endl;break;
        case WHILE: output<<setw(8)<<"WHILE"<<setw(8)<<yytext<<endl;break;
        case DO: output<<setw(8)<<"DO"<<setw(8)<<yytext<<endl;break;
        case NUMBER: output<<setw(8)<<"NUMBER"<<setw(8)<<yytext<<endl;break;
        case ID: output<<setw(8)<<"ID"<<setw(8)<<yytext<<endl;break;
        //case ID: output<<setw(8)<<"ID"<<setw(8)<<yytext<<endlyylineno);break;
        case STRUCT: output<<setw(8)<<"STRUCT"<<setw(8)<<yytext<<endl;break;
        case RETURN: output<<setw(8)<<"RETURN"<<setw(8)<<yytext<<endl;break;
        case INT: output<<setw(8)<<"INT"<<setw(8)<<yytext<<endl;break;
        case SEMI: output<<setw(8)<<"SEMI"<<setw(8)<<yytext<<endl;break;
        case COMMA: output<<setw(8)<<"COMMA"<<setw(8)<<yytext<<endl;break;
        case ASSIGN: output<<setw(8)<<"ASSIGN"<<setw(8)<<yytext<<endl;break;
        case PLUS: output<<setw(8)<<"PLUS"<<setw(8)<<yytext<<endl;break;
        case MINUS: output<<setw(8)<<"MINUS"<<setw(8)<<yytext<<endl;break;
        case STAR: output<<setw(8)<<"STAR"<<setw(8)<<yytext<<endl;break;
        case DIV: output<<setw(8)<<"DIV"<<setw(8)<<yytext<<endl;break;
        case AND: output<<setw(8)<<"AND"<<setw(8)<<yytext<<endl;break;
        case OR: output<<setw(8)<<"OR"<<setw(8)<<yytext<<endl;break;
        case DOT: output<<setw(8)<<"DOT"<<setw(8)<<yytext<<endl;break;
        case NOT: output<<setw(8)<<"NOT"<<setw(8)<<yytext<<endl;break;
        case LP: output<<setw(8)<<"LP"<<setw(8)<<yytext<<endl;break;
        case RP: output<<setw(8)<<"RP"<<setw(8)<<yytext<<endl;break;
        case LB: output<<setw(8)<<"LB"<<setw(8)<<yytext<<endl;break;
        case RB: output<<setw(8)<<"RB"<<setw(8)<<yytext<<endl;break;
        case LC: output<<setw(8)<<"LC"<<setw(8)<<yytext<<endl;break;
        case RC: output<<setw(8)<<"RC"<<setw(8)<<yytext<<endl;break;
        default:break;
    }
    return;
}

int main(){
    int c;
    ifstream input("./testin");
    ofstream output("./testout");
    yyFlexLexer lexer(&input);
    //lexer.yylex();
    while ((c = lexer.yylex()) != 0) {
        writeout(c);
    }
    //output<<setw(8)<<lines<<setw(8)<<words<<setw(8)<<chars<<endl;
    return 0;
}