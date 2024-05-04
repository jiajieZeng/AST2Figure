lexer grammar SysYLexer;

//options { language=Cpp;}

// Define tokens
ADD           : '+';
SUB           : '-';
MUL           : '*';
DIV           : '/';
MOD           : '%';
EQ            : '==';
NEQ           : '!=';
LT            : '<';
GT            : '>';
LE            : '<=';
GE            : '>=';
AND           : '&&';
OR            : '||';
NOT           : '!';

// Define tokens for punctuation
LPAREN        : '(';
RPAREN        : ')';
LBRACE        : '{';
RBRACE        : '}';
LBRACK        : '[';
RBRACK        : ']';
COMMA         : ',';
SEMICOLON     : ';';
ASSIGN        : '=';
DOT	      : '.';

// Define tokens for keywords
CONST         : 'const';
VOID          : 'void';
INT           : 'int';
FLOAT         : 'float';
IF            : 'if';
ELSE          : 'else';
WHILE         : 'while';
BREAK         : 'break';
CONTINUE      : 'continue';
RETURN        : 'return';

// Define tokens for literals and identifiers
IDENTIFIER    : [a-zA-Z_] [a-zA-Z0-9_]*;

DECIMAL_CONST : NONZERO_DIGIT (DIGIT)*;
OCTAL_CONST	: '0' (OCTAL_DIGIT)*;
HEX_CONST	: HEX_PREFIX (HEX_DIGIT)+;

HEX_PREFIX : '0X'
			| '0x';
NONZERO_DIGIT : [1-9];
OCTAL_DIGIT : [0-7];
DIGIT		: '0'
			| NONZERO_DIGIT;
HEX_DIGIT : [a-fA-F] 
			| DIGIT;

DECIMAL_FLOATING_CONST : FRACTIONAL_CONST (EXPONENT_PART)?
						| DIGIT_SEQUENCE EXPONENT_PART;

FRACTIONAL_CONST : (DIGIT_SEQUENCE)? DOT DIGIT_SEQUENCE
					| DIGIT_SEQUENCE DOT;

EXPONENT_PART : ('E' | 'e') ((ADD | SUB)?) DIGIT_SEQUENCE;

DIGIT_SEQUENCE : DIGIT+;

HEX_FLOATING_CONST: HEX_PREFIX HEX_FRACTIONAL_CONST BINARY_EXPONENT_PART
					| HEX_PREFIX HEX_DIGIT_SEQUENCE BINARY_EXPONENT_PART;

HEX_FRACTIONAL_CONST : (HEX_DIGIT_SEQUENCE)? DOT HEX_DIGIT_SEQUENCE
						| HEX_DIGIT_SEQUENCE DOT;

HEX_DIGIT_SEQUENCE	: HEX_DIGIT+;

BINARY_EXPONENT_PART	: ('P' | 'p') ((ADD | SUB)?) DIGIT_SEQUENCE;



// Ignore spaces and tabs
WS            : [ \t\r\n] -> skip;

// Define tokens for comments
SINGLE_LINE_COMMENT : '//' ~[\r\n]* -> skip;
MULTI_LINE_COMMENT  : '/*' .*? '*/' -> skip;
