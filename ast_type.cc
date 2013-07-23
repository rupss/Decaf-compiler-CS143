/* File: ast_type.cc
 * -----------------
 * Implementation of type node classes.
 */

#include <string.h>
#include "ast_type.h"
#include "ast_decl.h"
 
/* Class constants
 * ---------------
 * These are public constants for the built-in base types (int, double, etc.)
 * They can be accessed with the syntax Type::intType. This allows you to
 * directly access them and share the built-in types where needed rather that
 * creates lots of copies.
 */

Type *Type::intType    = new Type("int");
Type *Type::doubleType = new Type("double");
Type *Type::voidType   = new Type("void");
Type *Type::boolType   = new Type("bool");
Type *Type::nullType   = new Type("null");
Type *Type::stringType = new Type("string");
Type *Type::errorType  = new Type("error"); 

Type::Type(const char *n) {
    Assert(n);
    typeName = strdup(n);
}

bool Type::IsCompatibleWith(Type *parent_type, Hashtable<Decl*> *prev_scope, bool & errorAlreadyReported, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope) {
    if (this == errorType || parent_type == errorType) //preventing cascading errors
        return true; 
    
    NamedType *o = dynamic_cast<NamedType *>(parent_type); 
    
    if (this == nullType)
    {
        if (o == NULL)
        {
            return false; 
        }
        else
        {
            return true; 
        }
    }
    
    
    return IsEquivalentTo(parent_type); 
}

	
NamedType::NamedType(Identifier *i) : Type(*i->GetLocation()) {
    Assert(i != NULL);
    (id=i)->SetParent(this);
} 

void NamedType::Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors)
{
    
    const char *type_name = id->GetName(); 
   
    if (type_name == "int"||type_name == "double"||type_name == "bool"||type_name == "void"||type_name == "string")
    {
        return; 
    }
    else
    {
        if (class_scopes->Lookup(type_name) != NULL || interface_scopes->Lookup(type_name) != NULL)
        {
            return; 
        }
        else {
            if (printErrors)
                ReportError::IdentifierNotDeclared(id, LookingForType); 
        }
    }
}

bool NamedType::IsEquivalentTo(Type *other)
{
    NamedType *n = dynamic_cast<NamedType *>(other); 
    
    if (n == NULL)
        return false; 
    
    string t1; 
    string t2; 
    
   
        t1 = id->GetName(); 
 
        t2 = n->GetId()->GetName(); 
    
    if (t1 == t2)
        return true; 
    return false; 
    
    
}

bool NamedType::IsCompatibleWith(Type *parent_type, Hashtable<Decl*> *prev_scope, bool & errorAlreadyReported, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope)
{
    NamedType *o = dynamic_cast<NamedType *>(parent_type); 
    
    if (this == nullType)
    {
        if (o == NULL)
        {
            return false; 
        }
        else
        {
            return true; 
        }
    }
    
  //  Decl *c = global_scope->Lookup(id->GetName()); 
  //  Assert(c != NULL); 
    
    //child will always be a class, though a parent could be a class or an interface
    
    if (this == Type::errorType || parent_type == Type::errorType)
        return true; 
    
    Hashtable<Decl*> *cl = class_scopes->Lookup(id->GetName()); 
    
    if (cl == NULL)
    {
        if (interface_scopes->Lookup(id->GetName()) != NULL)
        {
            return false; 
        }
        else
        {
            ReportError::IdentifierNotDeclared(id, LookingForType); 
            errorAlreadyReported = true; 
            return false; 
        }
    }
    
    Decl *c = cl->Lookup(id->GetName()); 
    
    Assert(c != NULL); 
    
    ClassDecl *child = dynamic_cast<ClassDecl *>(c); 
    
    if (child == NULL)
    {
        
        ReportError::IdentifierNotDeclared(id, LookingForClass);
        errorAlreadyReported = true; 
        return false; 
    }
    
    /*if (child->GetExtends() == NULL)
    {
        return false; 
    }*/
    
    if (child->GetExtends() != NULL)
    {
        if (child->GetExtends()->IsEquivalentTo(parent_type))
            return true; 
        NamedType *base_type = child->GetExtends(); 
        Decl *d = global_scope->Lookup(base_type->GetId()->GetName()); 
        ClassDecl *base_class = dynamic_cast<ClassDecl*>(d); 
      
        List<NamedType *> *child_extends_interfaces = base_class->GetImplements(); 
        for (int i = 0 ; i < child_extends_interfaces->NumElements(); i++)
        {
            NamedType *curr = child_extends_interfaces->Nth(i); 
            if (curr->IsEquivalentTo(parent_type))
                return true; 
        }
        
    }
    
    List<NamedType *> *child_implements = child->GetImplements(); 
    
    for (int i = 0; i < child_implements->NumElements(); i++)
    {
        if (child_implements->Nth(i)->IsEquivalentTo(parent_type))
            return true; 
    }
    
    return false; 
}

