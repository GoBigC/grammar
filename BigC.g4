grammar BigC;

import ConstantDefinition, VariableAssignment, IfStatement, WhileLoop, Terminals, PrimitiveTypes, FunctionDefinition, ArithmeticExpression, FunctionCallExpression, LogicalExpression;

// Expression precedence (from highest to lowest):
// 1. Primary expressions (constants, variables, parenthesized)
// 2. Postfix operations (arr[i], fn(), x++, x--)
// 3. Unary operations (++x, --x)
// 4. Multiplicative (*, /, %)
// 5. Additive (+, -)
// 6. Comparison (<, <=, >=, >)
// 7. Equality (==, !=)
// 8. Logical AND (&&)
// 9. Logical OR (||)
// 10. Assignment (=)

program
    : declaration* EOF
    ;
