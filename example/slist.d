import persistent.slist;
import persistent.set;
import persistent.map;
import persistent.bsttree;
import std.typecons;
import std.stdio;
import std.algorithm.searching;

void visitTreeNode(T)(T node)
{
  if(!node) return;
  writeln(node.key);
  visitTreeNode(node.left);
  visitTreeNode(node.right);
}

void visitTree(T)(PersistentBstTree!T tree)
{
  visitTreeNode(tree.treeRoot());
}

int main() 
{
  
  PersistentList!int l;

  auto newL = l.add(5).add(10).add(20).add(30);
  auto newL2 = newL;
  
  auto newL3 = newL.remove(10);

  foreach(element ; newL2) writeln(element);
  
  auto r = find(newL2, 10);

  PersistentSet!int set;
  auto newSet = set.add(5).add(10).add(20).add(30);

  PersistentMap!(int, int) map;
  auto newMap = map.add(tuple(3,3));


  PersistentBstTree!int tree;

  PersistentBstTree!int tree2 = tree.insert(10).insert(20).insert(5);
  PersistentBstTree!int tree3 = tree2.insert(40);

  visitTree(tree3);
  visitTree(tree2);
  return 0;
}
