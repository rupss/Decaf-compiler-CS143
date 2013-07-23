/* File: ast_stmt.h
 * ----------------
 * The Stmt class and its subclasses are used to represent
 * statements in the parse tree.  For each statment in the
 * language (for, if, return, etc.) there is a corresponding
 * node class for that construct. 
 *
 * pp3: You will need to extend the Stmt classes to implement
 * semantic analysis for rules pertaining to statements.
 */


#ifndef _H_ast_stmt
#define _H_ast_stmt

#include "list.h"
#include "ast.h"

class Decl;
class VarDecl;
class Expr;
class ClassDecl; 
class LoopStmt; 
class FnDecl; 
  
class Program : public Node
{
  protected:
     List<Decl*> *decls;
     Hashtable<Decl*> *global_scope; 
     Hashtable< Hashtable<Decl*> *>  *class_scopes; 
    Hashtable< Hashtable<Decl*> *>  *interface_scopes;
     
  public:
     Program(List<Decl*> *declList);
     void Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors);   //false if we don't want to print errors (ie just info collecting), true if we want to print errors
    void Emit();
    
    //void CheckType(bool printErrors); 
};

class Stmt : public Node
{
protected: 
    
    Hashtable<Decl*> everything; 
    Hashtable<Decl*> *prev_scope; 
    LoopStmt *curr_loop; 
    Type *curr_fn_return_type; 
    ClassDecl *curr_class; 
    Hashtable<Decl*> *curr_class_full_scope; 
  public:
     Stmt() : Node() {}
     Stmt(yyltype loc) : Node(loc) {}
   
    virtual void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope) {}
    
    virtual Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return NULL; }
    
    //curr_loop is the most recent loop that we are in, or NULL if n/a
    //curr_fn_return_type is the return type of the current function that we are in, or NULL if we are not in a function. 
    
    //curr_class is the declaration to the current class we are in, or NULL if not in a class
    
    virtual void CheckType(bool printErrors) {}
};


class StmtBlock : public Stmt 
{
  protected:
    List<VarDecl*> *decls;
    List<Stmt*> *stmts;
    
  public:
    StmtBlock(List<VarDecl*> *variableDeclarations, List<Stmt*> *statements);
    List<VarDecl*> *GetVarDecls() { return decls; }
    List<Stmt*> *GetStmts() { return stmts; }
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    void CheckType(bool printErrors); 
};

  
class ConditionalStmt : public Stmt
{
  protected:
    Expr *test;
    Stmt *body;
  
  public:
    ConditionalStmt(Expr *testExpr, Stmt *body);
   
};

class LoopStmt : public ConditionalStmt 
{
  public:
    LoopStmt(Expr *testExpr, Stmt *body)
            : ConditionalStmt(testExpr, body) {}
  
};

class ForStmt : public LoopStmt 
{
  protected:
    Expr *init, *step;
  
  public:
    ForStmt(Expr *init, Expr *test, Expr *step, Stmt *body);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    
};

class WhileStmt : public LoopStmt 
{
  public:
    WhileStmt(Expr *test, Stmt *body) : LoopStmt(test, body) {}
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    
};

class IfStmt : public ConditionalStmt 
{
  protected:
    Stmt *elseBody;
  
  public:
    IfStmt(Expr *test, Stmt *thenBody, Stmt *elseBody);
   void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
};

class BreakStmt : public Stmt 
{
  public:
    BreakStmt(yyltype loc) : Stmt(loc) {}
   void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    
};

class ReturnStmt : public Stmt  
{
  protected:
    Expr *expr;
  
  public:
    ReturnStmt(yyltype loc, Expr *expr);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    
};

class PrintStmt : public Stmt
{
  protected:
    List<Expr*> *args;
    
  public:
    PrintStmt(List<Expr*> *arguments);
  void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
   
};


#endif
