parser grammar SysYParser;

options {
  tokenVocab = SysYLexer;
//  language=Cpp;
}

compUnit    : (decl | funcDef)+;

decl         : constDecl 
				      | varDecl;

constDecl    : CONST bType constDef (COMMA constDef)* SEMICOLON;

bType        : INT 
				      | FLOAT;

constDef     : ident (LBRACK constExp RBRACK)* ASSIGN constInitVal;

constInitVal : constExp | LBRACE (constInitVal (COMMA constInitVal)*)? RBRACE;

varDecl      : bType varDef (COMMA varDef)* SEMICOLON;

varDef       : ident (LBRACK constExp RBRACK)? (ASSIGN initVal)?;

initVal      : exp 
				      | LBRACE (initVal (COMMA initVal)*)? RBRACE;

funcDef      : funcType ident LPAREN (funcFParams)? RPAREN block;

funcType     : VOID | INT | FLOAT;

funcFParams  : funcFParam (COMMA funcFParam)*;

funcFParam   : bType ident (LBRACK RBRACK (LBRACK exp RBRACK)*)?;

block        : LBRACE (blockItem)* RBRACE;

blockItem    : decl | stmt;

stmt         : lVal ASSIGN exp SEMICOLON
             | (exp)? SEMICOLON
             | block
             | IF LPAREN cond RPAREN stmt (ELSE stmt)?
             | WHILE LPAREN cond RPAREN stmt
             | BREAK SEMICOLON
             | CONTINUE SEMICOLON
             | RETURN (exp)? SEMICOLON;

exp          : addExp;

cond         : lOrExp;

lVal         : ident (LBRACK exp RBRACK)*;

primaryExp   : LPAREN exp RPAREN | lVal | number;

unaryExp     : primaryExp
             | ident LPAREN (funcRParams)? RPAREN
             | unaryOp unaryExp;

number       : intConst 
			        | floatConst;


intConst	: DECIMAL_CONST
			    | OCTAL_CONST
			    | HEX_CONST;

floatConst	: DECIMAL_FLOATING_CONST
			      | HEX_FLOATING_CONST;

unaryOp      : ADD | SUB | NOT;

funcRParams  : exp (COMMA exp)*;

mulExp      : unaryExp (op=(MUL|DIV|MOD) unaryExp)*;

addExp      : mulExp (op=(ADD|SUB) mulExp)*;

relExp      : addExp (op=(LT|GT|LE|GE) addExp)*;

eqExp       : relExp (op=(EQ|NEQ) relExp)*;

lAndExp     : eqExp (op=AND eqExp)*;

lOrExp       : lAndExp (op=OR lAndExp)*;

constExp     : addExp;

ident        : IDENTIFIER;

