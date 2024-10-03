/* Hunter Antal
   1181729
   Lab 1 */
%{

#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(const char *s);

%}

%token HI BYE

%%

program: 
        bye hi
        ;
bye:    
        BYE    { printf("Bye World\n"); exit(0); }
         ;
hi:     
        HI     { printf("Hello World\n");   }
        ;
%%
/* This is a change */