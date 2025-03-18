grammar attempt3; 

// Program structure
program
    : declarationList EOF
    ;

declarationList
    : declaration*
    ;

// Add a lookahead predicate to distinguish function from variable declarations
declaration
    : constDeclaration
    | typeSpecifier Identifier declarationRest
    ;

declarationRest
    : '(' parameterList? ')' compoundStatement    # FunctionDeclaration
    | declaratorList ';'                          # VariableDeclaration
    ;

parameterList
    : parameter (',' parameter)*
    ;

parameter
    : typeSpecifier Identifier
    ;

// Variable declarations
constDeclaration
    : 'const' typeSpecifier constDeclaratorList ';'
    ;

declaratorList
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
    | ifStatement
    | whileStatement
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
    | variableDecl
    ;

variableDecl
    : typeSpecifier declaratorList ';'
    | constDeclaration
    ;

expressionStatement
    : expressionOpt ';'
    ;

expressionOpt
    : expression?
    ;

// Use a single ifStatement rule with lookahead to ensure LL(1) compliance
ifStatement
    : 'if' '(' expression ')' statement ('else' statement)?
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

assignmentExpression
    : logicalOrExpression 
      (assignmentOperator assignmentExpression)?
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
    : logicalAndExpression 
      ('||' logicalAndExpression)*
    ;

logicalAndExpression
    : equalityExpression 
      ('&&' equalityExpression)*
    ;

equalityExpression
    : relationalExpression
      (equalityOperator relationalExpression)*
    ;

equalityOperator
    : '=='
    | '!='
    ;

relationalExpression
    : additiveExpression
      (relationalOperator additiveExpression)*
    ;

relationalOperator
    : '<'
    | '>'
    | '<='
    | '>='
    ;

additiveExpression
    : multiplicativeExpression
      (additiveOperator multiplicativeExpression)*
    ;

additiveOperator
    : '+'
    | '-'
    ;

multiplicativeExpression
    : unaryExpression
      (multiplicativeOperator unaryExpression)*
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
    : primaryExpression
      (arrayAccess | functionCall | incDec)*
    ;

arrayAccess
    : '[' expression ']'
    ;

functionCall
    : '(' argumentList? ')'
    ;

incDec
    : '++'
    | '--'
    ;

argumentList
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