/* File: ast_stmt.cc
 * -----------------
 * Implementation of statement node classes.
 */
#include "ast_stmt.h"
#include "ast_type.h"
#include "ast_decl.h"
#include "ast_expr.h"


Program::Program(List<Decl*> *d) {
    Assert(d != NULL);
    (decls=d)->SetParentAll(this);
}

void Program::Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors)  //curr_scope is the global scope
{
    /* pp3: here is where the semantic analyzer is kicked off.
     *      The general idea is perform a tree traversal of the
     *      entire program, examining all constructs for compliance
     *      with the semantic rules.  Each node can have its own way of
     *      checking itself, which makes for a great use of inheritance
     *      and polymorphism in the node classes.
     */
    
    Hashtable<Decl*> *global_scope = new Hashtable<Decl*>;
    
    Hashtable<Decl*> copy = *global_scope;
    
    for (int i = 0; i < decls->NumElements(); i++)
    {
        Decl *d = decls->Nth(i); 
        if (global_scope->Lookup(d->GetName()) == NULL)
        {
            global_scope->Enter(d->GetName(), d); 
        }
        else if (printErrors)
        {
            ReportError::DeclConflict(d, global_scope->Lookup(d->GetName())); 
        }
    }
    
    
    Iterator<Decl*> global_iter = global_scope->GetIterator(); 
    
    Decl *i = global_iter.GetNextValue(); 
    
    while (i != NULL)
    {
        i->Check(copy, global_scope, class_scopes, interface_scopes, false, "-1", printErrors, global_scope, NULL, NULL); 
        i = global_iter.GetNextValue(); 
    }
    
    this->global_scope = global_scope; 
    this->class_scopes = class_scopes; 
    this->interface_scopes = interface_scopes; 
    
    
}
/*
void Program::CheckType(bool printErrors)
{
    for (int i = 0; i < decls->NumElements(); i++)
    {
        Decl *d = decls->Nth(i); 
        d->CheckType(printErrors); 
    }
}
*/

void Program::Emit() 
{
    //cout << "EMIT" << endl; 
    
    if (global_scope->Lookup("main") == NULL)
    {
        ReportError::NoMainFound();
        return; 
    }
    
    
    CodeGenerator *code_gen = new CodeGenerator(); 
    
   
    for (int i = 0; i < decls->NumElements(); i++)
    {
        Decl *d = decls->Nth(i); 
        d->Emit(code_gen, class_scopes, interface_scopes, global_scope, NULL); 
    }
    
    code_gen->DoFinalCodeGen(); 
}

Location *StmtBlock::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
    for (int i = 0; i < decls->NumElements(); i++)
    {
        Decl *d = decls->Nth(i); 
        d->Emit(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    }
    
    for (int i = 0; i < stmts->NumElements(); i++)
    {
        Stmt *s = stmts->Nth(i); 
        Location *l = s->Emit(code_gen, class_scopes, interface_scopes, global_scope, break_label, curr_fn); 
    }
    return NULL; 
}

StmtBlock::StmtBlock(List<VarDecl*> *d, List<Stmt*> *s) {
    Assert(d != NULL && s != NULL);
    (decls=d)->SetParentAll(this);
    (stmts=s)->SetParentAll(this);
}

void StmtBlock::CheckType(bool printErrors)
{
    for (int i = 0; i < stmts->NumElements(); i++)
    {
        stmts->Nth(i)->CheckType(printErrors); 
    }
}

