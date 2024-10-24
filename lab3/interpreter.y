%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "symbol.h"   // Include the symbol header

    extern int yylex();
    void yyerror(const char *s);
%}

%union {
    int int_val;       // For integer values
    char* strval;      // For string literals
    int sym_index;     // For symbol table indices
}

%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token EQU LESSER GREATER LE GE NE
%token PLUS MINUS MULT DIV LPEREN RPEREN ASSIGN
%token <strval> STRING_LITERAL
%token <int_val> INTEGER
%token <sym_index> ID
%type <int_val> expr

%left PLUS MINUS
%left MULT DIV
%nonassoc LESSER GREATER LE GE EQU NE
%right ASSIGN

%%

program:
    stmt_list
    ;

stmt_list:
    statement stmt_list
    | /* empty */
    ;

statement:
    assign_stmt
    | if_stmt
    | print_statement
    | bye_statement
    ;

assign_stmt:
    ID ASSIGN expr SEMICOLON {
        symbol_table[$1].value = $3;
        symbol_table[$1].initialized = 1;
    }
    ;

print_statement:
    PRINT STRING_LITERAL SEMICOLON {
        printf("%s", $2);
    }
    | PRINT expr SEMICOLON {
        printf("%d", $2);
    }
    | PRINT NEWLINE SEMICOLON {
        printf("\n");
    }
    ;

if_stmt:
    IF expr THEN stmt_list ELSE stmt_list ENDIF
    ;

expr:
    expr PLUS expr       { $$ = $1 + $3; }
    | expr MINUS expr    { $$ = $1 - $3; }
    | expr MULT expr     { $$ = $1 * $3; }
    | expr DIV expr      {
        if ($3 == 0) {
            yyerror("Error: Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | expr LESSER expr   { $$ = ($1 < $3) ? 1 : 0; }
    | expr GREATER expr  { $$ = ($1 > $3) ? 1 : 0; }
    | expr LE expr       { $$ = ($1 <= $3) ? 1 : 0; }
    | expr GE expr       { $$ = ($1 >= $3) ? 1 : 0; }
    | expr EQU expr      { $$ = ($1 == $3) ? 1 : 0; }
    | expr NE expr       { $$ = ($1 != $3) ? 1 : 0; }
    | LPEREN expr RPEREN { $$ = $2; }
    | MINUS expr %prec MINUS { $$ = -$2; }  // Unary minus
    | INTEGER            { $$ = $1; }
    | ID {
        if (symbol_table[$1].initialized) {
            $$ = symbol_table[$1].value;
        } else {
            yyerror("Error: Variable used before assignment");
            $$ = 0;
        }
    }
    ;

bye_statement:
    BYE SEMICOLON { printf("Good Bye Cruel World\n"); exit(0); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
