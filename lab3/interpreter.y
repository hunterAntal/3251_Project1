%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <map>
#include <string>

extern int yylex();
extern int yyparse();
extern void yyerror(const char *s);

std::map<std::string, int> symbol_table;  // Symbol table to store variables

%}

%union {
    int int_val;
    char* strval;
}

%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token EQU LESSER GREATER LE GE NE
%token PLUS MINUS MULT DIV LPEREN RPEREN ASSIGN
%token <strval> ID  // Identifier
%type <int_val> expr
%token <int_val> INTEGER

%left PLUS MINUS
%left MULT DIV
%nonassoc LESSER GREATER LE GE EQU NE

%%

program:
    stmt_list
    ;

stmt_list :
    statement stmt_list
    | /* empty */
    ;

statement:
    if_stmt
    | print_statement
    | bye_statement
    | assign_statement  // Handle assignments
    | expr
    ;

assign_statement:
    ID ASSIGN expr SEMICOLON {
        // Store the variable and its value in the symbol table
        symbol_table[$1] = $3;
    }
    ;

print_statement:
    PRINT STRING_LITERAL SEMICOLON { printf("%s", $2); }
    | PRINT expr SEMICOLON { printf("%d", $2); }
    | PRINT NEWLINE SEMICOLON { printf("\n"); }
    ;

if_stmt:
    IF expr THEN { push($2 != 0); } stmt_list { pop(); }
    ELSE { push($2 == 0); } stmt_list { pop(); } ENDIF
    ;

expr:
    expr PLUS expr       { $$ = $1 + $3; }
    | expr MINUS expr    { $$ = $1 - $3; }
    | expr MULT expr     { $$ = $1 * $3; }
    | expr DIV expr      { $$ = $1 / $3; }
    | expr LESSER expr   { $$ = ($1 < $3) ? 1 : 0; }
    | expr GREATER expr  { $$ = ($1 > $3) ? 1 : 0; }
    | expr LE expr       { $$ = ($1 <= $3) ? 1 : 0; }
    | expr GE expr       { $$ = ($1 >= $3) ? 1 : 0; }
    | expr EQU expr      { $$ = ($1 == $3) ? 1 : 0; }
    | expr NE expr       { $$ = ($1 != $3) ? 1 : 0; }
    | LPEREN expr RPEREN { $$ = $2; }
    | INTEGER            { $$ = $1; }
    | ID {
        // Look up the variable in the symbol table
        if (symbol_table.find($1) == symbol_table.end()) {
            yyerror("Undefined variable");
            exit(1);
        } else {
            $$ = symbol_table[$1];
        }
    }
    ;

bye_statement:
    BYE SEMICOLON { printf("Good Bye Cruel World\n"); exit(0); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
