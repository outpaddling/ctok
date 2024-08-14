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
#include "ctok.h"

void    usage(char *argv[]);

int     main(int argc,char *argv[])

{
    FILE    *infile;
    
    switch(argc)
    {
	case 1:
	    infile = stdin;
	    break;
	
	default:
	    usage(argv);
	    return EX_USAGE;
    }
    
    return ctok(infile);
}


int     ctok(FILE *infile)

{
    // See c.lex for names and ordinal values
    // These must be in the same order as the enum!!
    static char *token_names[] =
	{
	    "comment", "type", "define", "include", "ident",
	    "intconst", "strconst",
	    "open-brace", "close-brace",
	    "open-paren", "close-paren", "open-bracket", "close-bracket",
	    "asterisk", "semicolon", "colon", "comma", "increment",
	    "decrement", "equals", "assignment", "plus", "minus"
	};
    int     token;
    extern char *yytext;
    
    while ( (token = yylex()) > 0 )
	printf("%s:%s\n", token_names[token], yytext);
    
    return 0;
}


void    usage(char *argv[])

{
    fprintf(stderr, "Usage: %s\n", argv[0]);
    exit(EX_USAGE);
}
