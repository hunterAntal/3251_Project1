%{

#include <stdio.h>
#include <stdlib.h>
int yylex(void);
int yyerror(const char *s);

%}

%token IF BYE

%%

program: 
         if bye
        ;

if:     
        IF     { printf("Hello World\n");   }
        ;
bye:    
        BYE    { printf("Bye World\n"); exit(0); }
         ;

// This is a change