
%{

// #include "y.tab.h"

// COMMENT is not used, as yylex() does not return it
enum { COMMENT=0, TYPE, DEFINE, IFDEF, IFNDEF, ENDIF, INCLUDE,
	IDENT, INTCONST, STRCONST,
	OPEN_BRACE, CLOSE_BRACE, OPEN_PAREN, CLOSE_PAREN,
	OPEN_BRACKET, CLOSE_BRACKET, ASTERISK, SEMICOLON, COLON, COMMA,
	INCREMENT, DECREMENT, EQUALS, ASSIGNMENT, PLUS, MINUS,
	ENUM};

%}

ident_start [A-Za-z_]
ident       [A-Za-z_0-9]
digit       [0-9]
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
#ifdef.*$               { return IFDEF; }
#ifndef.*$              { return IFNDEF; }
#endif.*$               { return ENDIF; }

"char"|"short"|"int"|"long"|"long"[ \t\n]+"long"|"void"|"float"|"double"|"long"[ \t\n]+"double" { return TYPE; }

"enum"                  { return ENUM; }

{ident_start}{ident}*   { return IDENT; }
{digit}+                { return INTCONST; }

%%

int yywrap() {
    // Causes hang: yyterminate();
    return EOF;
}
