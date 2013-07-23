/* File: ast_expr.cc
 * -----------------
 * Implementation of expression node classes.
 */

#include <string.h>
#include "ast_expr.h"
#include "ast_type.h"
#include "ast_decl.h"


IntConstant::IntConstant(yyltype loc, int val) : Expr(loc) {
    value = val;
     type = Type::intType; 
}

void IntConstant::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    type = Type::intType; 
}

Location *IntConstant::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    return code_gen->GenLoadConstant(value); 
}

DoubleConstant::DoubleConstant(yyltype loc, double val) : Expr(loc) {
    value = val;
    type = Type::doubleType; 
}

void DoubleConstant::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    type = Type::doubleType; 
}

BoolConstant::BoolConstant(yyltype loc, bool val) : Expr(loc) {
    value = val;
    type = Type::boolType;
}

Location *BoolConstant::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    return code_gen->GenLoadConstant(value); 
}

Location *StringConstant::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    return code_gen->GenLoadConstant(value); 
}



void BoolConstant::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    type = Type::boolType; 
}

StringConstant::StringConstant(yyltype loc, const char *val) : Expr(loc) {
    Assert(val != NULL);
    value = strdup(val);
    type = Type::stringType; 
}

void StringConstant::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    type = Type::stringType; 
}

NullConstant::NullConstant(yyltype loc) : Expr(loc)
{
    type = Type::nullType; 
}

Operator::Operator(yyltype loc, const char *tok) : Node(loc) {
    Assert(tok != NULL);
    strncpy(tokenString, tok, sizeof(tokenString));
}
CompoundExpr::CompoundExpr(Expr *l, Operator *o, Expr *r) 
  : Expr(Join(l->GetLocation(), r->GetLocation())) {
    Assert(l != NULL && o != NULL && r != NULL);
    (op=o)->SetParent(this);
    (left=l)->SetParent(this); 
    (right=r)->SetParent(this);
}

CompoundExpr::CompoundExpr(Operator *o, Expr *r) 
  : Expr(Join(o->GetLocation(), r->GetLocation())) {
    Assert(o != NULL && r != NULL);
    left = NULL; 
    (op=o)->SetParent(this);
    (right=r)->SetParent(this);
}

int ArithmeticExpr::GetValue() 
{
    if (left != NULL)
    {
        if (strcmp(op->GetOperator(), "+") == 0)
            return left->GetValue() + right->GetValue(); 
        if (strcmp(op->GetOperator(), "-") == 0)
            return left->GetValue() - right->GetValue();
        if (strcmp(op->GetOperator(), "*") == 0)
            return left->GetValue() * right->GetValue(); 
        if (strcmp(op->GetOperator(), "/") == 0)
            return left->GetValue() / right->GetValue(); 
    }       
    else
    {
        if (strcmp(op->GetOperator(), "-") == 0)
            return (right->GetValue()) * -1;
    }
}
  
void ArithmeticExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    if (left != NULL)
        left->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    right->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    
    Type *left_type; 
    if (left != NULL)
        left_type = left->GetType(); 
    else
        left_type = NULL; 
    Type *right_type = right->GetType(); 
    
    bool to_continue = true; 
    
    if (left_type == NULL && left != NULL)
    {
        Identifier *left_id = left->GetNameId(); 
        
        Assert(left_id != NULL); 
        
        Decl *left_decl = everything.Lookup(left_id->GetName()); 
        
        if (left_decl == NULL)
        {
            to_continue = false; 
            if (printErrors)
            {
                type = Type::errorType; 
                ReportError::IdentifierNotDeclared(left_id, LookingForVariable); 
            }
        }
        else
        {
            VarDecl *var = dynamic_cast<VarDecl *>(left_decl); 
            Assert(var != NULL); 
            left_type = var->GetType(); 
        }
    }
    
    if (right_type == NULL && right != NULL)
    {
        Identifier *right_id = right->GetNameId(); 
        
        Assert(right_id != NULL); 
        
        Decl *right_decl = everything.Lookup(right_id->GetName()); 
        
        if (right_decl == NULL)
        {
            to_continue = false; 
            if (printErrors)
            {
                type = Type::errorType; 
                ReportError::IdentifierNotDeclared(right_id, LookingForVariable); 
            }
        }
        else
        {
            VarDecl *var = dynamic_cast<VarDecl *>(right_decl); 
            Assert(var != NULL); 
            right_type = var->GetType(); 
        }
    }
    
    
    if (to_continue)
    {
        if (left == NULL)
        {
            if (ArithAppropriate(right_type))
            {
                type = right_type; 
            }
            else
            {
                ReportError::IncompatibleOperand(op, right_type); 
                type = Type::errorType; 
            }
            return; 
        }
        
        
        if (left_type->IsEquivalentTo(right_type))
        {
            if ((left_type == Type::errorType) || (right_type == Type::errorType))
            {
                type = Type::errorType;   
            } 
            else if ((ArithAppropriate(left_type) && ArithAppropriate(right_type)))
            {
                type = left_type; 
            }
            else
            {
                type = Type::errorType; 
                ReportError::IncompatibleOperands(op, left_type, right_type); 
            }
        }
        else 
        {
            type = Type::errorType; 
            ReportError::IncompatibleOperands(op, left_type, right_type); 
            
        }
    }
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}
/*

bool CompoundExpr::ExprAppropriate(Type *t)
{
    if (t == Type::boolType || t == Type::stringType)
        return false; 
    return true; 
} */

bool ArithmeticExpr::ArithAppropriate(Type *t)
{
    if (t == Type::intType || t == Type::doubleType || t == Type::errorType)
        return true; 
    return false; 
}

Location *ArithmeticExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    Location *right_loc = right->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    Location *left_loc; 
    if (left != NULL)
    {
        left_loc = left->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
        return code_gen->GenBinaryOp(op->GetOperator(), left_loc, right_loc); 
    }
    else 
    {
        if (strcmp(op->GetOperator(), "-") == 0)
        {
            Location *place_holder = code_gen->GenLoadConstant(0); 
            
            return code_gen->GenBinaryOp("-", place_holder, right_loc); 
        }
    }
    return NULL; 
    
}

bool RelationalExpr::RelationalAppropriate(Type *t)
{
    if (t == Type::intType || t == Type::doubleType || t == Type::errorType)
        return true; 
    return false; 
}

void RelationalExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    left->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    right->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    
    Type *left_type = left->GetType(); 
    Type *right_type = right->GetType(); 
    
    bool to_continue = true; 
    
    if (left_type == NULL)
    {
        Identifier *left_id = left->GetNameId(); 
        
        Assert(left_id != NULL); 
        
        Decl *left_decl = everything.Lookup(left_id->GetName()); 
        
        if (left_decl == NULL)
        {
            to_continue = false; 
            if (printErrors)
            {
                ReportError::IdentifierNotDeclared(left_id, LookingForVariable); 
                type = Type::errorType; 
            }
        }
        else
        {
            VarDecl *var = dynamic_cast<VarDecl *>(left_decl); 
            Assert(var != NULL); 
            left_type = var->GetType(); 
        }
    }
    
    if (to_continue)
    {
        
        if (left_type->IsEquivalentTo(right_type))// && ExprAppropriate(left_type) && ExprAppropriate(right_type))
        {
            if ((left_type == Type::errorType) || (right_type == Type::errorType))
            {
                type = Type::errorType;   
            } 
            else if ((RelationalAppropriate(left_type) && RelationalAppropriate(right_type)))
            {
                type = Type::boolType; 
            }
            else
            {
                type = Type::boolType;  
                ReportError::IncompatibleOperands(op, left_type, right_type); 
            }
        }
        else 
        {
            type = Type::boolType; 
            ReportError::IncompatibleOperands(op, left_type, right_type); 
            
        }
    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

Location *RelationalExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    Location *left_loc = right->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    Location *right_loc = left->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn);
    
    const char *oper = op->GetOperator(); 
    
    if (strcmp(oper, "<") == 0) //supported by TAC
    { 
        return code_gen->GenBinaryOp(oper, right_loc, left_loc); 
    }
    if (strcmp(oper, ">") == 0) //flip the right and left side
    {
        return code_gen->GenBinaryOp("<", left_loc, right_loc); 
    }
    if (strcmp(oper, "<=") == 0)
    {
        Location *less_than = code_gen->GenBinaryOp("<", right_loc, left_loc); 
        Location *equals = code_gen->GenBinaryOp("==", left_loc, right_loc); 
       
        return code_gen->GenBinaryOp("||", less_than, equals); 
    }
    if (strcmp(oper, ">=") == 0)
    {
        Location *greater_than = code_gen->GenBinaryOp("<", left_loc, right_loc); 
        Location *equals = code_gen->GenBinaryOp("==", left_loc, right_loc); 
        
      //  code_gen->GenBuiltInCall(PrintBool, greater_than);
       // code_gen->GenBuiltInCall(PrintBool, equals); 
        
        return code_gen->GenBinaryOp("||", greater_than, equals); 
    }
    return NULL; 
}


Location *AssignExpr::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
    
    Location *right_loc = right->ReadValue(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    
    left->StoreInLValue(code_gen, class_scopes, interface_scopes, global_scope, break_label, curr_fn, right_loc); 
    
    
    Decl *matching_decl = NULL; 
    
    NewArrayExpr *right_new_array = dynamic_cast<NewArrayExpr *>(right); 
    
    if (right_new_array != NULL)
    {
        //store the location of the array (ie right_loc) in its corresponding VarDecl
        
        
        Decl *matching_decl = NULL; 
        
        const char *array_name = left->GetNameId()->GetName(); 
        
        if (everything.Lookup(array_name) != NULL)
        {
            matching_decl = everything.Lookup(array_name); 
        }
        else if (global_scope->Lookup(array_name) != NULL)
        {
            matching_decl = global_scope->Lookup(array_name); 
        }
        else if (curr_class != NULL && curr_class_full_scope->Lookup(array_name) != NULL)
        {
            matching_decl = curr_class_full_scope->Lookup(array_name); 
        }

        
        VarDecl *matching_var_decl = dynamic_cast<VarDecl *>(matching_decl); 
        
        Assert(matching_var_decl != NULL); 
        
        matching_var_decl->SetVarLocation(right_loc); 
        
    }
    
    return NULL; 
}

void AssignExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    /*
    if (!printErrors)
        return; 
    
    This *r = dynamic_cast<This*>(right); 
    
    left->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    if (r != NULL)
        r->CheckThis(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    else
        right->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
 //NEED TO MAKE SURE THAT LEFT SIDE IS L-VALUE   
 
    Type *left_type = left->GetType(); 
    Type *right_type = right->GetType(); 
    
    
    //Null check - if left_type is a NamedType, then right_type can be nullType. Otherwise, eror
    
    if (right_type == Type::nullType)
    {
        NamedType *left_type_named = dynamic_cast<NamedType *>(left_type); 
        if (left_type_named == NULL && left_type != Type::errorType)
        {
            ReportError::IncompatibleOperands(op, left_type, right_type); 
            
            
        }
        type = left_type; 
        return; 
    }
    
    
    bool to_continue = true; 
    
    if (left_type == NULL)
    {
        Identifier *left_id = left->GetNameId(); 
        
        Assert(left_id != NULL); 
        
        Decl *left_decl = everything.Lookup(left_id->GetName()); 
        
        if (left_decl == NULL)
        {
            to_continue = false; 
            if (printErrors)
            {
                type = Type::errorType; 
                ReportError::IdentifierNotDeclared(left_id, LookingForVariable); 
            }
        }
        else
        {
            VarDecl *var = dynamic_cast<VarDecl *>(left_decl); 
            Assert(var != NULL); 
            left_type = var->GetType(); 
        }
    }
    
    if (to_continue)
    {
        
        
        
        if (left_type->IsEquivalentTo(right_type))
        {
            type = left_type; 
        }
        else 
        {
            bool errorAlreadyReported = false; 
            if (right_type->IsCompatibleWith(left_type, prev_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope))
            {
                type = left_type; 
            }
            else
            {
                type = Type::errorType;
                
                if (!errorAlreadyReported)
                {
                    ReportError::IncompatibleOperands(op, left_type, right_type); 
                }
            }
        }
    }
     */
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}


void EqualityExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    left->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    right->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    
    Type *left_type = left->GetType(); 
    Type *right_type = right->GetType(); 
    
    //Null check - if right_type is null, then left_type must be null or a NamedType. otherwise, eror. 
    
    if (right_type == Type::nullType && left_type != Type::nullType)
    {
        NamedType *left_type_named = dynamic_cast<NamedType *>(left_type); 
        if (left_type_named == NULL)
        {
            ReportError::IncompatibleOperands(op, left_type, right_type); 
             
            
        }
        type = Type::boolType;
        return; 
    }
    
    bool to_continue = true; 
    
    if (left_type == NULL)
    {
        Identifier *left_id = left->GetNameId(); 
        
        Assert(left_id != NULL); 
        
        Decl *left_decl = everything.Lookup(left_id->GetName()); 
        
        if (left_decl == NULL)
        {
            to_continue = false; 
            if (printErrors)
            {
                type = Type::errorType; 
                ReportError::IdentifierNotDeclared(left_id, LookingForVariable); 
            }
        }
        else
        {
            VarDecl *var = dynamic_cast<VarDecl *>(left_decl); 
            Assert(var != NULL); 
            left_type = var->GetType(); 
        }
    }
    
    if (left_type == Type::voidType || right_type == Type::voidType)
    {
        ReportError::IncompatibleOperands(op, left_type, right_type); 
        type = Type::boolType; 
    }
    
    else if (left_type->IsEquivalentTo(right_type))
    {
        type = Type::boolType;  
    }
    else 
    {
        bool errorAlreadyReported = false; 
        if (right_type->IsCompatibleWith(left_type, prev_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope) || left_type->IsCompatibleWith(right_type, prev_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope))
        {
            type = Type::boolType; 
        }
        else
        {
            type = Type::boolType; 
            
            if (!errorAlreadyReported)
            {
                ReportError::IncompatibleOperands(op, left_type, right_type); 
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


Location *EqualityExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    Location *left_loc = right->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    Location *right_loc = left->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn);
    
    const char *oper = op->GetOperator(); 
    
    if (strcmp(oper, "==") == 0) //supported by TAC
    { 
        if (left->GetType() == Type::stringType && right->GetType() == Type::stringType)
        {
         //   code_gen->GenPushParam(left_loc); 
          //  code_gen->GenPushParam(right_loc); 
            return code_gen->GenBuiltInCall(StringEqual, left_loc, right_loc); 
        }
        return code_gen->GenBinaryOp(oper, right_loc, left_loc); 
    }
    if (strcmp(oper, "!=") == 0)
    {
      //[TODO]   
    }
    return NULL; 
}


void LogicalExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    if (left != NULL)
        left->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
   // if (right != NULL)
        right->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    
    Type *left_type; 
    if (left != NULL)
        left_type = left->GetType(); 
    else
        left_type = NULL; 
    Type *right_type = right->GetType(); 
   /* if (right != NULL)
        right_type = right->GetType(); */
    
    bool to_continue = true; 
    
    if (left_type == NULL && left != NULL)
    {
        Identifier *left_id = left->GetNameId(); 
        
        Assert(left_id != NULL); 
        
        Decl *left_decl = everything.Lookup(left_id->GetName()); 
        
        if (left_decl == NULL)
        {
            to_continue = false; 
            if (printErrors)
            {
                type = Type::errorType; 
                ReportError::IdentifierNotDeclared(left_id, LookingForVariable); 
            }
        }
        else
        {
            VarDecl *var = dynamic_cast<VarDecl *>(left_decl); 
            Assert(var != NULL); 
            left_type = var->GetType(); 
        }
    }
    
    if (to_continue)
    {
        if (left != NULL)
        {
            if (left_type == Type::boolType && right_type == Type::boolType)
            {
                type = Type::boolType; 
            }
            else 
            {
                type = Type::boolType; 
                ReportError::IncompatibleOperands(op, left_type, right_type); 
                
            }
        }
        else //if (left == NULL)
        {
            if (right_type == Type::boolType)
            {
                type = Type::boolType; 
            }
            else 
            {
                type = Type::boolType; 
                ReportError::IncompatibleOperand(op, right_type); 
                
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

Location *LogicalExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    Location *left_loc = right->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    Location *right_loc = left->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn);
    
    const char *oper = op->GetOperator(); 
    
    return code_gen->GenBinaryOp(oper, left_loc, right_loc); 
}


void This::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    if (curr_class == NULL)
    {
        ReportError::ThisOutsideClassScope(this); 
        type = Type::errorType; 
    }
    else
    {
        yyltype y; 
        Identifier *i = new Identifier(y, curr_class->GetId()->GetName()); 
        NamedType *n = new NamedType(i); 
        type = n; 
    }
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
    
}

void This::CheckThis(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    if (curr_class == NULL)
    {
        ReportError::ThisOutsideClassScope(this); 
        type = Type::errorType; 
    }
    else
    {
        yyltype y; 
        Identifier *i = new Identifier(y, curr_class->GetId()->GetName()); 
        NamedType *n = new NamedType(i); 
        type = n;
    }
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}
  
ArrayAccess::ArrayAccess(yyltype loc, Expr *b, Expr *s) : LValue(loc) {
    (base=b)->SetParent(this); 
    (subscript=s)->SetParent(this);
}

Identifier *ArrayAccess::GetNameId() 
{
    return base->GetNameId(); 
}

Location *ArrayAccess::ReadValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    Location *curr_loc = MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    return code_gen->GenLoad(curr_loc); 
}

void ArrayAccess::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    
    if (!printErrors)
        return; 
    
    base->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    subscript->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    //makes sure that the subscript is an int
    
    if (subscript->GetType() != Type::intType)
    {
        ReportError::SubscriptNotInteger(subscript); 
        type = Type::errorType; 
    }
    
    Identifier *array_id = GetArrayNameField(); 
    
    Decl *array; 
    
    if (everything.Lookup(array_id->GetName()) != NULL)
    {
        array = everything.Lookup(array_id->GetName()); 
    }
    else if (global_scope->Lookup(array_id->GetName()) != NULL)
    {
        array = global_scope->Lookup(array_id->GetName()); 
    }
    else
    {
        ReportError::IdentifierNotDeclared(array_id, LookingForVariable); 
        type = Type::errorType; 
        return;  
    }
    
    
    VarDecl *array_var = dynamic_cast<VarDecl *>(array); 
 
    Assert(array_var != NULL); 
    
    Type *t = array_var->GetType(); 
    
    ArrayType *array_var_type = dynamic_cast<ArrayType *>(t); 
    
    if (array_var_type == NULL)
    {
        ReportError::BracketsOnNonArray(base); 
        type = Type::errorType; 
        return; 
    }

    
    type = base->GetArrayAssignType(array_var_type); 
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

Type *ArrayAccess::GetArrayAssignType(ArrayType *array_var_type)
{
    Type *t = array_var_type->GetElemType(); 
    ArrayType *a = dynamic_cast<ArrayType *>(t); 
    
    if (a != NULL)
        return base->GetArrayAssignType(a); 
    return t; 
}

Location *ArrayAccess::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    Location *subscript_loc = subscript->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    
    int subscript_value = subscript->GetValue(); 
    
   //assume that array is singly nested
    
    FieldAccess *base_field_access = dynamic_cast<FieldAccess *>(base);
    
    Assert(base_field_access != NULL); 
    
    const char *base_name = base_field_access->GetNameId()->GetName(); 
    
    
    Decl *matching_decl = NULL; 
    
    if (everything.Lookup(base_name) != NULL)
    {
        matching_decl = everything.Lookup(base_name); 
    }
    else if (global_scope->Lookup(base_name) != NULL)
    {
        matching_decl = global_scope->Lookup(base_name); 
    }
    else if (curr_class != NULL && curr_class_full_scope->Lookup(base_name) != NULL)
    {
        matching_decl = curr_class_full_scope->Lookup(base_name); 
    }
    
    VarDecl *matching_var_decl = dynamic_cast<VarDecl *>(matching_decl); 
    
    Assert(matching_var_decl != NULL); 
    
    Location *array_loc = matching_var_decl->GetVarLocation(); //first element is the array size. 
    
    //make sure that subscript is less than array size. 
    
    Location *array_size = code_gen->GenLoad(array_loc); 
    
    Location *check_upper_bound_less_than = code_gen->GenBinaryOp("<", array_size, subscript_loc); 
    
    Location *check_upper_bound_equals = code_gen->GenBinaryOp("==", array_size, subscript_loc); 
    
    Location *check_upper_bound = code_gen->GenBinaryOp("||", check_upper_bound_equals, check_upper_bound_less_than); 
    
    Location *zero = code_gen->GenLoadConstant(0); 
    
    Location *check_lower_bound = code_gen->GenBinaryOp("<", subscript_loc, zero); 
    
    Location *check_both = code_gen->GenBinaryOp("||", check_upper_bound, check_lower_bound); 
    
    char *else_label = code_gen->NewLabel(); 
    
    code_gen->GenIfZ(check_both, else_label); 
    
    Location *error_msg = code_gen->GenLoadConstant("Decaf runtime error: Array subscript out of bounds\\n"); 
    
    code_gen->GenBuiltInCall(PrintString, error_msg); 
    
    code_gen->GenBuiltInCall(Halt); 
    
    code_gen->GenLabel(else_label); 
    
    
    // returns correct array location
    
    Location *offset = code_gen->GenLoadConstant((subscript_value+1)*4); 
    
    return code_gen->GenBinaryOp("+", array_loc, offset); 
    
  //  return code_gen->GenLoad(array_loc, (subscript_value+1)*4); 
    
  /*  Location *curr_array_elem = new Location(array_loc, (subscript_value+1)*4,); 
   // code_gen->nextLocalOffset -= 4; 
    code_gen->currFunctionFrameSize += 4; */
    
    //return curr_array_elem; 
  
    
    
    

}

