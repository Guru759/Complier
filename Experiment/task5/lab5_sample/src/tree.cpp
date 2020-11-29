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
    cout<<"lno@"<<lineno<<" "<<"@"<<nodeID<<" "<<"statement:"<<
}

void TreeNode::printChildrenId() {
    cout<<"children: [@"<<this->child->nodeID<<" ";
    while(this->child->sibling)
        cout<<this->child->sibling->nodeID<<" ";
    cout<<"  ]";
}

void TreeNode::printAST() {

}


// You can output more info...
void TreeNode::printSpecialInfo() {
    switch(this->nodeType){
        case NODE_CONST:
            break;
        case NODE_VAR:
            break;
        case NODE_EXPR:
            break;
        case NODE_STMT:
            break;
        case NODE_TYPE:
            break;
        default:
            break;
    }
}

string TreeNode::sType2String(StmtType type) {
    return "?";
}


string TreeNode::nodeType2String (NodeType type){
    return "<>";
}
