grammar attempt1;

// Program structure
program
    : declaration* EOF
    ;

declaration
    : varOrConstDeclaration
    | functionDeclaration
    ;

// Function declaration
functionDeclaration
    : typeSpecifier Identifier '(' parameterList? ')' compoundStatement
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : typeSpecifier Identifier
    ;

// Variable declarations
varOrConstDeclaration
    : 'const' typeSpecifier constDeclaratorList ';'    // Constant declaration
    | typeSpecifier variableDeclaratorList ';'         // Variable declaration
    ;

variableDeclaratorList
    : variableDeclarator (',' variableDeclarator)*
    ;

constDeclaratorList
    : constDeclarator (',' constDeclarator)*
    ;

variableDeclarator
    : Identifier ('=' expression)?
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
    : '{' blockItem* '}'
    ;

blockItem
    : statement
    | varOrConstDeclaration
    ;

expressionStatement
    : expression? ';'
    ;

selectionStatement
    : ifStatement
    ;

ifStatement
    : 'if' '(' expression ')' statement elseClause?
    ;

elseClause
    : 'else' statement
    ;

iterationStatement
    : whileStatement
    ;

whileStatement
    : 'while' '(' expression ')' statement
    ;

jumpStatement
    : 'return' expression? ';'
    ;

// Expressions
expression
    : assignmentExpression
    ;

assignmentExpression
    : identifierAssignment
    | logicalOrExpression
    ;

identifierAssignment
    : Identifier assignmentOperator assignmentExpression
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
    : logicalAndExpression ('||' logicalAndExpression)*
    ;

logicalAndExpression
    : equalityExpression ('&&' equalityExpression)*
    ;

equalityExpression
    : relationalExpression (('==' | '!=') relationalExpression)*
    ;

relationalExpression
    : additiveExpression (('<' | '>' | '<=' | '>=') additiveExpression)*
    ;

additiveExpression
    : multiplicativeExpression (('+' | '-') multiplicativeExpression)*
    ;

multiplicativeExpression
    : unaryExpression (('*' | '/' | '%') unaryExpression)*
    ;

unaryExpression
    : postfixExpression
    | ('+' | '-' | '!' | '++' | '--') unaryExpression
    ;

postfixExpression
    : primaryExpression postfixOp*
    ;

postfixOp
    : '[' expression ']'
    | '(' argumentExpressionList? ')'
    | ('++' | '--')
    ;

primaryExpression
    : Identifier
    | constant
    | '(' expression ')'
    ;

argumentExpressionList
    : assignmentExpression (',' assignmentExpression)*
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