Location *FieldAccess::ReadValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    if (base == NULL)
    {
        Location *curr_loc = MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
        if (curr_class == NULL)
        {
            return curr_loc; 
        }
        else
        {
            Hashtable<Decl*> *curr_class_scope = class_scopes->Lookup(curr_class->GetName()); 
            
            Decl *d = curr_class_scope->Lookup(field->GetName()); 
            
            VarDecl *curr_var_decl = dynamic_cast<VarDecl *>(d); 
            
            if (curr_var_decl == NULL) //ie this variable is not an instance variable
            {
                return curr_loc; 
            }
            else //this variable is an instance variable
            {
                return code_gen->GenLoad(curr_loc); 
            }
                
                
            
        }
    }
}
    
void FieldAccess::StoreInLValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn, Location *to_assign)
{
    Location *curr_loc = MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    if (base == NULL)
    {
        if (curr_class == NULL)
        {
            code_gen->GenAssign(curr_loc, to_assign); 
        }
        else if (curr_class != NULL)
        {
            code_gen->GenStore(curr_loc, to_assign); 
        }
    }
    else
    {
        //[TODO]
    }
}

Location *FieldAccess::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    
    
    
    if (base == NULL)
    {
               
        Decl *matching_decl = NULL; 
        
        if (code_gen->currParametersLocations->Lookup(field->GetName()) != NULL)
        {
            return code_gen->currParametersLocations->Lookup(field->GetName()); 
        }
        
        if (everything.Lookup(field->GetName()) != NULL)
        {
            matching_decl = everything.Lookup(field->GetName()); 
        }
        else if (global_scope->Lookup(field->GetName()) != NULL)
        {
            matching_decl = global_scope->Lookup(field->GetName()); 
        }
        else if (curr_class != NULL && curr_class_full_scope->Lookup(field->GetName()) != NULL)
        {
            matching_decl = curr_class_full_scope->Lookup(field->GetName()); 
        }

        VarDecl *v = dynamic_cast<VarDecl*>(matching_decl);
        Assert(v != NULL); 
        
        if (v->GetVarLocation() != NULL)
        {
            return v->GetVarLocation(); 
        }
        else
        {
            /*
            if (curr_fn != NULL)
            {
                List<VarDecl*> *formals = curr_fn->GetFormals(); 
                for (int i = 0; i < formals->NumElements(); i++)
                {
                    if (strcmp(formals->Nth(i)->GetName(), v->GetName()) == 0)
                    {
                        //current variable being called is a function argument thus stored with the rest of the params
                        Location *fp = new Location(fpRelative, 0, "fp"); 
                        Location *new_loc = new Location(fpRelative, code_gen->nextLocalOffset, field->GetName()); 
                        code_gen->nextLocalOffset -= 4; 
                        v->SetVarLocation(new_loc); 
                        code_gen->GenStore(fp, new_loc, 4*(i+1)); 
                       // v->SetVarLocation(code_gen->GenLoad(fp, (4*(i+1)))); 
                        return v->GetVarLocation(); 
                        ; 
                    }
                }
            }
            */
            
            if (curr_class != NULL)
            {
                Location *implicit_this = new Location(fpRelative, 4, "this"); 
                
                Hashtable<Decl*> *curr_class_scope = class_scopes->Lookup(curr_class->GetName()); 
                Decl *d = curr_class_scope->Lookup(field->GetName()); 
                VarDecl *curr_var = dynamic_cast<VarDecl*>(d); 
                Assert(curr_var != NULL); 
                Location *curr_var_offset = code_gen->GenLoadConstant(curr_var->GetOffset()); 
                Location *curr_var_loc = code_gen->GenBinaryOp("+", implicit_this, curr_var_offset); 
                return curr_var_loc; 
                
            }
            
            v->SetVarLocation(new Location(fpRelative, code_gen->nextLocalOffset, field->GetName())); 
            code_gen->nextLocalOffset -= 4; 
            code_gen->currFunctionFrameSize += 4; 
            return v->GetVarLocation(); 
        }
        
        /*
        if (loc == NULL)
        {
            loc = new Location(fpRelative, code_gen->nextLocalOffset, field->GetName());
            code_gen->nextLocalOffset -= 4; 
            return loc; 
        }
        else
        {
            return loc; 
        } */
    }
    else if (base != NULL) //[TODO]
    {
        
    }
    return NULL; 
   
}

void ArrayAccess::StoreInLValue(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn, Location *to_assign)
{
    //set array elem value
    Location *curr_loc = MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    code_gen->GenStore(curr_loc, to_assign); 
    return; 
}

Type *FieldAccess::GetArrayAssignType(ArrayType *array_var_type)
{
    return (array_var_type->GetElemType()); 
}
      
        
    
Identifier *ArrayAccess::GetArrayNameField()
{
    return (base->GetArrayNameField()); 
}

FieldAccess::FieldAccess(Expr *b, Identifier *f) 
  : LValue(b? Join(b->GetLocation(), f->GetLocation()) : *f->GetLocation()) {
    Assert(f != NULL); // b can be be NULL (just means no explicit base)
    base = b; 
    if (base) base->SetParent(this); 
    (field=f)->SetParent(this);
    loc = NULL; 
}

