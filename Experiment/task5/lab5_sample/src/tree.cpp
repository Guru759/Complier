#include "tree.h"

//加入孩子，如果是第一个孩子，就加入孩子；
//如果不是，就给最后一个孩子加入兄弟
void TreeNode::addChild(TreeNode* child) {
    cout<<this->lineno<<"addChild!"<<child->lineno<<endl;
    if(this->child){
        TreeNode* cur = this->child;
        while(cur->sibling)
            cur = cur->sibling;
        cur->sibling = child;
    }
    else{
        this->child = child;
    }
}

// 加入兄弟
void TreeNode::addSibling(TreeNode* sibling){
    cout<<this->lineno<<"addSibling!"<<sibling->lineno<<endl;
    if(this->sibling){
        TreeNode* cur = this->sibling;
        while(cur->sibling)
            cur = cur->sibling;
        cur->sibling = sibling;
    }
    else{
       this->sibling = sibling;
    }
}

// 构造函数
TreeNode::TreeNode(int lineno, NodeType type) {
    cout<<"TreeNode!"<<lineno<<endl;
    this->lineno = lineno;
    this->nodeType = type;
}

// 逐层遍历添加nodeID
void TreeNode::genNodeId() {
    cout<<"genNodeId()!"<<endl;
    int id = 1;
    this->nodeID = 0;
    //声明一个队列
    TreeNode* Q = new TreeNode(888,NODE_CONST);
    TreeNode* q = Q;
    TreeNode* p = this;
    while(p){
        if(p->child){   //孩子存在就移到孩子
            p = p->child;
            q->queue = p;   // 入队
            q = q->queue;
            p->nodeID = id;
            id++;
            cout<<"id是啥："<<id<<endl;
            while(p->sibling){  // 兄弟存在就移到兄弟
                p = p->sibling;
                q->queue = p;   // 入队
                q = q->queue;
                p->nodeID = id;
                id++;
                cout<<"id是啥："<<id<<endl;
            }
        }
        // 出队
        if(!Q->queue)
            break;
        p = Q->queue;
        Q = Q->queue;
    }
}

void TreeNode::printNodeInfo() {
    //if(this->type)

    //cout<<"printNodeInfo()!"<<endl;
    cout<<"lno@"<<this->lineno;
    if(this->lineno > 9){
        cout<<"  @"<<this->nodeID;
        if(this->nodeID > 9)
            cout<<" ";
        else
            cout<<"  ";
    }
    else{
        cout<<"   @"<<this->nodeID;
        if(this->nodeID > 9)
            cout<<" ";
        else
            cout<<"  ";
    } 
    switch(this->nodeType){
        case NODE_PROG:
            cout<<" program  ";
            this->printChildrenId();
            cout<<endl;
            break;
        case NODE_STMT:
            cout<<" statement   ";
            this->printChildrenId();
            this->printSpecialInfo();
            break;
        case NODE_EXPR:
            cout<<" expression  ";
            this->printChildrenId();
            this->printSpecialInfo();
            break;
        case NODE_CONST:
            cout<<" const type: ";
            this->printSpecialInfo();
            break;
        case NODE_TYPE:
            cout<<" type type: ";
            this->printSpecialInfo();
            break;
        case NODE_VAR:
            cout<<" variable varname: ";
            this->printSpecialInfo();
            break;
        default:
            break;
    }
}


// 打印孩子
void TreeNode::printChildrenId() {
    //cout<<"printChildrenId()!"<<endl;
    cout<<"children: [@"<<this->child->nodeID;
    TreeNode* p = this->child;
    while(p->sibling){
        p = p->sibling;
        cout<<"  @"<<p->nodeID;
    }
    cout<<"  ]  ";
}

void TreeNode::printAST() {
    cout<<"printAST()!"<<endl;
    this->printNodeInfo();
    //声明一个队列
    TreeNode* Q = new TreeNode(888,NODE_CONST);
    TreeNode* q = Q;
    TreeNode* p = this;
    while(p){
        if(p->child){   //孩子存在就移到孩子
            p = p->child;
            q->queue = p;
            q = q->queue;
            p->printNodeInfo();
            while(p->sibling){  // 兄弟存在就移到兄弟
                p = p->sibling;
                q->queue = p;
                q = q->queue;
                p->printNodeInfo();
            }
        }
        if(!Q->queue)
            break;
        p = Q->queue;
        Q = Q->queue;
    }
}

// You can output more info...
void TreeNode::printSpecialInfo() {
    //cout<<"printSpecialInfo()!"<<endl;
    switch(this->nodeType){
        case NODE_CONST:
            cout<<this->type->getTypeInfo()<<endl;
            break;
        case NODE_VAR:
            cout<<this->var_name<<endl;
            break;
        case NODE_EXPR:
            cout<<"optype: "<<opType2String(this->optype)<<endl;
            break;
        case NODE_STMT:
            cout<<"stmt: "<<sType2String(this->stype)<<endl;
            break;
        case NODE_TYPE:
            cout<<this->type->getTypeInfo()<<endl;
            break;
        default:
            break;
    }
}

//用来判断stmt类型
string TreeNode::sType2String(StmtType type) {
    //cout<<"sType2String!"<<endl;
    switch(type) {
        case STMT_SKIP:
            return "skip";
            break;
        case STMT_DECL:
            return "decl";
            break;
        case STMT_ASSIGN:
            return "assign";
            break;
        case STMT_PRINTF:
            return "printf";
            break;
        case STMT_SCANF:
            return "scanf";
            break;
        case STMT_IF_ELSE:
            return "if";
            break;
        case STMT_WHILE:
            return "while";
            break;
        case STMT_FOR:
            return "for";
            break;
        case STMT_FUNC:
            return "function";
            break;
        case STMT_RETURN:
            return "return";
            break;
        default:
            return "?";
            break;
    }
}

// 用来判断表达式运算符类型
string TreeNode::opType2String (OperatorType type){
    switch(type) {
        case OP_EQ:
            return "==";
            break;
        case OP_LT:
            return "<";
            break;
        case OP_LE:
            return "<=";
            break;
        case OP_GT:
            return ">";
            break;
        case OP_GE:
            return ">=";
            break;
        case OP_NE:
            return "!=";
            break;
        case OP_ASSIGN:
            return "=";
            break;
        case OP_ADD:
            return "+";
            break;
        case OP_SUB:
            return "-";
            break;
        case OP_MUL:
            return "*";
            break;
        case OP_DIV:
            return "/";
            break;
        case OP_REM:
            return "%";
            break;
        case OP_AND:
            return "&&";
            break;
        case OP_OR:
            return "||";
            break;
        case OP_NOT:
            return "!";
            break;
        default:
            return "?";
            break;
    }
}