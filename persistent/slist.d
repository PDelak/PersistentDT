module persistent.slist;

import std.stdio;
import std.range;
import std.algorithm.searching;

// PersistentList 
// meets a ForwardRange criteria
struct PersistentList(T)
{  
  // node represents a node in a persistent
  // singly linked list. it contains only 
  // a key and a pointer to next node
  struct node(T)
  {
    this(T v) { key = v; next = null; }
    T key;
    node* next;
  };

  node!T *head;

  // add function adds a new element to a list
  // and returns a new list 
  // list elements are shared as possible 
  PersistentList!T add(T key) {
    auto n = new node!T(key);
    n.next = head;
    PersistentList!T newList;
    newList.head = n;
    return newList;
  }

  
  // copy creates a new list that will contain all nodes in the range [first - last)
  // without last element and connect it to afterLast node  
  PersistentList!T copy(node!T* first, node!T* last, node!T* afterLast)
  {
    PersistentList!T newList;
    auto current = first;
    
    alias listNode = node!T*;

    listNode dstNewNode = null;
    listNode dstPrevNode = null;
    listNode dstFirstNode = null;

    // go through fist last range 
    // and copy each element without last one
    // consider a list 
    // 1,2,3,4
    // if last will be set on 4 element
    // a below condition will not take it into account
    // (4 element represent deleted element in this case)
    // which means that a new list will contain only 
    // 3 elements and then third element will be connected
    // to nextAfterDeleted element
    while(current != last) {

      // create a new node with specified key taken
      // from src list, specifically its current
      // element
      dstNewNode = new node!T(current.key);      
      
      // if first node has not been set yet, means
      // that this is first loop cycle
      // and we need it to set new list head
      if(!dstFirstNode) dstFirstNode = dstNewNode;
      
      // if prevnode ha been already defined we can connect
      // next of prevNode to newNode
      if(dstPrevNode) dstPrevNode.next = dstNewNode;
      
      // now newNode became a new prevNode
      dstPrevNode = dstNewNode;

      // goto the next src list element
      current = current.next;
      
    }

    // connect prevNode with afterLast node
    // which means that deleted node which in this
    // case is last will be omitted
    // real deallocation will be done by GC
    if(dstPrevNode) dstPrevNode.next = afterLast;

    // set head of new node to the first created node
    newList.head = dstFirstNode;

    return newList;
  }

  // remove element
  PersistentList!T remove(T key) {
    PersistentList!T newList;
    
    auto current = head;
    auto first = head;

    // case 1 : empty list
    if(!current) return newList;
    
    // case 2 : only one element
    if(current.key == key) {       
      newList.head = current.next;
      return newList;
    }

    // case 3 : element in the middle
    // go though src list and try to find
    // a specified key
    // if so, copy all elements between first and last 
    // [first, last) - range between first and last without last
    while (current) {
      if(current.key == key) {
        newList = copy(first, current, current.next);            
        break;
      }
      current = current.next;
    }

    // case 4 : element does not exist
    // copy the whole list as it is
    if (!newList.head) newList = copy(first, current, null);

    return newList;
  }

  @property bool empty() 
  {
    return head == null; 
  }

  @property T front() const 
  { 
    return head.key; 
  }
  
  void popFront() 
  {
    head = head.next;
  }

  PersistentList!T save() 
  {
    return this;
  }
};


unittest {
  PersistentList!int l;
  assert(l.empty());
  auto newL1 = l.add(5).add(10).add(20);
  auto newL2 = newL1.remove(10);
  auto newL3 = newL2;
  assert(newL2.canFind(5));
  assert(newL2.canFind(20));
  assert(!newL2.canFind(10));
  assert(!newL2.empty());  
}