void FieldAccess::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    
    if (!printErrors)
        return; 
    
    if (base == NULL)
    {
        
        Decl *matching_decl; 
        
        if (everything.Lookup(field->GetName()) != NULL)
        {
            matching_decl = everything.Lookup(field->GetName()); 
        }
        else if (global_scope->Lookup(field->GetName()) != NULL)
        {
            matching_decl = global_scope->Lookup(field->GetName()); 
        }
        else if (curr_class != NULL && curr_class_full_scope->Lookup(field->GetName()) != NULL)
        {
            matching_decl = curr_class_full_scope->Lookup(field->GetName()); 
        }
        else
        {
            ReportError::IdentifierNotDeclared(field, LookingForVariable); 
            type = Type::errorType; 
            return; 
        }
        
        VarDecl *matching_var_decl = dynamic_cast<VarDecl *>(matching_decl); 
        
        if (matching_var_decl == NULL)
        {
            ReportError::IdentifierNotDeclared(field, LookingForVariable); 
            type = Type::errorType; 
            return; 
        }
        
        type = matching_var_decl->GetType(); 
    }
    
    else
    {
        
        NamedType *inner_named_type; 
        VarDecl *matching_var_decl; 
        FieldAccess *inner = dynamic_cast<FieldAccess *>(base); 
        
        ArrayAccess *inner_array_access = dynamic_cast<ArrayAccess *>(base); 
        
        const char *calling_object_name; 
        const char *inner_type_name; 
        This *inner_this = dynamic_cast<This *>(base); 
        
       
        if (inner != NULL)
        {
            calling_object_name = inner->GetNameId()->GetName(); 
            
            Decl *matching_decl; 
            
            if (everything.Lookup(calling_object_name) != NULL)
            {
                matching_decl = everything.Lookup(calling_object_name); 
            }
            else if (global_scope->Lookup(calling_object_name) != NULL)
            {
                matching_decl = global_scope->Lookup(calling_object_name); 
            }
            else
            {
                ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable);
                type = Type::errorType; 
                return; 
            }
            
            matching_var_decl = dynamic_cast<VarDecl *>(matching_decl); 
            
            if (matching_var_decl == NULL)
            {
                ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                type = Type::errorType; 
                return; 
            }
            
            Type *inner_type = matching_var_decl->GetType(); 
            inner_named_type = dynamic_cast<NamedType *>(inner_type); 
            
            if (inner_named_type == NULL)
            {
                ReportError::FieldNotFoundInBase(field, inner_type); 
                type = Type::errorType; 
                return; 
            }
            
            inner_type_name = inner_named_type->GetId()->GetName(); 
        }
        else if (inner_array_access != NULL)
        {
            calling_object_name = inner_array_access->GetArrayNameField()->GetName(); 
            
            Decl *matching_decl; 
            
            if (everything.Lookup(calling_object_name) != NULL)
            {
                matching_decl = everything.Lookup(calling_object_name); 
            }
            else if (global_scope->Lookup(calling_object_name) != NULL)
            {
                matching_decl = global_scope->Lookup(calling_object_name); 
            }
            else
            {
                ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable);
                type = Type::errorType; 
                return; 
            }
            
            matching_var_decl = dynamic_cast<VarDecl *>(matching_decl); 
            
            if (matching_var_decl == NULL)
            {
                ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                type = Type::errorType; 
                return; 
            }
            
            ArrayType *a = dynamic_cast<ArrayType *>(matching_var_decl->GetType()); 
            
            Type *inner_array_access_type = inner_array_access->GetBase()->GetArrayAssignType(a); 
            
            NamedType *n = dynamic_cast<NamedType *>(inner_array_access_type); 
            
            if (n == NULL) //means that we're dealing w/ array
            {
                ReportError::FieldNotFoundInBase(field, inner_array_access_type); 
                type = Type::errorType; 
                return; 
            }
            inner_type_name = n->GetId()->GetName(); 
            inner_named_type = n; 

        }
        else if (inner_this != NULL)
        {
           
            
            
            if (curr_class == NULL)
            {
                ReportError::ThisOutsideClassScope(inner_this); 
                type = Type::errorType; 
                return; 
            }
            
           
            inner_type_name = curr_class->GetId()->GetName(); 
            
           
            Decl *d; 
            
            if (curr_class_full_scope->Lookup(field->GetName()) != NULL)
            {
                d =  curr_class_full_scope->Lookup(field->GetName());
            }
            else if (everything.Lookup(field->GetName()) != NULL)
            {
                d = everything.Lookup(field->GetName()); 
            }
            else if (global_scope->Lookup(field->GetName()) != NULL)
            {
                d = global_scope->Lookup(field->GetName()); 
            }
            else
            {
                ReportError::IdentifierNotDeclared(field, LookingForVariable);
                type = Type::errorType; 
                return; 
            }
            
            matching_var_decl = dynamic_cast<VarDecl *>(d); 
            
            if (matching_var_decl == NULL)
            {
                ReportError::IdentifierNotDeclared(field, LookingForVariable); 
                type = Type::errorType; 
                return;
            }
            yyltype y; 
            Identifier *i = new Identifier(y, inner_type_name); 
            inner_named_type = new NamedType(i); 
            
            
        }
        
        
        
        Hashtable<Decl*> *inner_type_scope = class_scopes->Lookup(inner_type_name); 
        
        Assert(inner_type_scope != NULL); 
        
        if (inner_type_scope->Lookup(field->GetName()) == NULL)
        {
            if (curr_class != NULL && curr_class_full_scope->Lookup(field->GetName()) == NULL)
            {
            
                ReportError::FieldNotFoundInBase(field, inner_named_type); 
            
                type = Type::errorType; 
                return; 
            }
            if (curr_class == NULL)
            {
                ReportError::FieldNotFoundInBase(field, inner_named_type); 
                
                type = Type::errorType; 
                return; 
            }
        }
        
        if (curr_class == NULL)
        {
            ReportError::InaccessibleField(field, inner_named_type);
            type = Type::errorType; 
            return; 
        }
        if (strcmp(curr_class->GetId()->GetName(), inner_type_name) != 0)
        {
            ReportError::InaccessibleField(inner_named_type->GetId(), inner_named_type) ;
            type = Type::errorType; 
            return;
        }
        
        
        //recursively checks the next one
        if (inner != NULL)
        {
            inner->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope);
        }
        if (inner_array_access != NULL)
        {
             inner_array_access->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope);
        }
        if (inner_this != NULL)
        {
            inner_this->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope);
        }
        
        Decl *outer_decl = curr_class_full_scope->Lookup(field->GetName()); 
        VarDecl *outer_var = dynamic_cast<VarDecl *>(outer_decl); 
        
        if (outer_var == NULL)
        {
            ReportError::FieldNotFoundInBase(field, inner_named_type); 
            type = Type::errorType; 
            return; 
        }
        
        type = outer_var->GetType(); 
        

    }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
    
}

Identifier *FieldAccess::GetArrayNameField() 
{
    return field; 
}

Call::Call(yyltype loc, Expr *b, Identifier *f, List<Expr*> *a) : Expr(loc)  {
    Assert(f != NULL && a != NULL); // b can be be NULL (just means no explicit base)
    base = b;
    if (base) base->SetParent(this);
    (field=f)->SetParent(this);
    (actuals=a)->SetParentAll(this);
}

void Call::CheckArgumentsAgainstActualFunction(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, FnDecl *fn_called, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    List<VarDecl*> *called_fn_formals = fn_called->GetFormals(); 
    
    int args_expected = called_fn_formals->NumElements(); 
    int args_given = actuals->NumElements(); 
    
    
    if (args_expected != args_given)
    {
        ReportError::NumArgsMismatch(field, args_expected, args_given); 
        type = Type::errorType; 
        return; 
    }
    
    
    
    for (int i = 0; i < args_given; i++)
    {
        if (i >= args_expected)
            break; 
        Expr *given_expr = actuals->Nth(i); 
        given_expr->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
        
        Type *given_type = given_expr->GetType(); 
        
        if (given_type == NULL)
        {
            FieldAccess *f = dynamic_cast<FieldAccess *>(given_expr); 
            Decl *d = everything.Lookup(f->GetNameId()->GetName()); 
            VarDecl *curr_var = dynamic_cast<VarDecl *>(d); 
            
            if (curr_var == NULL)
            {
                ReportError::IdentifierNotDeclared(f->GetNameId(), LookingForVariable); 
                continue; 
            }
            else
            {
                given_type = curr_var->GetType(); 
            }
        }
        
        VarDecl *expected_var = called_fn_formals->Nth(i); 
        
        if (!expected_var->GetType()->IsEquivalentTo(given_type))
        {
            bool errorAlreadyReported = false; 
            
            if (!given_type->IsCompatibleWith(expected_var->GetType(), prev_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope))
            {
                if (!errorAlreadyReported)
                {
                    ReportError::ArgMismatch(given_expr, i+1, given_type, expected_var->GetType()); 
                    type = Type::errorType; 
                }
            }
            
        }
    }
    
    type = fn_called->GetReturnType(); 

}

void Call::PrintAll(Hashtable<Decl *> *matching_scope)
{
    Iterator<Decl*> iter = matching_scope->GetIterator(); 
    Decl *i = iter.GetNextValue(); 
    
    while (i != NULL)
    {
        string str; 
        VarDecl *v = dynamic_cast<VarDecl *>(i); 
        if (v != NULL) str = "(vardecl)"; 
        FnDecl *f = dynamic_cast<FnDecl *>(i); 
        if (f != NULL) str = "(fndecl)"; 
        ClassDecl *c = dynamic_cast<ClassDecl *>(i); 
        if (c != NULL)
            str = "(classdecl)"; 
        
        cout << i << "  - " << str << endl; 
       
        i = iter.GetNextValue(); 
    }
}