void StmtBlock::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)  
{
    
    //checks all the variable declarations
    
    Hashtable<Decl*> *locals = new Hashtable<Decl*>; 
    
    for (int i = 0; i < decls->NumElements(); i++)
    {
        VarDecl *curr_var = decls->Nth(i); 
        curr_var->Check(everything, locals, class_scopes, interface_scopes, false, "-1", printErrors, global_scope, curr_class, curr_class_full_scope); 
    }
    
    //adds nonduplicate elements in prev_scope to everything
    
    Iterator<Decl*> t = prev_scope->GetIterator(); 
    Decl *e = t.GetNextValue(); 
    while (e != NULL)
    {
        if (everything.Lookup(e->GetName()) == NULL)
        {
            everything.Enter(e->GetName(), e, true); 
        }
        
        e = t.GetNextValue(); 
    }
    
    //adds all elements in locals to everything and overwrites any duplicates
    
    Iterator<Decl*> iter = locals->GetIterator(); 
    Decl *d = iter.GetNextValue(); 
    while (d != NULL)
    {
        everything.Enter(d->GetName(), d, true);
        d = iter.GetNextValue(); 
    }
    
    //NOW EVERYTHING TRULY CONTAINS EVERYTHING
    
    for (int i = 0; i < stmts->NumElements(); i++)
    {
        Stmt *s = stmts->Nth(i); 
        AssignExpr *a = dynamic_cast<AssignExpr *>(s); 
        ArithmeticExpr *ar = dynamic_cast<ArithmeticExpr *>(s); 
        s->Check(everything, locals, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
    
}

ConditionalStmt::ConditionalStmt(Expr *t, Stmt *b) { 
    Assert(t != NULL && b != NULL);
    (test=t)->SetParent(this); 
    (body=b)->SetParent(this);
}

ForStmt::ForStmt(Expr *i, Expr *t, Expr *s, Stmt *b): LoopStmt(t, b) { 
    Assert(i != NULL && t != NULL && s != NULL && b != NULL);
    (init=i)->SetParent(this);
    (step=s)->SetParent(this);
}

void ForStmt::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    test->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    init->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    step->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    LoopStmt *old_curr_loop = curr_loop; 
    
    curr_loop = this; 
    
    if (printErrors && test->GetType() != Type::boolType)
    {
        ReportError::TestNotBoolean(test); 
    }
    
    Hashtable<Decl*> *local = new Hashtable<Decl*>; 
    
    body->Check(everything, local, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope);
    
    curr_loop = old_curr_loop; 
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}


Location *ForStmt::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{

    char *condition_label = code_gen->NewLabel(); 
    char *after_label = code_gen->NewLabel(); 
    
    init->Emit(code_gen, class_scopes, interface_scopes, global_scope, break_label, curr_fn); 
    
    code_gen->GenLabel(condition_label); 
    Location *condition = test->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn);
    code_gen->GenIfZ(condition, after_label); 
    
    body->Emit(code_gen, class_scopes, interface_scopes, global_scope, after_label, curr_fn); 
    
    step->Emit(code_gen, class_scopes, interface_scopes, global_scope, after_label, curr_fn); 
    
    code_gen->GenGoto(condition_label); 
    
    code_gen->GenLabel(after_label);
    
    return NULL; 

}


void WhileStmt::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope) 
{
    test->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    
    LoopStmt *old_curr_loop = curr_loop; 
    
    curr_loop = this; 
    
    if (printErrors && test->GetType() != Type::boolType)
    {
        ReportError::TestNotBoolean(test); 
    }
    
    Hashtable<Decl*> *local = new Hashtable<Decl*>; 
    
    body->Check(everything, local, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    curr_loop = old_curr_loop; 
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

Location *WhileStmt::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
 
    char *condition_label = code_gen->NewLabel(); 
    char *after_label = code_gen->NewLabel(); 

    code_gen->GenLabel(condition_label); 
    Location *condition = test->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn);
    code_gen->GenIfZ(condition, after_label); 
    
    body->Emit(code_gen, class_scopes, interface_scopes, global_scope, after_label, curr_fn); 
    
    code_gen->GenGoto(condition_label); 
    
    code_gen->GenLabel(after_label); 
    
    return NULL; 
}


IfStmt::IfStmt(Expr *t, Stmt *tb, Stmt *eb): ConditionalStmt(t, tb) { 
    Assert(t != NULL && tb != NULL); // else can be NULL
    elseBody = eb;
    if (elseBody) elseBody->SetParent(this);
}

