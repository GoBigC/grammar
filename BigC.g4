grammar BigC; 

import  ConstantDefinition, VariableAssignment,
        IfStatement, WhileLoop, Terminals, 
        PrimitiveTypes, FunctionDefinition, 
        ArithmeticExpression, FunctionCallExpression, 
        LogicalExpression;

program 
    : (statement)* EOF
    ; 

statement
    : assignment
    | expression
    | branch
    | loop
    ; 

assignment
    : constantDefinition 
    | variableAssignment 
    ; 

expression 
    : arithmeticExpression 
    | logicalExpression 
    | functionCallExpression 
    ; 

branch 
    : ifStatement 
    ; 

loop 
    : whileLoop 
    ; 