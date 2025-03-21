grammar ArithmeticExpression; 

import Terminals, PrimitiveTypes; 

additionExpression
    : multiplicationExpression additionExpressionRest*
    ;

additionExpressionRest
    : addSubtractOperator multiplicationExpression
    ;

addSubtractOperator 
    : '+'
    | '-'
    ;

multiplicationExpression
    : unaryExpression multiplicationExpressionRest*
    ;

multiplicationExpressionRest
    : multDivModOperator unaryExpression
    ;

multDivModOperator
    : '*'
    | '/'
    | '%'
    ;

unaryExpression 
    : postfixExpression 
    | unaryOperator unaryExpression 
    ;

unaryOperator
    : '++' // prefix
    | '--' // prefix
    ;