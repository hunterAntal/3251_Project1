%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern void yyerror(const char *s);

void print_string(const char* str);  // Function to print strings
%}

%union {
    char* strval;  // To hold string literals
}

%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token <strval> STRING_LITERAL  // Declare STRING_LITERAL as using the strval field in %union

%%

program:
    statements
    ;

statements:
    statement statements
    | /* empty */
    ;

statement:
    if_statement
    | print_statement
    | bye_statement
    | newline
    ;

if_statement:
    IF THEN ELSE ENDIF { printf("If-Then-Else-Endif\n"); }
    ;

print_statement:
    PRINT STRING_LITERAL SEMICOLON { print_string($2); }
    ;
newline:
        NEWLINE { printf("Newline\n"); }
        ;

bye_statement:
    BYE { printf("Bye World\n"); exit(0); }
    ;

%%

void print_string(const char* str) {
    printf("%s\n", str);  // Output the string
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
