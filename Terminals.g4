grammar Terminals; 

// Lexer Rules
Identifier: [a-zA-Z_][a-zA-Z0-9_]*;

IntegerConstant: [0-9]+;
FloatingConstant: [0-9]+ '.' [0-9]+;
BooleanConstant: 'true' | 'false';
CharConstant: '\'' . '\'';

// Skip whitespace and comments
WS: [ \t\r\n]+ -> skip;
COMMENT: '//' ~[\r\n]* -> skip;
MULTILINE_COMMENT: '/*' .*? '*/' -> skip;