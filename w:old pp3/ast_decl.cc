/* File: ast_decl.cc
 * -----------------
 * Implementation of Decl node classes.
 */
#include "ast_decl.h"
#include "ast_type.h"
#include "ast_stmt.h"
        
         
Decl::Decl(Identifier *n) : Node(*n->GetLocation()) {
    Assert(n != NULL);
    (id=n)->SetParent(this); 
}


VarDecl::VarDecl(Identifier *n, Type *t) : Decl(n) {
    Assert(n != NULL && t != NULL);
    (type=t)->SetParent(this);
    loc = NULL; 
    offset = -1; 
}

void VarDecl::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    
    type->Check(class_scopes, interface_scopes, printErrors); 
    
    if (prev_scope->Lookup(id->GetName()) == NULL)
        prev_scope->Enter(id->GetName(), this, true); //adds this variable to the current scope and overwrites any previous entries that might be present. 
    
    else {
        if (prev_scope != global_scope && printErrors)
        {
            Decl *d = global_scope->Lookup(id->GetName()); 
            ClassDecl *class_decl = dynamic_cast<ClassDecl*>(d); 
            if (class_decl == NULL)
            {
                ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName()));
            }
            else
            {
                
                prev_scope->Remove(class_decl->GetId()->GetName(), class_decl); 
                
                if (prev_scope->Lookup(id->GetName()) != NULL)
                {
                    if (printErrors) {
                                        
                        ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName())); 
                    }
                    prev_scope->Enter(class_decl->GetId()->GetName(), class_decl, false); 
                    
                    return; 
                }
                prev_scope->Enter(class_decl->GetId()->GetName(), class_decl); 
                
                prev_scope->Enter(id->GetName(), this, false);
                
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

void VarDecl::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    if (curr_fn == NULL) //ie a global var
    {
        
    }
}

int VarDecl::GetOffset()
{
    return offset; 
}

void VarDecl::SetOffset(int o) 
{
    offset = o; 
}

ClassDecl::ClassDecl(Identifier *n, NamedType *ex, List<NamedType*> *imp, List<Decl*> *m) : Decl(n) {
    // extends can be NULL, impl & mem may be empty lists but cannot be NULL
    Assert(n != NULL && imp != NULL && m != NULL);     
    extends = ex;
    if (extends) extends->SetParent(this);
    (implements=imp)->SetParentAll(this);
    (members=m)->SetParentAll(this);
}

