
%{

// #include "y.tab.h"

enum { COMMENT=1, INCREMENT, DEFINE, INCLUDE, IDENT, INTCONST };

%}

alpha   [A-Za-z]
ident   [A-Za-z_0-9]
digit   [0-9]
unary   "++"|"--"

%%

\/\*.*\*\/              { ; }
\/\/.*$                 { ; }
[ \t]+                  { ; }

"++"                    { return INCREMENT; }

#define                 { return DEFINE; }
#include                { return INCLUDE; }

{alpha}{ident}*         { return IDENT; }
{digit}+                { return INTCONST; }

%%

int yywrap() {
    return 1;
}
