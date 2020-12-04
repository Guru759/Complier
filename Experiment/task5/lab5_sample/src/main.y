%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}
%start program

%token IDENTIFIER INTEGER CHARS BOOL STRINGS
%token TRUE FALSE
%token K_SKIP K_WHILE K_FOR K_IF K_ELSE K_RETURN F_SCANF F_PRINTF K_CONST K_DO
%token T_CHAR T_INT T_STRING T_BOOL T_VOID 
%token LOP_ADD LOP_SUB LOP_MUL LOP_DIV LOP_REM
%token LOP_AND LOP_OR LOP_NOT
%token LOP_EQ LOP_LT LOP_LE LOP_GT LOP_GE LOP_NE 
%token LOP_ASSIGN LOP_ADDA LOP_SUBA
%token LOP_ADAD LOP_SBSB
%token SEMI // ;
%token LP RP LB RB LC RC


/* 排序是优先级*/
%left LOP_ADAD LOP_SBSB

%right COMMA    // ,

%left LOP_MUL LOP_DIV LOP_REM
%left LOP_ADD LOP_SUB
%left LOP_EQ LOP_LT LOP_LE LOP_GT LOP_GE LOP_NE

%right LOP_NOT

%left LOP_AND 
%left LOP_OR

%right LOP_ASSIGN LOP_ADDA LOP_SUBA
%right MINUS PLUS
%nonassoc LOWER_THEN_ELSE
%nonassoc K_ELSE

%%

program
: statements {root = new TreeNode(0, NODE_PROG); root->addChild($1);};

statements
: statement {$$=$1;}
| statements statement {$$=$1; $$->addSibling($2);}
;
// 检查行号问题
comstatement
: statements {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_COM;
    node->addChild($1);
    $$ = node; 
}

comstatement
: SEMI  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| K_SKIP SEMI  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| declaration SEMI {$$ = $1;}
| assignment SEMI {$$ = $1;}
| op_assignment SEMI {$$ = $1;}
| printf SEMI {$$ = $1;}
| scanf SEMI {$$ = $1;}
| if_else {$$ = $1;}
| while  {$$ = $1;}
| for  {$$ = $1;}
| function {$$ = $1;}
| return SEMI {$$ = $1;}
;

statement
: SEMI  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| K_SKIP SEMI  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| declaration SEMI {$$ = $1;}
| assignment SEMI {$$ = $1;}
| op_assignment SEMI {$$ = $1;}
| printf SEMI {$$ = $1;}
| scanf SEMI {$$ = $1;}
| if_else {$$ = $1;}
| while  {$$ = $1;}
| for  {$$ = $1;}
| function {$$ = $1;}
| return SEMI {$$ = $1;}
| LC statements RC {$$=$2;}
;

declaration
: T IDENTIFIER LOP_ASSIGN expr{  // declare and init
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    node->addChild($4);
    $$ = node;   
}
| T IDENTIFIER {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    $$ = node;
}
| K_CONST T IDENTIFIER {
    TreeNode* node = new TreeNode($2->lineno, NODE_STMT);
    node->stype = STMT_CONST;
    node->addChild($2);
    node->addChild($3);
    $$ = node;
}
/*
| declaration COMMA IDENTIFIER {$$=$1; $$->addSibling($3);}
| declaration COMMA assignment {$$=$1; $$->addSibling($3);}
*/
| declaration COMMA IDENTIFIER {$$=$1; $$->addChild($3);}
| declaration COMMA assignment {$$=$1; $$->addChild($3);}
;


/*
declaration
: T idlist{  // declare and init
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    $$ = node;   
}
;

idlist
: idlist COMMA IDENTIFIER {$$=$1; $$->addSibling($3);}   
| idlist COMMA assignment {$$=$1; $$->addSibling($3);}
| IDENTIFIER    {$$ = $1;}
| assignment    {$$ = $1;}
;
*/

assignment
: IDENTIFIER LOP_ASSIGN expr {
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($3);
    $$ = node;  
}
;

