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
%token K_SKIP K_WHILE K_DO K_FOR K_IF K_ELSE K_RETURN F_SCANF F_PRINTF
%token T_CHAR T_INT T_STRING T_BOOL
%token LOP_ADD LOP_SUB LOP_MUL LOP_DIV LOP_AND LOP_OR LOP_NOT LOP_EQ LOP_LT LOP_LE LOP_GT LOP_GE LOP_NE LOP_ASSIGN
%token SEMI // ;
%token LP RP LB RB LC RC


/* 排序是优先级*/
%right COMMA    // ,
%right LOP_NOT

%left LOP_MUL LOP_DIV
%left LOP_ADD LOP_SUB
%left LOP_EQ LOP_LT LOP_LE LOP_GT LOP_GE LOP_NE
%left LOP_AND LOP_OR

%right LOP_ASSIGN
%right MINUS PLUS
%right K_ELSE
%%

program
: statements {root = new TreeNode(0, NODE_PROG); root->addChild($1);};

statements
: statement {$$=$1;}
| statements statement {$$=$1; $$->addSibling($2);}
;

statement
: SEMI  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| K_SKIP SEMI  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| declaration SEMI {$$ = $1;}
| assignment SEMI {$$ = $1;}
| printf SEMI {$$ = $1;}
| scanf SEMI {$$ = $1;}
| if_else {$$ = $1;}
| while  {$$ = $1;}
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
;

assignment
: IDENTIFIER LOP_ASSIGN expr {
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($3);
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
: K_IF LP b_expr RP statement K_ELSE statement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_IF_ELSE;
    node->addChild($3);
    node->addChild($5);
    node->addChild($7);
    $$ = node;
}
| K_IF LP b_expr RP statement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_IF_ELSE;
    node->addChild($3);
    node->addChild($5);
    $$ = node;
}
;

while
: K_WHILE LP b_expr RP statement{
    TreeNode* node = new TreeNode($3->lineno, NODE_STMT);
    node->stype = STMT_WHILE;
    node->addChild($3);
    node->addChild($5);
    $$ = node;
}
;

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
}
| expr LOP_SUB expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_SUB;
    node->addChild($1);
    node->addChild($3);   
}
| expr LOP_MUL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_MUL;
    node->addChild($1);
    node->addChild($3);   
}
| expr LOP_DIV expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->optype = OP_DIV;
    node->addChild($1);
    node->addChild($3);   
}
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
| LOP_NOT b_expr{
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->optype = OP_NOT;
    node->addChild($1);
    node->addChild($2);
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
;


%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}