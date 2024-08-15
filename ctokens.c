// Comment

/***************************************************************************
 *  Description:
 *  
 *  Arguments:
 *
 *  Returns:
 *
 *  History: 
 *  Date        Name        Modification
 *  2024-08-14  Jason Bacon Begin
 ***************************************************************************/

#include <stdio.h>
#include <sysexits.h>
#include <stdlib.h>
#include "ctokens.h"

int     main(int argc,char *argv[])

{
    FILE    *infile;
    
    switch(argc)
    {
	case 1:
	    infile = stdin;
	    break;
	
	case 2:
	    if ( (infile = fopen(argv[1], "r")) == NULL )
	    {
		fprintf(stderr, "%s: Cannot open %s.\n", argv[0], argv[1]);
		return EX_NOINPUT;
	    }
	    break;
	    
	default:
	    usage(argv);
	    return EX_USAGE;
    }
    
    return ctokens(infile);
}


int     ctokens(FILE *infile)

{
    // See c.lex for names and ordinal values
    // These must be in the same order as the enum in c.lex!!
    static char *token_names[] =
	{
	    "comment",
	    "define", "ifdef", "ifndef", "endif", "include",
	    "type", "ident",
	    "intconst", "strconst",
	    "open-brace", "close-brace", "open-paren", "close-paren",
	    "open-bracket", "close-bracket",
	    "asterisk", "semicolon", "colon", "comma",
	    "increment", "decrement", "equals", "assignment", "plus", "minus",
	    "enum"
	};
    int     token;
    extern char *yytext;
    extern FILE *yyin;
    
    yyin = infile;
    
    while ( (token = yylex()) > 0 )
	printf("%s:%s\n", token_names[token], yytext);
    
    return 0;
}


void    usage(char *argv[])

{
    fprintf(stderr, "Usage: %s [file]\n", argv[0]);
    exit(EX_USAGE);
}
