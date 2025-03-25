grammar FunctionDefinition;

import Terminals, PrimitiveTypes, VariableAssignment;

declaration
    : type Identifier declarationRemainder
    ;

declarationRemainder 
    : '(' parameterList? ')' block 
    | Identifier variableInitializer? ';'
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : type Identifier
    ;

block 
    : '{' blockItem* '}'
    ;

blockItem
    : declaration
    | statement
    ;