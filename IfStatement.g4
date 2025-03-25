grammar IfStatement;

import Terminals, FunctionDefinition, VariableAssignment;

statement
    : ifStatement
    | nonIfStatement
    ;

ifStatement
    : 'if' '(' expression ')' block elseClause?
    ;

elseClause
    : 'else' (block | ifStatement)
    ;