void ClassDecl::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn)
{
    
    Hashtable<Decl*> *curr_class_scope = class_scopes->Lookup(id->GetName()); 
    
    //sets up vtable
    
    List<const char*> *methodLabels = new List<const char*>; 
    List<Decl*> *base_members; 
    int curr_offset = 0; 
    if (extends != NULL)
    {
        const char *base_class_name = extends->GetId()->GetName(); 
        Decl *b = global_scope->Lookup(base_class_name); 
        ClassDecl *base_class = dynamic_cast<ClassDecl *>(b); 
        
        Assert(base_class != NULL); 
        
        base_members = base_class->GetMembers(); 
        
        for (int i = 0; i < base_members->NumElements(); i++)
        {
            Decl *curr = base_members->Nth(i);
            FnDecl *curr_fn_decl = dynamic_cast<FnDecl*>(curr); 
            if (curr_fn_decl != NULL)
            {
                if (members->Contains(curr_fn_decl) == -1)
                {
                    string fn_name(curr_fn_decl->GetName()); 
                    string class_name(base_class_name); 
                    
                    string label = "_" + class_name + "." + fn_name; 
                    
                    methodLabels->Append(strdup(label.c_str())); 
                    
                    Decl *child_class_decl = curr_class_scope->Lookup(curr_fn_decl->GetName()); 
                    FnDecl *child_class_fn_decl = dynamic_cast<FnDecl*>(child_class_decl); 
                    child_class_fn_decl->SetOffset(curr_offset); 
                }
                else
                {
                    string fn_name(curr_fn_decl->GetName()); 
                    string class_name(id->GetName()); 
                    
                    string label = "_" + class_name + "." + fn_name; 
                    
                    methodLabels->Append(strdup(label.c_str())); 
                    
                    Decl *child_class_decl = curr_class_scope->Lookup(curr_fn_decl->GetName()); 
                    FnDecl *child_class_fn_decl = dynamic_cast<FnDecl*>(child_class_decl); 
                    child_class_fn_decl->SetOffset(curr_offset); 
                }
                curr_offset += 4; 
            }
        }
    }
    
    
    
    
    for (int i = 0; i < members->NumElements(); i++)
    {
        Decl *curr_decl = members->Nth(i); 
        FnDecl *curr_fn_decl = dynamic_cast<FnDecl*>(curr_decl); 
        if (curr_fn_decl != NULL)
        {
            if (extends != NULL && base_members->Contains(curr_fn_decl) == -1)
            {
                string fn_name(curr_fn_decl->GetName()); 
                string class_name(id->GetName()); 
            
                string label = "_" + class_name + "." + fn_name;
            
                methodLabels->Append(strdup(label.c_str())); 
                
                curr_fn_decl->SetOffset(curr_offset); 
            }
            else if (extends == NULL)
            {
                string fn_name(curr_fn_decl->GetName()); 
                string class_name(id->GetName()); 
                
                string label = "_" + class_name + "." + fn_name;
                
                methodLabels->Append(strdup(label.c_str())); 
                
                curr_fn_decl->SetOffset(curr_offset); 
            
            }
            curr_offset += 4; 
        }
    }
    */
    /*
    cout << "pre extends" << endl; 
    for (int i = 0; i < methodLabels->NumElements(); i++)
    {
        cout << methodLabels->Nth(i) << endl; 
    }
    *//*
    if (extends != NULL)
    {
        const char *base_class_name = extends->GetId()->GetName(); 
        Decl *b = global_scope->Lookup(base_class_name); 
        ClassDecl *base_class = dynamic_cast<ClassDecl *>(b); 
        
        Assert(base_class != NULL); 
        
        List<Decl*> *base_members = base_class->GetMembers(); 
        
        for (int i = 0; i < base_members->NumElements(); i++)
        {
            Decl *curr = base_members->Nth(i);
            FnDecl *curr_fn_decl = dynamic_cast<FnDecl*>(curr); 
            if (curr_fn_decl != NULL)
            {
                if (members->Contains(curr_fn_decl) == -1)
                {
                    string fn_name(curr_fn_decl->GetName()); 
                    string class_name(base_class_name); 
                    
                    string label = "_" + class_name + "." + fn_name; 
                    
                    methodLabels->Append(strdup(label.c_str())); 
                }
            }
        }
    }
    
    */
    code_gen->GenVTable(id->GetName(), VTable); 
    
    for (int i = 0; i < members->NumElements(); i++)
    {
        Decl *curr_decl = members->Nth(i); 
        curr_decl->Emit(code_gen, class_scopes, interface_scopes, global_scope, curr_fn); 
        
    }
     
      
}

