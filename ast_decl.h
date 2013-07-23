/* File: ast_decl.h
 * ----------------
 * In our parse tree, Decl nodes are used to represent and
 * manage declarations. There are 4 subclasses of the base class,
 * specialized for declarations of variables, functions, classes,
 * and interfaces.
 *
 * pp3: You will need to extend the Decl classes to implement 
 * semantic processing including detection of declaration conflicts 
 * and managing scoping issues.
 */

#ifndef _H_ast_decl
#define _H_ast_decl

#include "ast.h"
#include "list.h"

class Type;
class NamedType;
class Identifier;
class Stmt;
class VarDecl; 
class ClassDecl; 
class LoopStmt; 
class FnDecl; 

class Decl : public Node 
{
  protected:
    Identifier *id;
    
    Hashtable<Decl*> everything; 
    Hashtable<Decl*> *prev_scope; 
    LoopStmt *curr_loop; 
    Type *curr_fn_return_type; 
    ClassDecl *curr_class; 
    Hashtable<Decl*> *curr_class_full_scope; 
  
  public:
    Decl(Identifier *name);
    friend ostream& operator<<(ostream& out, Decl *d) { return out << d->id; }
    virtual void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope) = 0;   //inClass = true if we are in a  class that extends another class, false if not. if (inClass), className is the name of the inherited class. 
    Identifier *GetId() { return id; }
    const char *GetName() { return id->GetName(); }
   // virtual Type *GetReturnType() { return NULL; }
    virtual void CheckReturnType(Type *derived_return_type, Decl *derived, bool printErrors, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool & to_continue, Hashtable<Decl*> *global_scope) {}
    virtual void CheckNthArg(VarDecl *curr_derived_arg, Decl *derived, int i, bool printErrors) {}
    virtual void CheckArg1(VarDecl *arg2, Decl *derived, bool printErrors) {}
    virtual void CheckArg2(Type *type1, Decl *derived, bool printErrors) {}
  //  virtual void CheckArgArr2(ArrayType *a1, Decl *derived, bool printErrors) {}
    virtual void CheckNumArguments(int numGiven, Decl *derived, bool printErrors, bool & to_continue) {}
    
    virtual void Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn) {}
    
  //  virtual void CheckType(bool printErrors) {}

};

class VarDecl : public Decl 
{
  protected:
    Type *type;
    Location *loc; 
    int offset; //only used if VarDecl is in a ClassDecl - contains the offset of it's location in an instance of its ClassDecl
    
  public:
    VarDecl(Identifier *name, Type *type);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    void CheckArg1(VarDecl *arg2, Decl *derived, bool printErrors); 
    void CheckArg2(Type *type1, Decl *derived, bool printErrors); 
    //void CheckArgArr2(ArrayType *a1, Decl *derived, bool printErrors); 
    Type *GetType() { return type; }
    Location *GetVarLocation() { return loc; }
    void SetVarLocation(Location *l) { loc = l; }
    void Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    int GetOffset(); 
    void SetOffset(int o); 
};

class ClassDecl : public Decl 
{
  protected:
    List<Decl*> *members;
    NamedType *extends;
    List<NamedType*> *implements;
    
    int numBytesToAlloc; 
    List<const char*> *VTable; 

  public:
    ClassDecl(Identifier *name, NamedType *extends, 
              List<NamedType*> *implements, List<Decl*> *members);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    NamedType *GetExtends() { return extends; }
    List<NamedType *> *GetImplements() { return implements; }
    void Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    int GetNumBytesToAlloc() { return numBytesToAlloc; }
    void SetNumBytesToAlloc(int n) { numBytesToAlloc = n; }
    List<Decl*> *GetMembers() { return members; }
    void SetVTable(List<const char*> *v) { VTable = v; }
    List<const char*> *GetVTable() { return VTable; }
    
   // void CheckType(bool printErrors); 
};

class InterfaceDecl : public Decl 
{
  protected:
    List<Decl*> *members;   //contains only FnDecl's
    
    
  public:
    InterfaceDecl(Identifier *name, List<Decl*> *members);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
};

class FnDecl : public Decl 
{
  protected:
    List<VarDecl*> *formals;
    Type *returnType;
    Stmt *body;
    int offset; //only used if this FnDecl is in a ClassDecl - contains the offset of this function in the vtable. 
    
  public:
    FnDecl(Identifier *name, Type *returnType, List<VarDecl*> *formals);
    void SetFunctionBody(Stmt *b);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    Stmt *GetBody() { return body; }
    Type *GetReturnType() { return returnType; }
    List<VarDecl*> *GetFormals() { return formals; }
    void CheckReturnType(Type *derived_return_type, Decl *derived, bool printErrors, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool & to_continue, Hashtable<Decl*> *global_scope); 
    void CheckNthArg(VarDecl *curr_var, Decl *derived, int i, bool printErrors); 
    void CheckNumArguments(int numGiven, Decl *derived, bool printErrors, bool & to_continue);
    
    void Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    void SetOffset(int o) { offset = o; }
    int GetOffset() { return offset; }
    
   // void CheckType(bool printErrors);
};

#endif