void Call::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
/*
    if (!printErrors)
    {
        return; 
    }
    
    if (base == NULL)
    {
        Decl *d; 
        
        if (everything.Lookup(field->GetName()) != NULL)
        {
            d = everything.Lookup(field->GetName()); 
        }
        else if (global_scope->Lookup(field->GetName()) != NULL)
        {
            d = global_scope->Lookup(field->GetName()); 
        }
        else if (curr_class != NULL && curr_class_full_scope->Lookup(field->GetName()) != NULL)
        {
            d = curr_class_full_scope->Lookup(field->GetName()); 
        }
        else
        {
            ReportError::IdentifierNotDeclared(field, LookingForFunction);
            type = Type::errorType; 
            return;
        }
        
        FnDecl *fn_called = dynamic_cast<FnDecl *>(d); 
        
        if (fn_called == NULL)
        {
            ReportError::IdentifierNotDeclared(field, LookingForFunction); 
            type = Type::errorType; 
            return; 
        }
        
        type = fn_called->GetReturnType(); 
        
        //CHECK ARGUMENTS AGAINST ACTUAL FUNCTION CALL
        
       CheckArgumentsAgainstActualFunction(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, fn_called, curr_class, curr_class_full_scope); 
        
                
    }
    
    else
    {
        //check for special case: arr.length(); 
        FieldAccess *inner = dynamic_cast<FieldAccess *>(base); 
        
        if (strcmp(field->GetName(),"length") == 0 && actuals->NumElements() == 0)
        {
            Decl *d = NULL; 
            
            if (everything.Lookup(inner->GetNameId()->GetName()) != NULL)
            {
                d = everything.Lookup(inner->GetNameId()->GetName()); 
            }
            else if (global_scope->Lookup(inner->GetNameId()->GetName()) != NULL)
            {
                d = global_scope->Lookup(inner->GetNameId()->GetName()); 
            }
            if (d == NULL)
            {
                ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                type = Type::errorType; 
                return; 
            }
            else
            {
                VarDecl *var_decl = dynamic_cast<VarDecl *>(d); 
                if (var_decl == NULL)
                {
                    ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                    type = Type::errorType;
                    return; 
                }
                else
                {
                    Type *var_type = var_decl->GetType();
                    ArrayType *var_type_array = dynamic_cast<ArrayType *>(var_type); 
                    if (var_type_array == NULL)
                    {
                        ReportError::FieldNotFoundInBase(field, var_type);
                        type = Type::errorType; 
                        return; 
                    }
                }
            }
                                                            
            type = Type::intType; 
        }
        else
        {
            
            FieldAccess *inner = dynamic_cast<FieldAccess *>(base); 
            
            //make sure that the inner->field->name is actually a class or interface name
            
            ArrayAccess *inner_array_access = dynamic_cast<ArrayAccess *>(base); 
            
            Call *call = dynamic_cast<Call *>(base); 
            
            NamedType *base_type; 
            
            if (inner_array_access != NULL || inner != NULL)
            {
                
                if (inner_array_access != NULL)
                {
                    Identifier *inner_array_id = inner_array_access->GetArrayNameField(); 
                    
                    Decl *d = NULL; 
                    
                    if (everything.Lookup(inner_array_id->GetName()) != NULL)
                    {
                        d = everything.Lookup(inner_array_id->GetName()); 
                    }
                    else if (global_scope->Lookup(inner_array_id->GetName()) != NULL)
                    {
                        d = global_scope->Lookup(inner_array_id->GetName()); 
                    }
                    if (d == NULL)
                    {
                        ReportError::IdentifierNotDeclared(inner_array_id, LookingForVariable); 
                        type = Type::errorType; 
                        return; 
                    }
                    
                    VarDecl *base_array = dynamic_cast<VarDecl *>(d); 
                    
                    if (base_array == NULL)
                    { 
                        ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                        type = Type::errorType; 
                        return;
                    }
                    
                    Type *inner_type = base_array->GetType(); 
                    
                    if (base_array == NULL)
                    { 
                        ReportError::IdentifierNotDeclared(inner_array_id, LookingForVariable); 
                        type = Type::errorType; 
                        return;
                    }
                    
                    NamedType *base_type_temp = dynamic_cast<NamedType*>(base_array->GetType()); 
                   
                    
                    if (base_type_temp == NULL) 
                    {
                        ArrayType *a = dynamic_cast<ArrayType *>(inner_type); 
                        Type *inner_array_access_type = inner_array_access->GetBase()->GetArrayAssignType(a); 
                        base_type = dynamic_cast<NamedType *>(inner_array_access_type); 
                        
                        if (base_type == NULL)  //means that it's an array type
                        {
                            
                            ReportError::FieldNotFoundInBase(field, inner_array_access_type); 
                            type = Type::errorType; 
                            return; 
                        }
                        
                    }
                }
                
                if (inner != NULL)
                {
                    
                    const char *base_name = inner->GetNameId()->GetName();
                    
                    //finds the corresponding declaration
                    
                    Decl *d = NULL; 
                    
                    if (everything.Lookup(inner->GetNameId()->GetName()) != NULL)
                    {
                        d = everything.Lookup(inner->GetNameId()->GetName()); 
                    }
                    else if (global_scope->Lookup(inner->GetNameId()->GetName()) != NULL)
                    {
                        d = global_scope->Lookup(inner->GetNameId()->GetName()); 
                    }
                    if (d == NULL)
                    {
                        ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                        type = Type::errorType; 
                        return; 
                    }
                    
                    
                    VarDecl *base_var = dynamic_cast<VarDecl *>(d); 
                    
                    if (base_var == NULL)
                    { 
                        ReportError::IdentifierNotDeclared(inner->GetNameId(), LookingForVariable); 
                        type = Type::errorType; 
                        return;
                    }
                    
                    base_type = dynamic_cast<NamedType*>(base_var->GetType()); 
                    
                    if (base_type == NULL)
                    {
                        ReportError::FieldNotFoundInBase(field, base_var->GetType()); 
                        type = Type::errorType; 
                        return; 
                    }
                }
                
                const char *base_type_name = base_type->GetName();  //base type name - should be a class or interface otherwise error. 
                
                Hashtable<Decl*> *matching_scope = NULL; 
                
                //sees if base_type_name is a class
                matching_scope = class_scopes->Lookup(base_type_name); 
                
                if (matching_scope == NULL)
                {
                    //sees if base_type_name is an interface
                    matching_scope = interface_scopes->Lookup(base_type_name); 
                    
                    if (matching_scope == NULL)
                    {
                        //ReportError::IdentifierNotDeclared(base_type->GetId(), LookingForType); 
                        type = Type::errorType; 
                        return; 
                    }
                }
                
                
                for (int i = 0 ; i < actuals->NumElements(); i++)
                {
                    Expr *e = actuals->Nth(i); 
                    e->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
                }
                
                
                
                Decl *inside_type = matching_scope->Lookup(field->GetName());
                
                if (inside_type == NULL && curr_class != NULL)
                {
                    
                    inside_type = curr_class_full_scope->Lookup(field->GetName()); 
                }
                
                FnDecl *inside_type_fn;
                
                if (inside_type == NULL)
                {
                    ReportError::FieldNotFoundInBase(field, base_type); 
                    type = Type::errorType; 
                    return; 
                }
                else
                {
                    
                    inside_type_fn = dynamic_cast<FnDecl *>(inside_type); 
                    
                    VarDecl *v = dynamic_cast<VarDecl *>(inside_type); 
                    
                    ClassDecl *c = dynamic_cast<ClassDecl *>(inside_type); 
                    
                    if (inside_type_fn == NULL)
                    {
                        ReportError::FieldNotFoundInBase(field, base_type); 
                        type = Type::errorType; 
                        //return; 
                    }
                }
                
                type = inside_type_fn->GetReturnType(); 
                
                //check arguments
                
                CheckArgumentsAgainstActualFunction(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, inside_type_fn, curr_class, curr_class_full_scope); 
                
                //checks the inner fieldAccess or ArrayAccess
                if (inner != NULL)
                    inner->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
                else
                    inner_array_access->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
            }
            
            //e.g temp.GetPrev().SetNext()
        
        
        if (call != NULL)
        {
            call->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope);
            Type *call_type = call->GetType(); 
            
            if (call_type == Type::errorType)
            {
                type = Type::errorType; 
                return; 
            }
            
            NamedType *call_named_type = dynamic_cast<NamedType *>(call_type); 
            
            Hashtable<Decl *> *curr_scope = class_scopes->Lookup(call_named_type->GetId()->GetName()); 
            
            if (curr_scope == NULL)
            {
                curr_scope = interface_scopes->Lookup(call_named_type->GetId()->GetName()); 
                
                Assert(curr_scope != NULL); 
            }
            
            Decl *d = curr_scope->Lookup(field->GetName()); 
            
            if (d == NULL)
            {
                ReportError::IdentifierNotDeclared(field, LookingForFunction); 
                type = Type::errorType; 
                return; 
            }
            FnDecl *fn_decl = dynamic_cast<FnDecl *>(d); 
            
            if (fn_decl == NULL)
            {
                ReportError::IdentifierNotDeclared(field, LookingForFunction); 
                type = Type::errorType; 
                return; 
            }
            
            type = fn_decl->GetReturnType(); 
            CheckArgumentsAgainstActualFunction(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, fn_decl, curr_class, curr_class_full_scope); 
            call->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
            
        }
        
    }
    
    
    
}*/
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
    //NEED TO DO IF BASE != NULL
}

