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
    static char *token_names[] =
	{ "comment", "type", "increment", "define", "include", "ident", "intconst" };
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
