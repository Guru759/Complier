#include "tree.h"

//加入孩子，如果是第一个孩子，就加入孩子；
//如果不是，就给最后一个孩子加入兄弟
void TreeNode::addChild(TreeNode* child) {
    cout<<"addChild!"<<child->lineno<<endl;
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
    cout<<"addSibling!"<<sibling->lineno<<endl;
    this->sibling = sibling;
}

// 构造函数
TreeNode::TreeNode(int lineno, NodeType type) {
    cout<<"TreeNode!"<<lineno<<endl;//<<type<<endl;
    this->lineno = lineno;
    this->nodeType = type;
}

void TreeNode::genNodeId() {
    cout<<"genNodeId()!"<<endl;
    int id = 1;
    this->nodeID = 0;
    TreeNode* Q = nullptr;
    TreeNode* q= Q;
    TreeNode* p = this;
    while(p){
        if(p->child){
            p = p->child;
            q->sibling = p;
            p->nodeID = id;
            id++;
            while(p->sibling){
                p = p->sibling;
                q->sibling = p;
                p->nodeID = id;
                id++;
            }
        }
        if(Q){
            p = Q;
            Q = Q->sibling;
        }
        else{
            cout<<"addID:wrong!"<<endl;
            return ;
        }
    }
}

void TreeNode::printNodeInfo() {
    cout<<"printNodeInfo()!"<<endl;
    cout<<"lno@"<<this->lineno<<" @"<<this->nodeID;
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

TreeNode* TreeNode::getChildrenId(TreeNode* queue) {
    cout<<"getChildrenId!"<<endl;
    TreeNode* p = queue;
    while(p->sibling){
        p = p->sibling;
    }
    if(this->child){
        p->sibling = this->child;
        p = p->sibling;
        TreeNode* cur = this->child;
        while(cur->sibling){
            p->sibling = cur->sibling;
            p = p->sibling;
        }
    }
    return queue;
    // 或者引用？
}

/*TreeNode* TreeNode::Delete(TreeNode& queue){
    if(this){
        TreeNode* p = this;
        
        this = this->sibling;
        delete p;

    }
    return this;
}
*/



void TreeNode::printChildrenId() {
    cout<<"printChildrenId()!"<<endl;
    cout<<"children: [@"<<this->child->nodeID<<" ";
    while(this->child->sibling)
        cout<<this->child->sibling->nodeID<<" ";
    cout<<"  ]  ";
}

void TreeNode::printAST() {
    cout<<"printAST()!"<<endl;
    //this->printNodeInfo();
    // 声明一个队列
    TreeNode* Q = nullptr;
    // 将根节点的孩子加入
    //Q = this->getChildrenId(Q);
    TreeNode* p = this;
    while(p){
        p->printNodeInfo();
        TreeNode* p = queue;
        while(p->sibling){
            p = p->sibling;
        }
        if(this->child){
            p->sibling = this->child;
            p = p->sibling;
            TreeNode* cur = this->child;
            while(cur->sibling){
                p->sibling = cur->sibling;
                p = p->sibling;
            }
        }
        //Q = p->getChildrenId(Q);

        // 维护了一个队列
        if(Q){
            p = Q;
            Q = Q->sibling;
        }
        else{
            cout<<"printAST:wrong!"<<endl;
            return ;
        }
    }
}

// You can output more info...
void TreeNode::printSpecialInfo() {
    cout<<"printSpecialInfo()!"<<endl;
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
            cout<<sType2String(this->stype)<<endl;
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
    cout<<"sType2String!"<<endl;
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
            //cerr << "shouldn't reach here, typeinfo";
            //assert(0);
    }
    //return "?";
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