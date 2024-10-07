%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern void yyerror(const char *s);

#define StackSize 10
int s[StackSize] = {1,0,0,0,0,0,0,0,0,0};
int counter = 0;

void push(int value){
    if(counter < StackSize){
        s[counter] = value;
        counter++;
        printf("Pushed\n");
    }else{
        printf("Stack is full\n");
    }
}

int pop(){
    if(counter >=0){
        printf("Pop\n");
        return s[counter--];
    }
    else {
        printf("Stack Empty\n");
        return -1;
    }
}

int top(){
    if(counter >=0){
        printf("Top\n");
        return s[counter];
    }
    else {
        printf("Stack Empty\n");
        return -1;
    }
}



void print_string(const char* str);  // Function to print strings
%}

%union {
    int int_val;
    char* strval;  // To hold string literals
}

%token IF BYE THEN ELSE ENDIF PRINT NEWLINE SEMICOLON
%token EQU LESSER GREATER LE GE NE 
%token PLUS MINUS MULT DIV LPEREN RPEREN ASSIGN
%token <strval> STRING_LITERAL  // Declare STRING_LITERAL as using the strval field in %union
%type <int_val> expr
%token <int_val> INTEGER

%left PLUS MINUS   // Define operator precedence
%left MULT DIV
%nonassoc LESSER GREATER LE GE EQU NE  // Comparison operators are non-associative

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
    | expr
    ;

print_statement:
    PRINT STRING_LITERAL SEMICOLON {if(top() == 1) {printf("%s\n",$2);} }
    | PRINT expr SEMICOLON {if(top() == 1) {printf("%d\n", $2);} }
    | PRINT NEWLINE SEMICOLON {if(top() == 1) {printf("\n");} }
    ;

if_stmt:  
    IF expr THEN {top()==1 ? push($2!=0) : push(0); printf("Top after IF THEN: %d\n", counter);} stmt_list {pop();} 
    ELSE {top()==1 ? push($2==0) : push(0);} stmt_list {pop();} ENDIF 
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
    | LPEREN expr RPEREN { $$ = $2; }   // Parentheses for grouping
    | INTEGER            { $$ = $1; }   // Integer base case
    ;

bye_statement:
    BYE SEMICOLON { printf("Bye World\n"); exit(0); }
    ;

%%
/* void print_string(const char* str) {
    printf("%s\n", str);  // Output the string
} */

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
