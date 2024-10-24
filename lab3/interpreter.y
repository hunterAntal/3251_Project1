%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAX_SYMBOLS 100  // Maximum number of variables in the symbol table

// Struct to store variable names and values
typedef struct {
    char* name;
    int value;
} Symbol;

Symbol symbol_table[MAX_SYMBOLS];
int symbol_count = 0;  // Current count of symbols

// Function prototypes for the symbol table
int lookup_symbol(const char* name);
void add_symbol(const char* name, int value);
void update_symbol(const char* name, int value);
int get_symbol_value(const char* name);

extern int yylex();
extern int yyparse();
extern void yyerror(const char *s);
%}

%union {
    int int_val;  // For integer values
    char* strval; // For string literals and variable names
}

%token <strval> STRING_LITERAL  // String literals
%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token EQU LESSER GREATER LE GE NE  // Comparison operators
%token PLUS MINUS MULT DIV LPEREN RPEREN ASSIGN
%token <strval> ID  // Identifiers (variable names)
%type <int_val> expr  // Expression results are integers
%token <int_val> INTEGER  // Integer tokens

%left PLUS MINUS   // Precedence for addition and subtraction
%left MULT DIV     // Precedence for multiplication and division
%nonassoc LESSER GREATER LE GE EQU NE  // Non-associative comparison operators

%%

program:
    stmt_list
    ;

stmt_list:
    statement stmt_list
    | /* empty */
    ;

statement:
    print_statement
    | bye_statement
    | assign_statement
    | expr SEMICOLON  // Allow expressions to stand alone
    | if_stmt  // Add if_stmt to handle if-else structures
    ;

assign_statement:
    ID ASSIGN expr SEMICOLON {
        update_symbol($1, $3);  // Add or update the variable in the symbol table
    }
    ;

print_statement:
    PRINT STRING_LITERAL SEMICOLON { printf("%s\n", $2); }
    | PRINT expr SEMICOLON { printf("%d\n", $2); }
    | PRINT NEWLINE SEMICOLON { printf("\n"); }
    ;

if_stmt:
    IF expr THEN stmt_list ENDIF
    | IF expr THEN stmt_list ELSE stmt_list ENDIF
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
    | ID { $$ = get_symbol_value($1); }  // Retrieve variable value from the symbol table
    ;

bye_statement:
    BYE SEMICOLON { printf("Good Bye Cruel World\n"); exit(0); }
    ;

%%

// Function to search for a symbol by name
int lookup_symbol(const char* name) {
    for (int i = 0; i < symbol_count; i++) {
        if (strcmp(symbol_table[i].name, name) == 0) {
            return i;  // Return index if found
        }
    }
    return -1;  // Return -1 if not found
}

// Function to add a new symbol
void add_symbol(const char* name, int value) {
    if (symbol_count < MAX_SYMBOLS) {
        symbol_table[symbol_count].name = strdup(name);  // Store a copy of the name
        symbol_table[symbol_count].value = value;
        symbol_count++;
    } else {
        printf("Symbol table is full!\n");
    }
}

// Function to update a symbol's value
void update_symbol(const char* name, int value) {
    int index = lookup_symbol(name);
    if (index != -1) {
        symbol_table[index].value = value;  // Update the value if found
    } else {
        add_symbol(name, value);  // If not found, add a new symbol
    }
}

// Function to get a symbol's value
int get_symbol_value(const char* name) {
    int index = lookup_symbol(name);
    if (index != -1) {
        return symbol_table[index].value;  // Return the value if found
    } else {
        printf("Error: Undefined variable '%s'\n", name);
        exit(1);  // Exit with an error if variable not found
    }
}

// Error handling function
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
