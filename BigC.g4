grammar BigC; 

// ----------------------BeginParserRules----------------------
program
    : declaration* EOF 
    ; 

declaration
    : constDeclaration
    | type Identifier declarationRemainder 
    ; 

type
    : 'int'
    | 'float'
    | 'bool'
    | 'char'
    | 'void' 
    ; 

constDeclaration
    : 'const' type Identifier '=' expression ';'
    ;

declarationRemainder 
    : '(' parameterList? ')' block 
    | Identifier variableInitializer? ';'
    ; 

variableInitializer
    : '=' expression ';'
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

statement
    : ifStatement
    | nonIfStatement
    ; 

ifStatement
    : 'if' '(' expression ')' block elseBlock?
    ;

elseBlock
    : 'else' elseBlockRemainder 
    ; 

elseBlockRemainder 
    : block 
    | ifStatement 
    ; 

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

// expression precedence rule: 
// read more: https://en.wikipedia.org/wiki/Order_of_operations 
// ----- HIGHER PRECEDENCE -----
// primaryExpr ('1', variable, parenthesized expr)
// postfix (x++, x--, arr[i], functionCall(arg))
// unary operation (++x, --x, !x)
// multiplication (*, /)
// addition (+, -)
// comparisons (<, <=, >=, >)
// equality (==, !=)
// logical and (&&)
// logical or (||)
// assignment expr (x = expr)
// ----- LOWER PRECEDENCE ----- 
// the grammar implements this precedence by starting with the 
// lowest precedence rule, effectively "splitting" the complex 
// expression into low precedence sub-expressions first, then 
// the subexpressions are continuously parsed into higher precedence
expression 
    : assignmentExpression 
    ; 

assignmentExpression
    : logicalOrExpression ('=' assignmentExpression)?
    ; 

logicalOrExpression
    : logicalAndExpression ('||' logicalAndExpression)*
    ; 

logicalAndExpression
    : equalityExpression ('&&' equalityExpression)*
    ; 

equalityExpression
    : comparisonExpression (equalityOperator comparisonExpression)*
    ; 

equalityOperator 
    : '=='
    | '!='
    ; 

comparisonExpression 
    : additionExpression (comparisonOperator additionExpression)* 
    ; 

comparisonOperator
    : '>'
    | '<'
    | '>='
    | '<='
    ; 

additionExpression
    : multiplicationExpression (addSubtractOperator multiplicationExpression)*
    ; 

addSubtractOperator 
    : '+'
    | '-'
    ; 

multiplicationExpression
    : unaryExpression (multDivModOperator unaryExpression)*
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

postfixExpression 
    : primaryExpression (arrayAccess | functionCallArgs | increaseDecrease)*
    ; 

arrayAccess 
    : '[' expression ']'
    ; 

functionCallArgs
    : '(' argList ')' // if a function returns anything, it must accept at least 1 arg --> motivate user to not produce side effect?
    ; 

// functionCallArgs
//     : '(' argList? ')' // originally i wrote this, but it generates warning land LL(1)? false
//     ; 

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
// ----------------------EndParserRules----------------------

// ----------------------BeginLexerRules----------------------
Identifier
    : [a-zA-Z_][a-zA-Z0-9]*
    ; 

IntegerConstant
    : [0-9]+
    ;

FloatingConstant
    : [0-9]+ '.' [0-9]+
    ; 

CharConstant
    : '\'' ~[\r\n]'\'' // anything but CR, LF
    ;

BooleanConstant 
    : 'true'
    | 'false'
    ; 

WS
    : [ \t\r\n]+ -> skip
    ; 

COMMENT
    : '//' ~[\r\n]* -> skip
    ; 

DOCSTRING
    : '/*' .*? '*/' -> skip 
    ; 
// ----------------------EndLexerRules----------------------
