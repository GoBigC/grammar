grammar FunctionCallExpression;

import Terminals, LogicalExpression;

postfixExpression 
    : primaryExpression (arrayAccess | functionCallArgs | increaseDecrease)?
    ;

arrayAccess 
    : '[' expression ']'
    ;

functionCallArgs
    : '(' argList? ')'
    ;

increaseDecrease
    : '++'  // postfix
    | '--'  // postfix 
    ;

argList 
    : assignmentExpression (',' assignmentExpression)*
    ;

primaryExpression 
    : Identifier 
    | constant 
    | '(' expression ')'
    ;

constant
    : IntegerConstant 
    | FloatingConstant 
    | BooleanConstant 
    | CharConstant 
    ;