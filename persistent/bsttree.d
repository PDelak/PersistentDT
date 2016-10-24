module persistent.bsttree;

import std.range;

struct PersistentBstTree(T)
{  
  private struct node(T)
  {
    this(T v) { key = v; left = null; right = null; }
    T key;
    node* left;
    node* right;
  };

  private node!T *root;

  private alias node!T TreeNode;

  private TreeNode* makeTreeNode(T)(T key, TreeNode* left, TreeNode* right)
  {
    TreeNode* newNode = new TreeNode(key);
    newNode.left = left;
    newNode.right = right;
    return newNode;
  }

  private TreeNode* insertImpl(TreeNode* n, T key)
  {
    if(!n) return makeTreeNode(key, null, null);
   
    if(key < n.key) return makeTreeNode(n.key, insertImpl(n.left, key), n.right);

    return makeTreeNode(n.key, n.left, insertImpl(n.right, key));    
  }

  TreeNode* treeRoot() { return root; }

  TreeNode* insert(TreeNode* n, T key)
  {
    return insertImpl(n, key);
  }

  PersistentBstTree!T insert(T key) {

    PersistentBstTree!T tree;
    tree.root = insert(root, key);
    return tree;
  
  }

};
