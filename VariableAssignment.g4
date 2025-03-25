grammar VariableAssignment; 

import Terminals, FunctionCallExpression; 

expression 
    : assignmentExpression 
    ;

assignmentExpression
    : logicalOrExpression assignmentRest?
    ;

assignmentRest
    : '=' assignmentExpression
    ;

variableInitializer
    : '=' expression ';'
    ;