Location *Call::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    FieldAccess *inner = dynamic_cast<FieldAccess *>(base); 
    
    if (strcmp(field->GetName(), "length") == 0)
    {
        Decl *matching_decl = NULL; 
        
        const char *array_name = inner->GetNameId()->GetName(); 
        
        if (everything.Lookup(array_name) != NULL)
        {
            matching_decl = everything.Lookup(array_name); 
        }
        else if (global_scope->Lookup(array_name) != NULL)
        {
            matching_decl = global_scope->Lookup(array_name); 
        }
        else if (curr_class != NULL && curr_class_full_scope->Lookup(array_name) != NULL)
        {
            matching_decl = curr_class_full_scope->Lookup(array_name); 
        }
        
        VarDecl *matching_var_decl = dynamic_cast<VarDecl*>(matching_decl); 
        
        Location *array_loc = matching_var_decl->GetVarLocation(); 
        
        return code_gen->GenLoad(array_loc); 
    }
    
    return Emit(code_gen, class_scopes, interface_scopes, global_scope, NULL, curr_fn); 

}

Location *Call::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, const char *break_label, FnDecl *curr_fn)
{
    if (base == NULL)
    {
        
        Decl *curr = global_scope->Lookup(field->GetName()); 
        
        FnDecl *curr_fn_called = dynamic_cast<FnDecl*>(curr); 
        
        if (curr_fn_called != NULL) //means that the function being called is a global function, regardless of whether we are in a class or not. 
        {
            //should just do this if we're calling a global function.                                     
            
            int numBytesOfParams = 0; 
            for (int i = (actuals->NumElements() - 1); i >= 0; i--)
            {
                Location *l = actuals->Nth(i)->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
                code_gen->GenPushParam(l); 
                numBytesOfParams += 4; 
            }
            
            string str = field->GetName(); 
            str = "_" + str; 
            
            Decl *d = global_scope->Lookup(field->GetName()); 
            FnDecl *called_fn = dynamic_cast<FnDecl*>(d); 
            Assert(called_fn != NULL); 
            
            bool hasReturnValue;          
            
            if (called_fn->GetReturnType() == Type::voidType)
                hasReturnValue = false; 
            else
                hasReturnValue = true; 
            
            Location *return_val = code_gen->GenLCall(str.c_str(), hasReturnValue); 
            
            code_gen->GenPopParams(numBytesOfParams); 
            
            return return_val; 
        }
        else
        {
            if (curr_class != NULL) //we are in a class and calling one of the class's methods
                //need to call it the way we would call a method with implicit this and such. 
                //where we are right now, implicit this is the 1st parameter so fp+4
            {
                Decl *matching_decl = NULL; 
                
                Hashtable<Decl*> *curr_class_scope = class_scopes->Lookup(curr_class->GetName()); 
                matching_decl = curr_class_scope->Lookup(field->GetName()); 
                FnDecl *matching_fn_decl = dynamic_cast<FnDecl*>(matching_decl); 
                
                Assert(matching_fn_decl != NULL); 
                
                int vtable_offset = matching_fn_decl->GetOffset(); 
                
                Location *implicit_this_ptr = new Location(fpRelative, 4, "this");
                
               // Location *implicit_this = code_gen->GenLoad(implicit_this_ptr); 
                
                Location *VTable = code_gen->GenLoad(implicit_this_ptr);  
                
                Location *vtable_offset_loc = code_gen->GenLoadConstant(vtable_offset); 
                
                Location *fn_addr_ptr = code_gen->GenBinaryOp("+", vtable_offset_loc, VTable); 
                
                Location *fn_addr = code_gen->GenLoad(fn_addr_ptr);
                
                bool hasReturnValue; 
                
                if (matching_fn_decl->GetReturnType() == Type::voidType)
                    hasReturnValue = false; 
                else
                    hasReturnValue = true; 
                
                //load parameters (except the implicit this)
                int numBytesOfParams = 0; 
                
                for (int i = (actuals->NumElements() - 1); i >= 0; i--)
                {
                    Location *l = actuals->Nth(i)->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
                    code_gen->GenPushParam(l); 
                    numBytesOfParams += 4; 
                }
                
                //load the implicit this
                
                numBytesOfParams += 4;
                code_gen->GenPushParam(implicit_this_ptr); 
                
                //ACall
                Location *return_val = code_gen->GenACall(fn_addr, hasReturnValue); 
                
                code_gen->GenPopParams(numBytesOfParams); 
                
                return return_val; 
            }
        }
 
    }
    else
    {
        FieldAccess *inner = dynamic_cast<FieldAccess *>(base); 
        
        if (strcmp(field->GetName(), "length") == 0)
        {
            Decl *matching_decl = NULL; 
            
            const char *array_name = inner->GetNameId()->GetName(); 
            
            if (everything.Lookup(array_name) != NULL)
            {
                matching_decl = everything.Lookup(array_name); 
            }
            else if (global_scope->Lookup(array_name) != NULL)
            {
                matching_decl = global_scope->Lookup(array_name); 
            }
            else if (curr_class != NULL && curr_class_full_scope->Lookup(array_name) != NULL)
            {
                matching_decl = curr_class_full_scope->Lookup(array_name); 
            }
            
            VarDecl *matching_var_decl = dynamic_cast<VarDecl*>(matching_decl); 
            
            Location *array_loc = matching_var_decl->GetVarLocation(); 
            
            return code_gen->GenLoad(array_loc); 
        }
        else
        {
            //assume that this is not nested calls, but is just a call e.g
            //Rupa r; 
            //r.Sleep(); 
            
            Decl *matching_decl = NULL; 
            
            const char *var_name = inner->GetNameId()->GetName(); 
            
            if (everything.Lookup(var_name) != NULL)
            {
                matching_decl = everything.Lookup(var_name); 
            }
            else if (global_scope->Lookup(var_name) != NULL)
            {
                matching_decl = global_scope->Lookup(var_name); 
            }
            else if (curr_class != NULL && curr_class_full_scope->Lookup(var_name) != NULL)
            {
                matching_decl = curr_class_full_scope->Lookup(var_name); 
            }
            
            VarDecl *matching_var_decl = dynamic_cast<VarDecl*>(matching_decl); 
            
            Assert(matching_var_decl != NULL); 
            
            Location *var_loc_ptr = matching_var_decl->GetVarLocation(); 
            
            Type *t = matching_var_decl->GetType(); 
            
            NamedType *base_named_type = dynamic_cast<NamedType*>(t); 
            
            const char *class_name = base_named_type->GetName(); 
            
            //gets the vtable
            
           // Location *var_loc = code_gen->GenLoad(var_loc_ptr);  
            
            Location *VTable = code_gen->GenLoad(var_loc_ptr); 
            
            //gets the class scope of the type to find the FnDecl that we are calling so we can get the offset
            
            Hashtable<Decl*> *called_class_scope = class_scopes->Lookup(class_name); 
            
            //Looking for the FnDecl in called_class_scope
            
            Decl *d = called_class_scope->Lookup(field->GetName()); 
            
            FnDecl *fn_called = dynamic_cast<FnDecl*>(d); 
            
            //getting the offset
            int vtable_offset = fn_called->GetOffset(); 
            
            Location *vtable_offset_loc = code_gen->GenLoadConstant(vtable_offset); 
            
            Location *fn_addr_ptr = code_gen->GenBinaryOp("+", vtable_offset_loc, VTable); 
            
            Location *fn_addr = code_gen->GenLoad(fn_addr_ptr); 
            
            bool hasReturnValue; 
            
            if (fn_called->GetReturnType() == Type::voidType)
                hasReturnValue = false; 
            else
                hasReturnValue = true; 
      
            int numBytesOfParams = 0; 
            for (int i = (actuals->NumElements() - 1); i >= 0; i--)
            {
                Location *l = actuals->Nth(i)->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
                code_gen->GenPushParam(l); 
                numBytesOfParams += 4; 
            }
            code_gen->GenPushParam(var_loc_ptr); 
            numBytesOfParams += 4; 
            
            Location *return_val = code_gen->GenACall(fn_addr, hasReturnValue); 
            
            code_gen->GenPopParams(numBytesOfParams); 
            
            return return_val; 
        }
    }
    return NULL; 
                      
}
 

