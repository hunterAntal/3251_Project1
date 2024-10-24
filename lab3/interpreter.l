%{
    /*This is Lab 1*/
    /* Definitions */
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    char str[1024];
%}

/* Rule section */
%%
[ \t]+     {/* Ignore whitespace and tabs*/}
"//".*    {/* Ignore single-line comments */}
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.strval = strdup(yytext); return ID; }  // Recognize identifiers (variable names)
[*]       {return MULT;}
[+]       {return PLUS;}
[-]       {return MINUS;}
[/]       {return DIV;}
[=]       {return ASSIGN;}
[<]       {return LESSER;}
[>]       {return GREATER;}  
[(]       {return LPEREN;}
[)]       {return RPEREN;}
"<="      { return LE; }
">="      { return GE; }
"=="      { return EQU; }
"!="      { return NE; }
[0-9]+    {yylval.int_val = atoi(yytext); return INTEGER;} 

"if"   {return IF;}
"then"  {return THEN;}
"bye"   {return BYE;}  // Corrected BYE token
"else"  {return ELSE;}
"endif" {return ENDIF;}
"print" {return PRINT;}
"newline" {return NEWLINE;}

\"(.*?)\" {
    strncpy(str, &(yytext[1]), strlen(yytext)-2);
    str[strlen(yytext)-2] = (char) 0;
    yylval.strval = strdup(str);
    return STRING_LITERAL;
}
";" {return SEMICOLON;}

\n
. {printf("Input Not Recognized: %s \n", yytext);} /* Error handling */
%%

int yywrap(void) {
    return 1;  // Return 1 to indicate end of input
}

int main(){
    yyparse();  // Start parsing with yacc
    return 0;
}

