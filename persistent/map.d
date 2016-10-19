module persistent.map;

import persistent.slist;
import std.typecons;

struct PersistentMap(Key, Value) 
{
   alias KeyType = Tuple!(Key, Value);
   alias Map = PersistentList!KeyType;
   Map map;
   
   Map add(KeyType kv)    { return map.add(kv);   }
   Map remove(KeyType kv) { return map.remove(kv);}
   
};
