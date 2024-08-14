
%{

// #include "y.tab.h"

// COMMENT is not used, as yylex() does not return it
enum { COMMENT=0, TYPE, INCREMENT, DEFINE, INCLUDE, IDENT, INTCONST };

%}

alpha   [A-Za-z]
ident   [A-Za-z_0-9]
digit   [0-9]
unary   "++"|"--"
%x C_COMMENT

%%

%{
    // Ignore comments and whitespace.
    // Must use start conditions for multiline comments
%}

"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>\n   { }
<C_COMMENT>.    { }

\/\/.*$                 { ; }
[ \t]+                  { ; }

"++"                    { return INCREMENT; }

#define.*$              { return DEFINE; }
#include.*$             { return INCLUDE; }

"char"|"short"|"int"|"long"|"long"[ \t\n]+"long"|"void"|"float"|"double"|"long"[ \t\n]+"double" { return TYPE; }

{alpha}{ident}*         { return IDENT; }
{digit}+                { return INTCONST; }

%%

int yywrap() {
    // Causes hang: yyterminate();
    return EOF;
}
