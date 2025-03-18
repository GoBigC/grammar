grammar attempt2; 

// Program structure
program
    : declarationList EOF
    ;

declarationList
    : declaration*
    ;

declaration
    : functionDeclaration
    | variableDeclaration
    | constDeclaration
    ;

// Function declaration with explicit function marker
functionDeclaration
    : typeSpecifier Identifier '(' parameterList? ')' compoundStatement
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : typeSpecifier Identifier
    ;

// Variable declarations - separated from function declarations
variableDeclaration
    : typeSpecifier variableDeclaratorList ';'
    ;

constDeclaration
    : 'const' typeSpecifier constDeclaratorList ';'
    ;

variableDeclaratorList
    : variableDeclarator (',' variableDeclarator)*
    ;

constDeclaratorList
    : constDeclarator (',' constDeclarator)*
    ;

variableDeclarator
    : Identifier initializer?
    ;

initializer
    : '=' expression
    ;

constDeclarator
    : Identifier '=' expression
    ;

// Types
typeSpecifier
    : 'int'
    | 'float'
    | 'char'
    | 'bool'
    | 'void'
    ;

// Statements
statement
    : expressionStatement
    | compoundStatement
    | selectionStatement
    | iterationStatement
    | jumpStatement
    ;

compoundStatement
    : '{' blockItemList '}'
    ;

blockItemList
    : blockItem*
    ;

blockItem
    : statement
    | variableDeclaration
    | constDeclaration
    ;

expressionStatement
    : expressionOpt ';'
    ;

expressionOpt
    : expression?
    ;

selectionStatement
    : ifThenStatement
    | ifThenElseStatement
    ;

// Split if-statements to avoid the dangling else problem
ifThenStatement
    : 'if' '(' expression ')' statement 
    ;

ifThenElseStatement
    : 'if' '(' expression ')' statement 'else' statement
    ;

iterationStatement
    : whileStatement
    ;

whileStatement
    : 'while' '(' expression ')' statement
    ;

jumpStatement
    : 'return' expressionOpt ';'
    ;

// Expressions
expression
    : assignmentExpression
    ;

// Separate rules to avoid ambiguity with identifiers
assignmentExpression
    : assignmentOrLogicalExpression
    ;

assignmentOrLogicalExpression
    : logicalOrExpression assignmentPart?
    ;

assignmentPart
    : assignmentOperator assignmentExpression
    ;

assignmentOperator
    : '='
    | '+='
    | '-='
    | '*='
    | '/='
    | '%='
    ;

// Expression precedence hierarchy (from lowest to highest)
logicalOrExpression
    : logicalAndExpression logicalOrPart*
    ;

logicalOrPart
    : '||' logicalAndExpression
    ;

logicalAndExpression
    : equalityExpression logicalAndPart*
    ;

logicalAndPart
    : '&&' equalityExpression
    ;

equalityExpression
    : relationalExpression equalityPart*
    ;

equalityPart
    : equalityOperator relationalExpression
    ;

equalityOperator
    : '=='
    | '!='
    ;

relationalExpression
    : additiveExpression relationalPart*
    ;

relationalPart
    : relationalOperator additiveExpression
    ;

relationalOperator
    : '<'
    | '>'
    | '<='
    | '>='
    ;

additiveExpression
    : multiplicativeExpression additivePart*
    ;

additivePart
    : additiveOperator multiplicativeExpression
    ;

additiveOperator
    : '+'
    | '-'
    ;

multiplicativeExpression
    : unaryExpression multiplicativePart*
    ;

multiplicativePart
    : multiplicativeOperator unaryExpression
    ;

multiplicativeOperator
    : '*'
    | '/'
    | '%'
    ;

unaryExpression
    : postfixExpression
    | unaryOperator unaryExpression
    ;

unaryOperator
    : '+'
    | '-'
    | '!'
    | '++'
    | '--'
    ;

postfixExpression
    : primaryExpression postfixPart*
    ;

postfixPart
    : '[' expression ']'
    | '(' argumentExpressionListOpt ')'
    | postfixOperator
    ;

postfixOperator
    : '++'
    | '--'
    ;

argumentExpressionListOpt
    : argumentExpressionList?
    ;

primaryExpression
    : Identifier
    | constant
    | '(' expression ')'
    ;

argumentExpressionList
    : assignmentExpression argumentTail*
    ;

argumentTail
    : ',' assignmentExpression
    ;

constant
    : IntegerConstant
    | FloatingConstant
    | CharacterConstant
    | BooleanConstant
    ;

// Lexer Rules

// Keywords
CONST : 'const';
INT : 'int';
FLOAT : 'float';
CHAR : 'char';
BOOL : 'bool';
VOID : 'void';
IF : 'if';
ELSE : 'else';
WHILE : 'while';
RETURN : 'return';

// Separators
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACKET : '[';
RBRACKET : ']';
SEMI : ';';
COMMA : ',';

// Operators
ASSIGN : '=';
ADD : '+';
SUB : '-';
MUL : '*';
DIV : '/';
MOD : '%';
INC : '++';
DEC : '--';
EQ : '==';
NE : '!=';
LT : '<';
GT : '>';
LE : '<=';
GE : '>=';
AND : '&&';
OR : '||';
NOT : '!';
ADD_ASSIGN : '+=';
SUB_ASSIGN : '-=';
MUL_ASSIGN : '*=';
DIV_ASSIGN : '/=';
MOD_ASSIGN : '%=';

// Constants
IntegerConstant
    : [0-9]+
    | '0x' [0-9a-fA-F]+
    ;

FloatingConstant
    : [0-9]+ '.' [0-9]* ExponentPart?
    | '.' [0-9]+ ExponentPart?
    | [0-9]+ ExponentPart
    ;

fragment ExponentPart
    : [eE] [+-]? [0-9]+
    ;

CharacterConstant
    : '\'' SingleCharacter '\''
    | '\'' EscapeSequence '\''
    ;

fragment SingleCharacter
    : ~['\\\r\n]
    ;

BooleanConstant
    : 'true'
    | 'false'
    ;

// Escape sequences
fragment EscapeSequence
    : '\\' ['"?abfnrtv\\]
    | '\\' [0-7] [0-7]? [0-7]?  // Replace {1,3} with explicit optional digits
    | '\\x' [0-9a-fA-F]+
    ;

// Identifiers
Identifier
    : [a-zA-Z_] [a-zA-Z0-9_]*
    ;

// Whitespace and comments
WS
    : [ \t\r\n]+ -> skip
    ;

BLOCK_COMMENT
    : '/*' .*? '*/' -> skip
    ;

LINE_COMMENT
    : '//' ~[\r\n]* -> skip
    ;