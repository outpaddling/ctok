
%{

// #include "y.tab.h"

// COMMENT is not used, as yylex() does not return it
enum { COMMENT=0, TYPE, DEFINE, INCLUDE, IDENT, INTCONST, STRCONST,
	OPEN_BRACE, CLOSE_BRACE, OPEN_PAREN, CLOSE_PAREN,
	OPEN_BRACKET, CLOSE_BRACKET, ASTERISK, SEMICOLON, COLON, COMMA,
	INCREMENT, DECREMENT, EQUALS, ASSIGNMENT, PLUS, MINUS};

%}

alpha   [A-Za-z]
ident   [A-Za-z_0-9]
digit   [0-9]
unary   "++"|"--"
%x COMMENT

%%

%{
    // Ignore comments and whitespace.
    // Must use start conditions for multiline comments
%}

"/*"            { BEGIN(COMMENT); }
<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>\n     { }
<COMMENT>.      { }
\/\/.*$                 { ; }
[ \t\n]+                { ; }

\"(\\.|[^"\\])*\"   { return STRCONST; }

"++"                    { return INCREMENT; }
"--"                    { return DECREMENT; }
"{"                     { return OPEN_BRACE; }
"}"                     { return CLOSE_BRACE; }
"("                     { return OPEN_PAREN; }
")"                     { return CLOSE_PAREN; }
"["                     { return OPEN_BRACKET; }
"]"                     { return CLOSE_BRACKET; }
"*"                     { return ASTERISK; }
";"                     { return SEMICOLON; }
":"                     { return COLON; }
","                     { return COMMA; }
"=="                    { return EQUALS; }
"="                     { return ASSIGNMENT; }
"+"                     { return PLUS; }
"-"                     { return MINUS; }

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
