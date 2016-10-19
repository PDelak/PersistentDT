import persistent.slist;
import std.stdio;
import std.algorithm.searching;

int main() 
{
  
  PersistentList!int l;
  auto newL = l.add(5).add(10).add(20).add(30);
  auto newL2 = newL;
  
  auto newL3 = newL.remove(10);

  foreach(element ; newL2)
  {
  	writeln(element);
  }

  auto r = find(newL2, 10);

  return 0;
}
