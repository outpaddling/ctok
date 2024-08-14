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
    int     token;
    
    while ( (token = yylex()) > 0 )
	printf("Token = %d\n", token);
    
    return 0;
}


void    usage(char *argv[])

{
    fprintf(stderr, "Usage: %s\n", argv[0]);
    exit(EX_USAGE);
}