bool ArrayType::IsEquivalentTo(Type *other)
{
    ArrayType *a = dynamic_cast<ArrayType *>(other); 
    
    if (a == NULL)
        return false; 
    
    bool result = (elemType->IsEquivalentTo(a->GetElemType()));
    
   // return (elemType->IsEquivalentTo(a->GetElemType())); 
    
    return result; 
}

/*

void NamedType::CheckReturnType(Decl *inherited_function, Decl *curr_function, bool printErrors)
{
    if (strcmp(inherited_function->GetReturnType()->GetIdName(), id->GetName()) != 0 && printErrors)
    {
        ReportError::OverrideMismatch(curr_function); 
    }
}
*/


ArrayType::ArrayType(yyltype loc, Type *et) : Type(loc) {
    Assert(et != NULL);
    (elemType=et)->SetParent(this);
}

void ArrayType::Check(Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, bool printErrors)
{
    elemType->Check(class_scopes, interface_scopes, printErrors); 
}

/*
void ArrayType::CheckArrayTypes(ArrayType *a2, Decl *derived, bool printErrors)
{
    NamedType *n1 = dynamic_cast<NamedType *>(elemType); 
    
    if (n1 != NULL)  //means that this current arraytype is an array of primitives
    {
        a2->CheckArrayTypesSingle(n1, derived, printErrors); 
    }
    else //if (n1 == NULL) means that this current arraytype is nested array
    {
        ArrayType *a1 = dynamic_cast<ArrayType *>(elemType); 
        
        a1->CheckArrayTypesNested(a2, derived, printErrors); //a1 is nested, a2 is unknown
    }
}

void ArrayType::CheckArrayTypesNested(ArrayType *a2, Decl *derived, bool printErrors)
{
    NamedType *n1 = dynamic_cast<NamedType *>(elemType);
}

void ArrayType::CheckArrayTypesSingle(NamedType *n1, Decl *derived, bool printErrors)
{
    NamedType *n2 = dynamic_cast<NamedType *>(elemType);
    
    if (n2 == NULL && printErrors)  //means that one type is an array of primitives and the other is not - perhaps an array of arrays
    {
        ReportError::OverrideMismatch(derived); 
    }
    else //if (n2 != NULL)  means that both types are arrays of primitives
    {
        string type1 = n1->GetTypeName(); 
        string type2 = typeName; 
        
        if (type1 != type2 && printErrors) //comparing the types of both
        {
            ReportError::OverrideMismatch(derived); 
        }
    }
}
*/




bool ArrayType::IsCompatibleWith(Type *parent_type, Hashtable<Decl*> *prev_scope, bool & errorAlreadyReported, Hashtable< Hashtable<Decl*>* > *class_scopes, Hashtable< Hashtable<Decl*>* > *interface_scopes, Hashtable<Decl*> *global_scope)
{
    if (this == Type::errorType || parent_type == Type::errorType)
        return true; 
    
    if (IsEquivalentTo(parent_type))
        return true; 
    
    return false; 
}

/*
void ArrayType::CheckArgArr1(VarDecl *arg2, Decl *derived, bool printErrors)
{
    arg2->CheckArgArr2(this->elemType, derived, printErrors); 
}
*/

/*
void ArrayType::CheckReturnType(Decl *inherited_function, Decl *curr_function, bool printErrors)
{
    elemType->CheckReturnType(inherited_function, curr_function, printErrors); 
}*/
