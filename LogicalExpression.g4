grammar LogicalExpression; 

import Terminals, ArithmeticExpression; 

logicalOrExpression
    : logicalAndExpression logicalOrRest*
    ;

logicalOrRest
    : '||' logicalAndExpression
    ;

logicalAndExpression
    : equalityExpression logicalAndRest*
    ;

logicalAndRest
    : '&&' equalityExpression
    ;

equalityExpression
    : comparisonExpression equalityRest*
    ;

equalityRest
    : equalityOperator comparisonExpression
    ;

equalityOperator 
    : '=='
    | '!='
    ;

comparisonExpression 
    : additionExpression comparisonRest*
    ;

comparisonRest
    : comparisonOperator additionExpression
    ;

comparisonOperator
    : '>'
    | '<'
    | '>='
    | '<='
    ;