#include "tree.h"

//加入孩子，如果是第一个孩子，就加入孩子；
//如果不是，就给最后一个孩子加入兄弟
void TreeNode::addChild(TreeNode* child) {
    //cout<<"addChild!"<<child->lineno<<endl;
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
    //cout<<"addSibling!"<<sibling->lineno<<endl;
    this->sibling = sibling;
}

// 构造函数
TreeNode::TreeNode(int lineno, NodeType type) {
    //cout<<"TreeNode!"<<lineno<<endl;
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
            while(p->sibling){  // 兄弟存在就移到兄弟
                p = p->sibling;
                q->queue = p;   // 入队
                q = q->queue;
                p->nodeID = id;
                id++;
            }
        }
        // 出队
        if(Q->queue){
            p = Q;        // 更新p
            Q = Q->queue;   //队头后移
        }
        else{
            p = Q;
            break;
        }
    }
}

void TreeNode::printNodeInfo() {
    //cout<<"printNodeInfo()!"<<endl;
    cout<<"lno@"<<this->lineno<<"  @"<<this->nodeID;
    switch(this->nodeType){
        case NODE_PROG:
            cout<<"  program  ";
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
    cout<<"children: [@"<<this->child->nodeID<<" ";
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
        if(Q->queue){
            p = Q;
            Q = Q->queue;
        }
        else{
            p = Q;
            break;
        }
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
            cout<<endl;
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
        default:
            return "?";
            break;
    }
}

// 用来判断节点类型
/*
string TreeNode::nodeType2String (NodeType type){
    switch(type){
        case NODE_PROG:
            cout<<"  program  ";
            this->printChildrenId();
            cout<<endl;
        case NODE_STMT:
            cout<<" statement   ";
            this->printChildrenId();
            this->printSpecialInfo();
        case NODE_EXPR:
            cout<<" expression  ";
            this->printChildrenId();
            this->printSpecialInfo();
        case NODE_CONST:
            cout<<" const type: ";
            this->printSpecialInfo();
        case NODE_TYPE:
            cout<<" type type: ";
            this->printSpecialInfo();
        case NODE_VAR:
            cout<<" variable varname: ";
            this->printSpecialInfo();

    }
    return "<>";
}
*/