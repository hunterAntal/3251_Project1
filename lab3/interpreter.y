%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define MAX_SYMBOLS 100  // Maximum number of symbols

    typedef struct {
        char* name;     // Variable name
        int value;      // Variable value
        int initialized; // Flag indicating if the variable has been initialized
    } Symbol;

    Symbol symbol_table[MAX_SYMBOLS];
    int symbol_count = 0;

    int find_symbol(const char* name) {
        for (int i = 0; i < symbol_count; ++i) {
            if (strcmp(symbol_table[i].name, name) == 0) {
                return i;
            }
        }
        return -1;
    }

    int add_symbol(const char* name) {
        if (symbol_count >= MAX_SYMBOLS) {
            fprintf(stderr, "Error: Symbol table overflow\n");
            exit(1);
        }
        symbol_table[symbol_count].name = strdup(name);
        symbol_table[symbol_count].value = 0;
        symbol_table[symbol_count].initialized = 0;
        return symbol_count++;
    }

    void yyerror(const char *s);
    extern int yylex(void);

%}

%union {
    int int_val;       // For integer values
    char* strval;      // For identifiers and string literals
}

%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token EQU LESSER GREATER LE GE NE
%token PLUS MINUS MULT DIV LPEREN RPEREN ASSIGN
%token <strval> STRING_LITERAL
%token <int_val> INTEGER
%token <strval> ID
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
        int idx = find_symbol($1);
        if (idx == -1) {
            idx = add_symbol($1);
        }
        symbol_table[idx].value = $3;
        symbol_table[idx].initialized = 1;
        free($1); // Free the duplicated string
    }
    ;

print_statement:
    PRINT STRING_LITERAL SEMICOLON {
        printf("%s", $2);
        free($2); // Free the duplicated string
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
    | MINUS expr %prec MINUS { $$ = -$2; }
    | INTEGER            { $$ = $1; }
    | ID {
        int idx = find_symbol($1);
        if (idx == -1 || !symbol_table[idx].initialized) {
            yyerror("Error: Variable used before assignment");
            $$ = 0;
        } else {
            $$ = symbol_table[idx].value;
        }
        free($1); // Free the duplicated string
    }
    ;

bye_statement:
    BYE SEMICOLON { printf("Good Bye Cruel World\n"); exit(0); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
