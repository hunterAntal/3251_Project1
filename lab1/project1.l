%{
    /* This is Lab 1 */
    /* Hunter Antal */
    /* 1181729 */
    /* Definitions */
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yyerror(char *errormsg);
    char str[1024];
%}

/* Rule section */
%%
[\t]
"//".*    {/* Ignore single-line comments */}
[*]       {printf("operator: * \n");} /* Catch Operators */
[+]       {printf("operator: + \n");}
[-]       {printf("operator: - \n");}
[/]       {printf("operator: / \n");}
[=]       {printf("operator: = \n");}
[<]       {printf("operator: < \n");}
[>]       {printf("operator: > \n");}  
[(]       {printf("Parenthesis: %s\n", yytext);}
[)]       {printf("Parenthesis: %s\n", yytext);}
[0-9]+    {printf("Integer: %s\n", yytext);} /* Catch Numbers */


"if"   {printf("Keyword: %s \n", yytext);} /* Catch Keywords */
"then"  {printf("Keyword: %s \n", yytext);}
"else"  {printf("Keyword: %s \n", yytext);}
"endif" {printf("Keyword: %s \n", yytext);}
"print" {printf("Keyword: %s \n", yytext);}
"newline" {printf("Keyword: %s \n", yytext);}

[a-zA-Z][a-zA-Z0-9]*   {printf("Identifier: %s\n", yytext);} /* Catch Identifiers */

\"(.*?)\" {strncpy(str, &(yytext[1]), strlen(yytext)-2); /* Catch String an Remove Quotes */
str[strlen(yytext)-2] = (char) 0;
{printf("Quote: %s\n", str);}}

";" {printf("Semicolon\n");} /* Catch Semicolon */

\n        //{return 0;}
. {printf("Input Not Reconized: %s \n", yytext);} /* Error handling */
%%

int yywrap(void) { /* Boiler Plate */
    exit(0); // Makes the Program Exit Gracefully
    return 0;
}

int main(){ // Main Function
    yylex();
    return 0;
}

int yyerror(char *errormsg) { /* Error Handling */
    fprintf(stderr, "%s\n", errormsg);
    exit(1);
}