void ClassDecl::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    
    
  /*  if (prev_scope->Lookup(id->GetName()) != NULL && (printErrors))
    {
        ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName()));
    }
    else { */
        Hashtable<Decl*> *new_class_scope = new Hashtable<Decl*>; 
        class_scopes->Enter(id->GetName(), new_class_scope); 
        prev_scope->Enter(id->GetName(), this); 
        everything.Enter(id->GetName(), this); 
        
        new_class_scope->Enter(id->GetName(), this); 
        
        //addds inherited class fields into new_class_scope
        
        Hashtable<Decl*> *base_class; 
        
        if (extends != NULL)
            base_class = class_scopes->Lookup(extends->GetName()); 
        else
            base_class = NULL; 
        
        if (extends != NULL)
        {
            
            if (base_class == NULL && printErrors)
            {
                ReportError::IdentifierNotDeclared(extends->GetId(), LookingForClass); 
            }
           
            else 
            {
                //adds everything from the base class into this class
                if (base_class != NULL)
                {
                    Iterator<Decl*> iter = base_class->GetIterator(); 
                    Decl *d = iter.GetNextValue(); 
                    
                    while (d != NULL)
                    {
                        new_class_scope->Enter(d->GetName(), d); 
                        d = iter.GetNextValue(); 
                    }  
                }
            }
            
        }
        
    curr_class_full_scope = new Hashtable<Decl*>; 
    for (int i = 0; i < members->NumElements(); i++)
    {
        Decl *d = members->Nth(i); 
      //  everything.Enter(d->GetId()->GetName(), d);
        curr_class_full_scope->Enter(d->GetId()->GetName(), d); 
        //new_class_scope->Enter(d->GetId()->GetName(), d); 
    }
    
        //checks each Field in the class
        
        for (int i = 0; i < members->NumElements(); i++)
        {
            Decl *d = members->Nth(i);   //either a VarDecl or a FnDecl
            if (extends != NULL)
            {
                string base_name = extends->GetName(); 
                d->Check(everything, new_class_scope, class_scopes, interface_scopes, true, base_name, printErrors, global_scope, this, curr_class_full_scope);
            }
            else 
            {
                d->Check(everything, new_class_scope, class_scopes, interface_scopes, false, "-1", printErrors, global_scope, this, curr_class_full_scope); 
            }
            FnDecl *derived_fn = dynamic_cast<FnDecl *>(d); 
            
            if (derived_fn == NULL)
                continue; 
            
            if (extends != NULL && base_class != NULL)
            {
                //want to make sure that all inherited functions have the correct return type, # args, and arg list. 
                
                Decl *inherited_function = base_class->Lookup(derived_fn->GetName()); 
                
                if (inherited_function != NULL) //the current function is infact inherited from the class that this class extends
                {
                    bool to_continue = true; 
                    
                    inherited_function->CheckReturnType(derived_fn->GetReturnType(), derived_fn, printErrors, prev_scope, class_scopes, interface_scopes, to_continue, global_scope);  //checks return type
                         
                    if (to_continue)
                    {
                    
                        List<VarDecl*> *derived_formals = derived_fn->GetFormals(); 
                        
                        inherited_function->CheckNumArguments(derived_formals->NumElements(), derived_fn, printErrors, to_continue); 
                        
                        if (to_continue) //i.e stop error reporting if # args is wrong
                        {
                            //checks each argument in the argument list. 
                            
                            FnDecl *inherited_fn = dynamic_cast<FnDecl *>(inherited_function); 
                            List<VarDecl*> *inherited_fn_formals = inherited_fn->GetFormals(); 
                            
                            for (int i = 0; i < derived_formals->NumElements(); i++)
                            {
                                VarDecl *curr_derived_var = derived_formals->Nth(i); 
                                VarDecl *curr_inherited_var = inherited_fn_formals->Nth(i); 
                                
                                Type *derived_type = curr_derived_var->GetType(); 
                                Type *inherited_type = curr_inherited_var->GetType(); 
                                
                                if (!derived_type->IsEquivalentTo(inherited_type))
                                {
                                    bool errorAlreadyReported = false; 
                                    if (!derived_type->IsCompatibleWith(inherited_type, global_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope))
                                    {
                                        if (!errorAlreadyReported)
                                        {
                                            ReportError::OverrideMismatch(derived_fn); 
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
            
            
            
            
        }
        //checks to see that each implemented interface has all its functions in the class
        
        for (int i = 0; i < implements->NumElements(); i++)
        {
            NamedType *curr_interface = implements->Nth(i); 
            Hashtable<Decl*> *curr_interface_scope = interface_scopes->Lookup(curr_interface->GetName()); 
            
            if (curr_interface_scope == NULL && printErrors)
            {
                ReportError::IdentifierNotDeclared(curr_interface->GetId(), LookingForInterface); 
            }
            
            else {
                //iterate through curr_interface_scope and make sure that each function in it is in new_class_scope
                
                if (curr_interface_scope != NULL)
                {
                    
                    Iterator<Decl*> iter = curr_interface_scope->GetIterator(); 
                    Decl *inherited_fn = iter.GetNextValue(); //function in the interface - inherited
                    
                    while (inherited_fn != NULL)
                    {
                        if (strcmp(inherited_fn->GetName(), curr_interface->GetName()) == 0)
                        {
                            inherited_fn = iter.GetNextValue(); 
                            continue; 
                        }
                        
                        Decl *drved = new_class_scope->Lookup(inherited_fn->GetName()); 
                        
                        
                        if (drved == NULL && printErrors)
                        {
                            ReportError::InterfaceNotImplemented(this, curr_interface); 
                            inherited_fn = iter.GetNextValue();
                            continue; 
                        }
                        
                        if (drved != NULL)
                        {
                            //need to check the return type, # of args, and arg list of the inherited interface function with the current class's function
                            
                            bool to_continue = true; 
                            
                            FnDecl *derived = dynamic_cast<FnDecl *>(drved); 
                            inherited_fn->CheckReturnType(derived->GetReturnType(), derived, printErrors, prev_scope, class_scopes, interface_scopes, to_continue, global_scope); //Check return type
                            
                            if (to_continue)
                            {
                                List<VarDecl*> *derived_formals = derived->GetFormals(); 
                                
                                inherited_fn->CheckNumArguments(derived_formals->NumElements(), derived, printErrors, to_continue); 
                                
                                if (to_continue) //i.e stop error reporting if # args is wrong
                                {
                                    //checks each argument in the argument list. 
                                    for (int i = 0; i < derived_formals->NumElements(); i++)
                                    {
                                        VarDecl *curr_var = derived_formals->Nth(i); 
                                        
                                        inherited_fn->CheckNthArg(curr_var, derived, i, printErrors); 
                                    }
                                }
                            }
                            
                        }
                        
                        inherited_fn = iter.GetNextValue(); 
                    }
                }
            }
        }
            
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 
    
    if (printErrors)
    {
        numBytesToAlloc = 4; //need the first 4 bytes to store the Vtable*
        
        //VAR OFFSETS
        if (extends != NULL)
        {
            const char *base_class_name = extends->GetId()->GetName(); 
            Decl *b = global_scope->Lookup(base_class_name); 
            ClassDecl *base_class = dynamic_cast<ClassDecl *>(b); 
            
            Assert(base_class != NULL); 
            
            List<Decl*> *base_members = base_class->GetMembers(); 
            
            
            //puts the inherited variables first so that offsets are aligned w/ parent class
            for (int i = 0; i < base_members->NumElements(); i++)
            {
                Decl *curr_decl = base_members->Nth(i); 
                VarDecl *curr_var_decl_base = dynamic_cast<VarDecl*>(curr_decl); 
                if (curr_var_decl_base != NULL)
                {
                    Decl *d = new_class_scope->Lookup(curr_var_decl_base->GetName()); 
                    VarDecl *curr_var_here = dynamic_cast<VarDecl*>(d); 
                    Assert(curr_var_here != NULL); 
                    int offset = numBytesToAlloc; //vtable pointer is at offset 0
                    curr_var_here->SetOffset(offset);  //makes sure we update the offset of the variable in new_class_scope, not the VarDecl in the parent class scope. 
                    numBytesToAlloc += 4; 
                }
            }
            
            
        }
        
        //then puts the new class vars
        for (int i = 0; i < members->NumElements(); i++)
        {
            Decl *curr_decl = members->Nth(i); 
            VarDecl *curr_var_decl = dynamic_cast<VarDecl*>(curr_decl); 
            if (curr_var_decl != NULL)
            {
                int offset = numBytesToAlloc; //vtable pointer is at offset 0
                curr_var_decl->SetOffset(offset); 
                numBytesToAlloc += 4; 
            }
        }
        
    
        
    }
    
    //FN offsets
    if (printErrors)
    {
        Hashtable<Decl*> *curr_class_scope = class_scopes->Lookup(id->GetName()); 
        
        //sets up vtable
        
        List<const char*> *methodLabels = new List<const char*>; 
        List<Decl*> *base_members; 
        int curr_offset = 0; 
        if (extends != NULL)
        {
            const char *base_class_name = extends->GetId()->GetName(); 
            Decl *b = global_scope->Lookup(base_class_name); 
            ClassDecl *base_class = dynamic_cast<ClassDecl *>(b); 
            
            Assert(base_class != NULL); 
            
            base_members = base_class->GetMembers(); 
            
            for (int i = 0; i < base_members->NumElements(); i++)
            {
                Decl *curr = base_members->Nth(i);
                FnDecl *curr_fn_decl = dynamic_cast<FnDecl*>(curr); 
                if (curr_fn_decl != NULL)
                {
                    if (members->Contains(curr_fn_decl) == -1)
                    {
                        string fn_name(curr_fn_decl->GetName()); 
                        string class_name(base_class_name); 
                        
                        string label = "_" + class_name + "." + fn_name; 
                        
                        methodLabels->Append(strdup(label.c_str())); 
                        
                        Decl *child_class_decl = curr_class_scope->Lookup(curr_fn_decl->GetName()); 
                        FnDecl *child_class_fn_decl = dynamic_cast<FnDecl*>(child_class_decl); 
                        child_class_fn_decl->SetOffset(curr_offset); 
                    }
                    else
                    {
                        string fn_name(curr_fn_decl->GetName()); 
                        string class_name(id->GetName()); 
                        
                        string label = "_" + class_name + "." + fn_name; 
                        
                        methodLabels->Append(strdup(label.c_str())); 
                        
                        Decl *child_class_decl = curr_class_scope->Lookup(curr_fn_decl->GetName()); 
                        FnDecl *child_class_fn_decl = dynamic_cast<FnDecl*>(child_class_decl); 
                        child_class_fn_decl->SetOffset(curr_offset); 
                    }
                    curr_offset += 4; 
                }
            }
        }
        
        
        
        
        for (int i = 0; i < members->NumElements(); i++)
        {
            Decl *curr_decl = members->Nth(i); 
            FnDecl *curr_fn_decl = dynamic_cast<FnDecl*>(curr_decl); 
            if (curr_fn_decl != NULL)
            {
                if (extends != NULL && base_members->Contains(curr_fn_decl) == -1)
                {
                    string fn_name(curr_fn_decl->GetName()); 
                    string class_name(id->GetName()); 
                    
                    string label = "_" + class_name + "." + fn_name;
                    
                    methodLabels->Append(strdup(label.c_str())); 
                    
                    curr_fn_decl->SetOffset(curr_offset); 
                }
                else if (extends == NULL)
                {
                    string fn_name(curr_fn_decl->GetName()); 
                    string class_name(id->GetName()); 
                    
                    string label = "_" + class_name + "." + fn_name;
                    
                    methodLabels->Append(strdup(label.c_str())); 
                    
                    curr_fn_decl->SetOffset(curr_offset); 
                    
                }
                curr_offset += 4; 
            }
        }

        VTable = methodLabels; 
    }
    
  
   
  
}


InterfaceDecl::InterfaceDecl(Identifier *n, List<Decl*> *m) : Decl(n) {
    Assert(n != NULL && m != NULL);
    (members=m)->SetParentAll(this);
}

void InterfaceDecl::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    
        Hashtable<Decl*> *local = new Hashtable<Decl*>; 
        
        interface_scopes->Enter(id->GetName(), local); //adds local to the hashtable of class/interface scopes
        
        prev_scope->Enter(id->GetName(), this); 
        everything.Enter(id->GetName(), this);
    local->Enter(id->GetName(), this); 
        
        for (int i = 0; i < members->NumElements(); i++)
        {
            Decl *d = members->Nth(i); 
            d->Check(everything, local, class_scopes, interface_scopes, false, "-1", printErrors, global_scope, NULL, NULL); 
        }
        
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 

    
    
}

	
FnDecl::FnDecl(Identifier *n, Type *r, List<VarDecl*> *d) : Decl(n) {
    Assert(n != NULL && r!= NULL && d != NULL);
    (returnType=r)->SetParent(this);
    (formals=d)->SetParentAll(this);
    body = NULL;
}

void FnDecl::SetFunctionBody(Stmt *b) { 
    (body=b)->SetParent(this);
}

void FnDecl::CheckReturnType(Type *derived_return_type, Decl *derived, bool printErrors, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool & to_continue, Hashtable<Decl*> *global_scope)
{
    /*
    if (!returnType->IsEquivalentTo(derived_return_type) && printErrors)
    {
        bool errorAlreadyReported = false; 
        if (!derived_return_type->IsCompatibleWith(returnType, prev_scope, errorAlreadyReported, class_scopes, interface_scopes, global_scope) && !errorAlreadyReported)
        {
            ReportError::OverrideMismatch(derived); 
            returnType = Type::errorType; 
            to_continue = false; 
            
        }
        
    }*/
    
}

void FnDecl::CheckNthArg(VarDecl *curr_derived_arg, Decl *derived, int i, bool printErrors) 
{
    VarDecl *curr_base_arg = formals->Nth(i); 
    
    curr_base_arg->CheckArg1(curr_derived_arg, derived, printErrors); 
}
        
void VarDecl::CheckArg1(VarDecl *arg2, Decl *derived, bool printErrors)
{
    arg2->CheckArg2(type, derived, printErrors); 
  
}


void VarDecl::CheckArg2(Type *type1, Decl *derived, bool printErrors)
{
    bool IsEquivalent = type->IsEquivalentTo(type1); 
    
    if (!IsEquivalent && printErrors)
    {
        ReportError::OverrideMismatch(derived); 
    }
    
}

void FnDecl::CheckNumArguments(int numGiven, Decl *derived, bool printErrors, bool & to_continue)
{
    int numExpected = formals->NumElements(); 
    if (numGiven != numExpected)
    {
        to_continue = false; 
        if (printErrors)
            ReportError::OverrideMismatch(derived);  
    }
}
                               
                               

void FnDecl::Check(Hashtable<Decl*> everything, Hashtable<Decl*> *prev_scope, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool inClass, string className, bool printErrors, Hashtable<Decl*> *global_scope, ClassDecl *curr_class, Hashtable<Decl*> *curr_class_full_scope)
{
    /*
    if (printErrors)
    {
        cout << "IN FN::CHECK = AT BEGINNING" << endl << "everything: (" << id->GetName() << ")" << endl; 
        Iterator<Decl*> iter = everything.GetIterator(); 
        Decl *i = iter.GetNextValue(); 
        
        while (i != NULL)
        {
            cout << i << endl; 
            i = iter.GetNextValue(); 
        }
    }*/
    
    
    const char *name = id->GetName(); 
    Decl *prev_declaration = prev_scope->Lookup(name); 
    
    if (global_scope != prev_scope)
    {
        
        FnDecl *prev_fn_decl = dynamic_cast<FnDecl *>(prev_declaration); 
        // if (prev_scope->Lookup(id->GetName()) != NULL)
        if (prev_fn_decl != NULL)
        {
            Hashtable<Decl*> *inherited_class_scope = class_scopes->Lookup(className.c_str()); 
            
            if (inClass)
            {
                //allows to override inherited functions only
                
                Decl *inherited_function = inherited_class_scope->Lookup(id->GetName()); 
                
              //  ClassDecl *class_decl = dynamic_cast<ClassDecl *>(inherited_function); 
                
                if (inherited_function == NULL) //if this function is not an inherited function but is in the previous scope
                {
                    if (printErrors)
                    {
                        ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName()));
                        return; 
                    }
                }
                /*
                if (class_decl == NULL && printErrors)
                {
                    ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName())); 
                    return; 
                }*/
                
                
            }
            else {
                if (printErrors) {
                    ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName()));
                    return; 
                }
            }
        }
        else if (prev_declaration != NULL)
        {
            ClassDecl *c = dynamic_cast<ClassDecl *>(prev_declaration); 
            
            Decl *toUse; 
            
            if (c == NULL)
            {
                InterfaceDecl *i = dynamic_cast<InterfaceDecl *>(prev_declaration); 
                
                if (i == NULL)
                {
                    if (printErrors)
                        ReportError::DeclConflict(this, prev_declaration); 
                    return; 
                }
                toUse = i; 
            }
            else {
                toUse = c; 
            }
            
            prev_scope->Remove(toUse->GetId()->GetName(), toUse); 
            
            if (prev_scope->Lookup(id->GetName()) != NULL)
            {
                if (printErrors)
                    ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName())); 
                prev_scope->Enter(toUse->GetId()->GetName(), toUse); 
                return; 
            }
            prev_scope->Enter(toUse->GetId()->GetName(), toUse); 
            
             prev_scope->Enter(id->GetName(), this, false);
        }
    }
    /*
    ClassDecl *c = dynamic_cast<ClassDecl *>(prev_declaration); 
    
    if (c == NULL)
    {
        ReportError::DeclConflict(this, prev_declaration); 
        return; 
    }
    
    prev_scope->Remove(c->GetId()->GetName(), c); 
    
    if (prev_scope->Lookup(id->GetName()) != NULL)
    {
        ReportError::DeclConflict(this, prev_scope->Lookup(id->GetName())); 
        prev_scope->Enter(c->GetId()->GetName(), c); 
        return; 
    }
    prev_scope->Enter(c->GetId()->GetName(), c); 

    */
    
    //checks return type validity
    
     returnType->Check(class_scopes, interface_scopes, printErrors);
    /*
    NamedType *r = dynamic_cast<NamedType *>(returnType); 
    ArrayType *a = dynamic_cast<ArrayType *>(returnType); 
    
    if (r == NULL && a == NULL)
        returnType = Type::errorType; 
    */
  //  else 
    //{
        prev_scope->Enter(id->GetName(), this); 
       
        //adds all entries in prev_scope to everything
        
        Iterator<Decl*> p = prev_scope->GetIterator(); 
        Decl *entry = p.GetNextValue(); 
        while (entry != NULL)
        {
            everything.Enter(entry->GetName(), entry); 
            entry = p.GetNextValue(); 
        }
        
        //checks each argument
        
        Hashtable<Decl*> *args = new Hashtable<Decl*>; 
        for (int i = 0; i < formals->NumElements(); i++)
        {
            VarDecl *curr_var = formals->Nth(i); 
            curr_var->Check(everything, args, class_scopes, interface_scopes, false, "-1", printErrors, global_scope, curr_class, curr_class_full_scope); 
        }
        
    
        //adding all of the parameters to everything, overwriting any previous
        
        Iterator<Decl*> iter1 = args->GetIterator(); 
        Decl *arg = iter1.GetNextValue(); 
        while (arg != NULL)
        {
            everything.Enter(arg->GetName(), arg); 
            arg = iter1.GetNextValue(); 
        }
        
        
        Hashtable<Decl*> copy = everything; 
        
        if (body != NULL)
        {
            body->Check(copy, prev_scope, class_scopes, interface_scopes, printErrors, global_scope, NULL, returnType, curr_class, curr_class_full_scope);
        }
    
    this->everything = everything; 
    this->prev_scope = prev_scope; 
    this->curr_loop = curr_loop; 
    this->curr_fn_return_type = curr_fn_return_type; 
    this->curr_class = curr_class; 
    this->curr_class_full_scope = curr_class_full_scope; 

}

