%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern void yyerror(const char *s);

%}

%union {
    int val;
    char *str;
}

%token PRINT NEWLINE
%token <str> STRING
%token <val> INT

%%

program:
    stmt_list
    ;

stmt_list:
    stmt_list stmt
    | stmt
    ;

stmt:
    print_stmt
    ;

print_stmt:
    PRINT STRING ';' { printf("%s\n", $2); free($2); }
    | PRINT INT ';' { printf("%d\n", $2); }
    | PRINT NEWLINE ';' { printf("\n"); }
    ;

%%

int main() {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