NewExpr::NewExpr(yyltype loc, NamedType *c) : Expr(loc) { 
  Assert(c != NULL);
  (cType=c)->SetParent(this);
}

void NewExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    if (!printErrors)
        return; 
    
    const char *name = cType->GetName(); 
    
    if (class_scopes->Lookup(name) == NULL)
    {
        ReportError::IdentifierNotDeclared(cType->GetId(), LookingForClass); 
        type = Type::errorType; 
    }
    else
    {
        type = cType;
    }
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
}

Location *NewExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    const char *object_type_name = cType->GetId()->GetName(); 
    
    Decl *d = global_scope->Lookup(object_type_name); 
    
    ClassDecl *object_decl = dynamic_cast<ClassDecl*>(d); 
    
    Assert(object_decl != NULL); 
    
    int numBytesToAlloc = object_decl->GetNumBytesToAlloc(); 
    
    Location *arg = code_gen->GenLoadConstant(numBytesToAlloc); 
    
    Location *new_loc = code_gen->GenBuiltInCall(Alloc, arg); 
    
    //set the VTable*
    
    Location *vtable_label = code_gen->GenLoadLabel(object_decl->GetName()); 
    
    code_gen->GenStore(new_loc, vtable_label); 
    
    //set each instance variable
    
    
    
    return new_loc; 
    
}


NewArrayExpr::NewArrayExpr(yyltype loc, Expr *sz, Type *et) : Expr(loc) {
    Assert(sz != NULL && et != NULL);
    (size=sz)->SetParent(this); 
    (elemType=et)->SetParent(this);
    type = et; 
    array_size = NULL; 
}

void NewArrayExpr::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors, Hashtable<Decl*> *global_scope, LoopStmt *curr_loop, Type *curr_fn_return_type, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    size->Check(everything, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, curr_loop, curr_fn_return_type, curr_class, curr_class_full_scope); 
    
    yyltype loc; 
    type = new ArrayType(loc, elemType); 
    
    if (!printErrors)
        return; 
    
    if (size->GetType() != Type::intType)
    {
        ReportError::NewArraySizeNotInteger(size); 
        type = Type::errorType; 
    }
    
    elemType->Check(class_scopes, interface_scopes, printErrors); 
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 

}

Location *NewArrayExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    array_size = size->MakeLocation(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
    
    Location *zero = code_gen->GenLoadConstant(0); 
   
    Location *one = code_gen->GenLoadConstant(1); 
    
    Location *total_size_words = code_gen->GenBinaryOp("+", one, array_size); 
    
    Location *four = code_gen->GenLoadConstant(4); 
    
    Location *total_size_bytes = code_gen->GenBinaryOp("*", four, total_size_words); 
    
    Location *lower_bound_less_than = code_gen->GenBinaryOp("<", array_size, zero); 
    
    Location *lower_bound_equals = code_gen->GenBinaryOp("==", array_size, zero); 
    
    Location *lower_bound = code_gen->GenBinaryOp("||", lower_bound_equals, lower_bound_less_than); 
    
    char *else_label = code_gen->NewLabel(); 
    
    code_gen->GenIfZ(lower_bound, else_label); 
    
    Location *error_msg = code_gen->GenLoadConstant("Decaf runtime error: Array size is <= 0\\n"); 
    
    code_gen->GenBuiltInCall(PrintString, error_msg); 
    
    code_gen->GenBuiltInCall(Halt); 
    
    code_gen->GenLabel(else_label); 
   
    Location *new_array = code_gen->GenBuiltInCall(Alloc, total_size_bytes);
    
    code_gen->GenStore(new_array, array_size); 
    
 //   code_gen->GenBuiltInCall(PrintInt, new_array); 
 
    
    return new_array; 
}

ReadIntegerExpr::ReadIntegerExpr(yyltype loc) : Expr(loc)
{
    type = Type::intType; 
}

Location *ReadIntegerExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    return code_gen->GenBuiltInCall(ReadInteger); 
}

ReadLineExpr::ReadLineExpr(yyltype loc) : Expr(loc)
{
    type = Type::stringType; 
}

Location *ReadLineExpr::MakeLocation(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    return code_gen->GenBuiltInCall(ReadLine); 
}

       
