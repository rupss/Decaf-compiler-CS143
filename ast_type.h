/* File: ast_type.h
 * ----------------
 * In our parse tree, Type nodes are used to represent and
 * store type information. The base Type class is used
 * for built-in types, the NamedType for classes and interfaces,
 * and the ArrayType for arrays of other types.  
 *
 * pp3: You will need to extend the Type classes to implement
 * the type system and rules for type equivalency and compatibility.
 */
 
#ifndef _H_ast_type
#define _H_ast_type

#include "ast.h"
#include "list.h"
#include <iostream>
using namespace std;

class VarDecl; 
class NamedType; 

class Type : public Node 
{
  protected:
    char *typeName;

  public :
    static Type *intType, *doubleType, *boolType, *voidType,
                *nullType, *stringType, *errorType;

    Type(yyltype loc) : Node(loc) {}
    Type(const char *str);
    
    virtual void PrintToStream(ostream& out) { out << typeName; }
    friend ostream& operator<<(ostream& out, Type *t) { t->PrintToStream(out); return out; }
    virtual bool IsEquivalentTo(Type *other) { 
        if (this == errorType || other == errorType) //preventing cascading errors
            return true; 
        return this == other; 
    }
    virtual bool IsCompatibleWith(Type *parent_type, Hashtable<Decl*> *global_scope, bool & errorAlreadyReported, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope); 
    virtual void Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors) {}
  //  virtual void CheckReturnType(Decl *inherited_function, Decl *curr_function, bool printErrors) {}
     const char *GetTypeName() { return typeName; }
  //  virtual void CheckArgArr1(VarDecl *arg2, Decl *derived, bool printErrors) {}
    virtual void CheckArrayTypes1(Type *type2, Decl *derived, bool printErrors) {}
    virtual void CheckArrayTypes2(Type *type2, Decl *derived, bool printErrors) {}
    
};

class NamedType : public Type 
{
  protected:
    Identifier *id;
    
  public:
    NamedType(Identifier *i);
    const char *GetName() { return id->GetName(); }
    void PrintToStream(ostream& out) { out << id; }
    Identifier *GetId() { return id; }
    void Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors); 
    bool IsEquivalentTo(Type *other); 
    bool IsCompatibleWith(Type *parent_type, Hashtable<Decl*> *global_scope, bool & errorAlreadyReported, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope); 
 //   void CheckReturnType(Decl *inherited_function, Decl *curr_function, bool printErrors); 

};

class ArrayType : public Type 
{
  protected:
    Type *elemType;

  public:
    ArrayType(yyltype loc, Type *elemType);
    
    void PrintToStream(ostream& out) { out << elemType << "[]"; }
    void Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors); 
    bool IsEquivalentTo(Type *other); 
 //   void CheckArrayTypes(ArrayType *a2, Decl *derived, bool printErrors); 
  //  void CheckArrayTypesSingle(Namedtype *n1, Decl *derived, bool printErrors); 
 //   void CheckArrayTypesNested(ArrayType *a2, Decl *derived, bool printErrors); 
    
    Type *GetElemType() { return elemType; }
    bool IsCompatibleWith(Type *parent_type, Hashtable<Decl*> *global_scope, bool & errorAlreadyReported, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope); 
  //  void CheckArgArr1(VarDecl *arg2, Decl *derived, bool printErrors);

};

 
#endif
