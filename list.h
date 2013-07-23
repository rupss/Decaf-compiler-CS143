/**
 * File: list.h
 * ------------
 * Simple list class for storing a linear collection of elements. It
 * supports operations similar in name to the CS107 CVector -- nth, insert,
 * append, remove, etc.  This class is nothing more than a very thin
 * cover of a STL deque, with some added range-checking. Given not everyone
 * is familiar with the C++ templates, this class provides a more familiar
 * interface.
 *
 * It can handle elements of any type, the typename for a List includes the
 * element type in angle brackets, e.g.  to store elements of type double,
 * you would use the type name List<double>, to store elements of type
 * Decl *, it woud be List<Decl*> and so on.
 *
 * Here is some sample code illustrating the usage of a List of integers
 *
 *   int Sum(List<int> *list) {
 *       int sum = 0;
 *       for (int i = 0; i < list->NumElements(); i++) {
 *          int val = list->Nth(i);
 *          sum += val;
 *       }
 *       return sum;
 *    }
 */

#ifndef _H_list
#define _H_list

#include <deque>
#include "utility.h"  // for Assert()
#include <string>

using namespace std;

class Node;

template<class Element> class List {

 private:
    deque<Element> elems;

 public:
           // Create a new empty list
    List() {}

           // Returns count of elements currently in list
    int NumElements() const
	{ return elems.size(); }

          // Returns element at index in list. Indexing is 0-based.
          // Raises an assert if index is out of range.
    Element Nth(int index) const
	{ Assert(index >= 0 && index < NumElements());
	  return elems[index]; }

          // Inserts element at index, shuffling over others
          // Raises assert if index out of range
    void InsertAt(const Element &elem, int index)
	{ Assert(index >= 0 && index <= NumElements());
	  elems.insert(elems.begin() + index, elem); }

          // Adds element to list end
    void Append(const Element &elem)
	{ elems.push_back(elem); }

         // Removes element at index, shuffling down others
         // Raises assert if index out of range
    void RemoveAt(int index)
	{ Assert(index >= 0 && index < NumElements());
	  elems.erase(elems.begin() + index); }
          
       // These are some specific methods useful for lists of ast nodes
       // They will only work on lists of elements that respond to the
       // messages, but since C++ only instantiates the template if you use
       // you can still have Lists of ints, chars*, as long as you 
       // don't try to SetParentAll on that list.
    void SetParentAll(Node *p)
        { for (int i = 0; i < NumElements(); i++)
             Nth(i)->SetParent(p); }
    
    int Contains(Element e) //e is a Decl*
    {
        for (int i = 0; i < elems.size(); i++)
        {
            if (strcmp(elems[i]->GetName(), e->GetName()) == 0)
                return i; 
        }
        return -1; 
    }
    
    int FindInVTable(Element e) //e is a const char* and is the function name
    {
        //elements in the VTable are of the form classname.functionname
        
        for (int i = 0; i < elems.size(); i++)
        {
            string curr(elems[i]); 
            size_t period = curr.find("."); 
            string curr_fn_name = curr.substr(period+1); 
           
            
            if (strcmp(curr_fn_name.c_str(), e) == 0)// == elem_name)
                return i; 
        }
        return -1; 
    }
    
    const char *GetFunctionName(int i) 
    {
        string curr(elems[i]); 
        size_t period = curr.find("."); 
        string curr_fn_name = curr.substr(period+1); 
        
        return strdup(curr_fn_name.c_str()); 
    }

};

#endif

