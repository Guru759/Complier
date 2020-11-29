#include "tree.h"
void TreeNode::addChild(TreeNode* child) {
    this->child = child;
}

void TreeNode::addSibling(TreeNode* sibling){
    this->sibling = sibling;
}

TreeNode::TreeNode(int lineno, NodeType type) {
    this->lineno = lineno;
    this->nodeType = type;
    this->nodeID = nodeid;
    nodeid++;
}

void TreeNode::genNodeId() {

}

void TreeNode::printNodeInfo() {
    cout<<"lno@"<<this->lineno<<" @"<<this->nodeID;
    switch(this->nodeType){
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
}

void TreeNode::printChildrenId() {
    cout<<"children: [@"<<this->child->nodeID<<" ";
    while(this->child->sibling)
        cout<<this->child->sibling->nodeID<<" ";
    cout<<"  ]  ";
}

void TreeNode::printAST() {
    
}

// You can output more info...
void TreeNode::printSpecialInfo() {
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
    switch(type) {
        case STMT_SKIP:
            return "skip";
        case STMT_DECL:
            return "decl";
        case STMT_ASSIGN:
            return "assign";
        case STMT_PRINTF:
            return "printf";
        case STMT_SCANF:
            return "scanf";
        case STMT_IF_ELSE:
            return "if";
        case STMT_WHILE:
            return "while";
        default:
            cerr << "shouldn't reach here, typeinfo";
            assert(0);
    }
    return "?";
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