op_assignment
: IDENTIFIER LOP_ADDA expr {
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| IDENTIFIER LOP_SUBA expr {
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($3);
    $$ = node;  
}
| IDENTIFIER LOP_ADAD {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($2);
    $$ = node;
}
| IDENTIFIER LOP_SBSB {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($2);
    $$ = node;
}
;

printf
: F_PRINTF LP expr RP{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_PRINTF;
    node->addChild($3);
    $$ = node;  
}
;

scanf
: F_SCANF LP expr RP{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_SCANF;
    node->addChild($3);
    $$ = node;  
}
;

if_else
: K_IF LP b_expr RP comstatement K_ELSE comstatement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_IF_ELSE;
    node->addChild($3);
    node->addChild($5);
    node->addChild($7);
    $$ = node;
}
| K_IF LP b_expr RP comstatement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_IF_ELSE;
    node->addChild($3);
    node->addChild($5);
    $$ = node;
}
;

/*
if_else
: K_IF LP b_expr RP statement %prec LOWER_THEN_ELSE {
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_IF_ELSE;
    node->addChild($3);
    node->addChild($5);
    $$ = node;
}
| K_IF LP b_expr RP statement K_ELSE statement {
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_IF_ELSE;
    node->addChild($3);
    node->addChild($5);
    node->addChild($7);
    $$ = node;
}
;
*/

while
: K_WHILE LP b_expr RP statement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_WHILE;
    node->addChild($3);
    node->addChild($5);
    $$ = node;
}
;

for
: K_FOR LP declaration SEMI b_expr SEMI assignment RP statement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_FOR;
    node->addChild($3);
    node->addChild($5);
    node->addChild($7);
    node->addChild($9);
    $$ = node;
}
;

function
: T IDENTIFIER LP RP statement {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_FUNC;
    node->addChild($1);
    node->addChild($2);
    node->addChild($5);
    $$ = node;   
}
;

return
: K_RETURN expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_STMT);
    node->stype = STMT_RETURN;
    node->addChild($2);
    $$ = node; 
}

expr
: IDENTIFIER {
    $$ = $1;
}
| INTEGER {
    $$ = $1;
}
| CHARS {
    $$ = $1;
}
| STRINGS {
    $$ = $1;
}
| expr LOP_ADD expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_ADD;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr LOP_SUB expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_SUB;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr LOP_MUL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_MUL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr LOP_DIV expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_DIV;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr LOP_REM expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_REM;
    node->addChild($1);
    node->addChild($3);
    $$ = node;  
}
| LP expr RP  { $$ = $2; }
| LOP_ADD expr %prec PLUS { $$ = $2; }
| LOP_SUB expr %prec MINUS {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->optype = OP_SUB;
    node->addChild($1);
    node->addChild($2);
    $$ = node;
}// %prec表示产生式的优先级和UMINUS一样,因为符号和减法一样，所以要设定一下   
;


b_expr
: expr LOP_EQ expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_EQ;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| expr LOP_LT expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_LT;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| expr LOP_LE expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_LE;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| expr LOP_GT expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_GT;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| expr LOP_GE expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_GE;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| expr LOP_NE expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_NE;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| LOP_NOT b_expr{
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->optype = OP_NOT;
    node->addChild($1);
    node->addChild($2);
    $$ = node;  
}
| b_expr LOP_AND b_expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_AND;
    node->addChild($1);
    node->addChild($3);
    $$ = node; 
}
| b_expr LOP_OR b_expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_OR;
    node->addChild($1);
    node->addChild($3);
    $$ = node;  
}
| TRUE{
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_BOOL;
    node->b_val = true;
    $$ = node;  
}
| FALSE{
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_BOOL;
    node->b_val = false;
    $$ = node;  
}
;

T: T_INT {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_INT;} 
| T_CHAR {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_CHAR;}
| T_BOOL {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_BOOL;}
| T_STRING {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_STRING;}
| T_VOID {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_VOID;}
;


%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}