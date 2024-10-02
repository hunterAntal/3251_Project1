%{

#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern void yyerror(const char *s);
%}

%token IF BYE THEN ELSE ENDIF PRINT NEWLINE

%%

program: 
         if then else endif print newline bye
        ;

if:     
        IF     { printf("If\n");   }
        ;

then:
        THEN   { printf("Then\n"); }
        ;
else:
        ELSE   { printf("Else\n"); }
        ;
endif:  
        ENDIF  { printf("Endif\n"); }
        ;       
print:
        PRINT  { printf("Print\n"); }
        ;
newline:
        NEWLINE { printf("Newline\n"); }
        ;
bye:    
        BYE    { printf("Bye World\n"); exit(0); }
         ;
// This is a change