void IfStmt::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope) 
{
    test->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    if (printErrors && test->GetType() != Type::boolType)
    {
        ReportError::TestNotBoolean(test); 
    }
    
    if (body != NULL)
    {
        Hashtable<Decl*> *if_local = new Hashtable<Decl*>; 
        
        body->Check(everything, if_local, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    }
    
    if (elseBody != NULL)
    {
        Hashtable<Decl*> *else_local = new Hashtable<Decl*>; 
        
        elseBody->Check(everything, else_local, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

Location *IfStmt::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
  
    
    Location *condition = test->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn);
    
    char *after_label = code_gen->NewLabel(); 
    
    char *else_label = code_gen->NewLabel(); 
    
    if (elseBody != NULL)
    {
        code_gen->GenIfZ(condition, else_label); 
        
        body->Emit(code_gen, class_scopes, interface_scopes, global_scope, break_label, curr_fn); 
        
        code_gen->GenGoto(after_label); 
        
        code_gen->GenLabel(else_label);
        
        
        elseBody->Emit(code_gen, class_scopes, interface_scopes, global_scope, break_label, curr_fn); 
        
        //  code_gen->GenGoto(after_label); 
    }
    else
    { 
        code_gen->GenIfZ(condition, after_label); 
        
        body->Emit(code_gen, class_scopes, interface_scopes, global_scope, break_label, curr_fn); 
        
        code_gen->GenGoto(after_label);
        
    }
    
    code_gen->GenLabel(after_label); 
    
    return NULL; 
    
        
}

Location *BreakStmt::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
    code_gen->GenGoto(break_label); 
    
    return NULL; 
}



void BreakStmt::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    
   // cout << "in BreakStmt::Check" << endl; 
    
    if (curr_loop == NULL && printErrors)
    {
        ReportError::BreakOutsideLoop(this); 
    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

ReturnStmt::ReturnStmt(yyltype loc, Expr *e) : Stmt(loc) { 
    Assert(e != NULL);
    (expr=e)->SetParent(this);
}

void ReturnStmt::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)  
{
    NamedType *cfnr = dynamic_cast<NamedType *>(curr_fn_return_type); 
    
    expr->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    Type *curr_type = expr->GetType(); 
    
    NamedType *ct = dynamic_cast<NamedType *>(curr_type); 
    
    //if the function return type is void but the expression type is non void
    if (curr_fn_return_type == Type::voidType)
    {
        if (curr_type != NULL && printErrors)
        {
            ReportError::ReturnMismatch(this, curr_type, curr_fn_return_type); 
            
        }
        return; 
    }
    
    if (curr_type == NULL)
    {
        if (curr_fn_return_type != Type::voidType && printErrors)
        {
            ReportError::ReturnMismatch(this, Type::voidType, curr_fn_return_type); 
            
        }
        return; 
    }
    
    if (!curr_type->IsEquivalentTo(curr_fn_return_type))
    {
        bool errorAlreadyReported = false; 
        if (!curr_type->IsCompatibleWith(curr_fn_return_type, global_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope))
        {
            if (!errorAlreadyReported && printErrors)
            {
                ReportError::ReturnMismatch(this, curr_type, curr_fn_return_type); 
            }
        }
    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
 
}

Location *ReturnStmt::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
    if (expr != NULL)
    {
        Location *toReturn = expr->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    
        code_gen->GenReturn(toReturn); 
    }
    else
        code_gen->GenReturn(); 
    
    return NULL; 
}

  
PrintStmt::PrintStmt(List<Expr*> *a) {    
    Assert(a != NULL);
    (args=a)->SetParentAll(this);
}

void PrintStmt::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)  
{
    
    if (!printErrors)
        return; 
    
    for (int i = 0; i < args->NumElements(); i++)
    {
        Expr *curr = args->Nth(i); 
        curr->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
        Type *t = curr->GetType(); 
        
        if (t == Type::intType || t == Type::stringType || t == Type::boolType || t == Type::errorType)
        {
            continue; 
        }
        else
        {
            if (t != NULL)
            {
                ReportError::PrintArgMismatch(curr, i+1, t); 
            }
        }
    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

Location *PrintStmt::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
    for (int i = 0; i < args->NumElements(); i++)
    {
        Expr *e = args->Nth(i); 
        
        ArrayAccess *a = dynamic_cast<ArrayAccess *>(e); 
        
        
      //  Location *l = e->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
        
         Location *l = e->ReadValue(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
        
        /*
        Location *toUse; 
        if (a != NULL)
        {
            toUse = code_gen->GenLoad(l); 
        }
        else
        {
            toUse = l; 
        }*/
        
        Type *t = e->GetType(); 
        
        if (t == Type::intType)
            code_gen->GenBuiltInCall(PrintInt, l); 
        if (t == Type::boolType)
            code_gen->GenBuiltInCall(PrintBool, l); 
        if (t == Type::stringType)
        {
            code_gen->GenBuiltInCall(PrintString, l); 
        }
    }
    return NULL; 
}

