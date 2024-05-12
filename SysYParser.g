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

varDef       : ident (LBRACK constExp RBRACK)* (ASSIGN initVal)?;

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

constExp      : exp;

exp          : LPAREN exp RPAREN
              | lVal
              | number
              | ident LPAREN (funcRParams)? RPAREN
              | unaryOp exp
              | exp (op=(MUL | DIV | MOD)) exp
              | exp (op=(ADD | SUB)) exp;

cond         : exp
              | cond (op=(LT | GT | LE | GE)) cond
              | cond (op=(EQ | NEQ)) cond
              | cond op=AND cond
              | cond op=OR cond;

lVal         : ident (LBRACK exp RBRACK)*;

number       : intConst 
              | floatConst;


intConst        : DECIMAL_CONST
                            | OCTAL_CONST
                            | HEX_CONST;

floatConst        : DECIMAL_FLOATING_CONST
                              | HEX_FLOATING_CONST;

unaryOp      : ADD | SUB | NOT;

funcRParams  : exp (COMMA exp)*;

ident        : IDENTIFIER;