void FnDecl::Emit(CodeGenerator *code_gen, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope, FnDecl *curr_fn) 
{
    code_gen->currSeg = fpRelative; 
    
    const char *label; 
    if (strcmp(id->GetName(), "main") == 0)
    {
        label =  "main"; 
    }
    else if (curr_class == NULL)
    {
        string str = id->GetName(); 
        str = "_" + str; 
        label = str.c_str(); 
    }
    else if (curr_class != NULL)
    {
        string fn_name = id->GetName(); 
        string class_name = curr_class->GetName(); 
        string name = "_" + class_name + "." + fn_name; 
        label = name.c_str(); 
    }
    
    code_gen->GenLabel(label); 
    BeginFunc *b = code_gen->GenBeginFunc(); 
    
    //store a Hashtable of locations in code_gen object that contains the name of the argument mapped to the location on the stack (not the location in the VarDecl).
    
    //if curr_class == NULL, then there is no first "this" parameter
    
    int a; 
    
    if (curr_class == NULL)
        a = 0; 
    else
        a = 1;  //because the first parameter in formals is actually the 2nd parameter on the stack b/c of the implicit this pointer
    
    for (int i = 0; i < formals->NumElements(); i++)
    {
        int offset_value = (a+1)*4; 
        Location *offset_loc = code_gen->GenLoadConstant(offset_value); 
        Location *ith_parameter = new Location(fpRelative, offset_value, formals->Nth(i)->GetId()->GetName()); 
        code_gen->currParametersLocations->Enter(formals->Nth(i)->GetId()->GetName(), ith_parameter); 
    }
    
    
    
    body->Emit(code_gen, class_scopes, interface_scopes, global_scope, NULL, this);
    
  //  b->SetFrameSize(200); 
    
    b->SetFrameSize(code_gen->currFunctionFrameSize); 
    

    code_gen->GenEndFunc(); 
    
    code_gen->currFunctionFrameSize = 0; 
    
    code_gen->currSeg = gpRelative; 
    
    code_gen->currParametersLocations = new Hashtable<Location*>; 
    
    //clear the hashtable of locations in code_gen
}
/*
void FnDecl::CheckType(bool printErrors)
{
    body->CheckType(printErrors); 
}

*/

