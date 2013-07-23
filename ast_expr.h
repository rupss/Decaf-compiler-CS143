/* File: ast_expr.h
 * ----------------
 * The Expr class and its subclasses are used to represent
 * expressions in the parse tree.  For each expression in the
 * language (add, call, New, etc.) there is a corresponding
 * node class for that construct. 
 *
 * pp3: You will need to extend the Expr classes to implement 
 * semantic analysis for rules pertaining to expressions.
 */


#ifndef _H_ast_expr
#define _H_ast_expr

#include "ast.h"
#include "ast_stmt.h"
#include "list.h"

class NamedType; // for new
class Type; // for NewArray
class ArrayType; 
class FnDecl; 
class ClassDecl; 


class Expr : public Stmt 
{
protected: 
    Type *type; 
  public:
    Expr(yyltype loc) : Stmt(loc) { type = NULL; }
    Expr() : Stmt() { type = NULL; }
    Type *GetType() { return type; }
    virtual Identifier *GetNameId() { return NULL; }
    virtual Identifier *GetArrayNameField() { return NULL; }
    virtual Type *GetArrayAssignType(ArrayType *array_var_type) { return NULL; }
    virtual Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn) { return NULL; }
    virtual int GetValue() { return -1; }
    virtual void StoreInLValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn, Location *to_assign) {}
    virtual Location *ReadValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
    virtual const char *GetBaseName() { return NULL; }

};

/* This node type is used for those places where an expression is optional.
 * We could use a NULL pointer, but then it adds a lot of checking for
 * NULL. By using a valid, but no-op, node, we save that trouble */
class EmptyExpr : public Expr
{
  public:
};

class IntConstant : public Expr 
{
  protected:
    int value;
  
  public:
    IntConstant(yyltype loc, int val);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return code_gen->GenLoadConstant(value); }
    int GetValue() { return value; }
};

class DoubleConstant : public Expr 
{
  protected:
    double value;
    
  public:
    DoubleConstant(yyltype loc, double val);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
};

class BoolConstant : public Expr 
{
  protected:
    bool value;
    
  public:
    BoolConstant(yyltype loc, bool val);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return code_gen->GenLoadConstant(value); }
};

class StringConstant : public Expr 
{ 
  protected:
    char *value;
    
  public:
    StringConstant(yyltype loc, const char *val);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return code_gen->GenLoadConstant(value); }
};

class NullConstant: public Expr 
{
  public: 
    NullConstant(yyltype loc); 
};

class Operator : public Node 
{
  protected:
    char tokenString[4];
    
  public:
    Operator(yyltype loc, const char *tok);
    friend ostream& operator<<(ostream& out, Operator *o) { return out << o->tokenString; }
    const char *GetOperator() { return tokenString; }
 };
 
class CompoundExpr : public Expr
{
  protected:
    Operator *op;
    Expr *left, *right; // left will be NULL if unary
    
  public:
    CompoundExpr(Expr *lhs, Operator *op, Expr *rhs); // for binary
    CompoundExpr(Operator *op, Expr *rhs);             // for unary
  //  void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors); 
 
};

class ArithmeticExpr : public CompoundExpr 
{

  public:
    ArithmeticExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    ArithmeticExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);   
    bool ArithAppropriate(Type *t); 
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
    int GetValue(); 
};

class RelationalExpr : public CompoundExpr 
{
  public:
    RelationalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    bool RelationalAppropriate(Type *t); 
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
};

class EqualityExpr : public CompoundExpr 
{
  public:
    EqualityExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    const char *GetPrintNameForNode() { return "EqualityExpr"; }
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn);
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
};

class LogicalExpr : public CompoundExpr 
{
  public:
    LogicalExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    LogicalExpr(Operator *op, Expr *rhs) : CompoundExpr(op,rhs) {}
    const char *GetPrintNameForNode() { return "LogicalExpr"; }
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);   
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
};

class AssignExpr : public CompoundExpr 
{
  public:
    AssignExpr(Expr *lhs, Operator *op, Expr *rhs) : CompoundExpr(lhs,op,rhs) {}
    const char *GetPrintNameForNode() { return "AssignExpr"; }
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
};

class LValue : public Expr 
{
  public:
    LValue(yyltype loc) : Expr(loc) {}
};

class This : public Expr 
{
  public:
    This(yyltype loc) : Expr(loc) {}
    void CheckThis(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
     Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
  
    
};

class ArrayAccess : public LValue 
{
  protected:
    Expr *base, *subscript;
    
  public:
    ArrayAccess(yyltype loc, Expr *base, Expr *subscript);
    Expr *GetBase() { return base; }
    Expr *GetSubscript() { return subscript; }
    Identifier *GetNameId(); 
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    Identifier *GetArrayNameField(); 
    
    Type *GetArrayAssignType(ArrayType *array_var_type); 
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
    void StoreInLValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn, Location *to_assign);
    Location *ReadValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 

};

/* Note that field access is used both for qualified names
 * base.field and just field without qualification. We don't
 * know for sure whether there is an implicit "this." in
 * front until later on, so we use one node type for either
 * and sort it out later. */
class FieldAccess : public LValue 
{
  protected:
    Expr *base;	// will be NULL if no explicit base
    Identifier *field;
    Location *loc; 
    
  public:
    FieldAccess(Expr *base, Identifier *field); //ok to pass NULL base
    Identifier *GetNameId() { return field; }
    const char *GetName() { return field->GetName(); }
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    Identifier *GetArrayNameField(); 
    Type *GetArrayAssignType(ArrayType *array_var_type); 
    Expr *GetBase() { return base; }
    
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
    void StoreInLValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn, Location *to_assign);
    Location *ReadValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    
    const char *GetBaseName() { 
        if (base == NULL)
            return field->GetName(); 
        This *base_this = dynamic_cast<This*>(base); 
        if (base_this != NULL)
            return field->GetName(); 
        
        return base->GetBaseName(); 
    }
   
};

/* Like field access, call is used both for qualified base.field()
 * and unqualified field().  We won't figure out until later
 * whether we need implicit "this." so we use one node type for either
 * and sort it out later. */
class Call : public Expr 
{
  protected:
    Expr *base;	// will be NULL if no explicit base
    Identifier *field;
    List<Expr*> *actuals;
    
    VarDecl *corr_var; 
    Location *corr_loc; 
    
  public:
    Call(yyltype loc, Expr *base, Identifier *field, List<Expr*> *args);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    void CheckArgumentsAgainstActualFunction(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, FnDecl *fn_called, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    void PrintAll(Hashtable<Decl*> *m); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn); 
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *ReadValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn) { return Emit(code_gen, class_scopes, interface_scopes, global_scope, NULL, curr_fn); }
    
        
};

class NewExpr : public Expr
{
  protected:
    NamedType *cType;
    
  public:
    NewExpr(yyltype loc, NamedType *clsType);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
};

class NewArrayExpr : public Expr
{
  protected:
    Expr *size;
    Type *elemType;
    Location *array_size; 
    
  public:
    NewArrayExpr(yyltype loc, Expr *sizeExpr, Type *elemType);
    void Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope);  
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *GetArraySize() { return array_size; }
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
};

class ReadIntegerExpr : public Expr
{
  public:
    ReadIntegerExpr(yyltype loc); 
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
};

class ReadLineExpr : public Expr
{
  public:
    ReadLineExpr(yyltype loc); 
    Location *MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn); 
    Location *Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn) { return MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); }
};

    
#endif
