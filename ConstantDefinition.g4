grammar ConstantDefinition;

import Terminals, PrimitiveTypes, VariableAssignment;

constDeclaration
    : 'const' type Identifier '=' expression ';'
    ;