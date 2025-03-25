grammar WhileLoop; 

import Terminals, FunctionDefinition, VariableAssignment;

nonIfStatement 
    : expression ';'
    | whileStatement
    | returnStatement
    ;

whileStatement
    : 'while' '(' expression ')' block 
    ;

returnStatement 
    : 'return' expression ';'
    ;