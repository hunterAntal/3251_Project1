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
[*]       {printf("operator: * \n");}
[+]       {printf("operator: + \n");}
[-]       {printf("operator: - \n");}
[/]       {printf("operator: / \n");}
[=]       {printf("operator: = \n");}
[<]       {printf("operator: < \n");}
[>]       {printf("operator: > \n");}  
[(]       {printf("Parenthesis: %s\n", yytext);}
[)]       {printf("Parenthesis: %s\n", yytext);}
[0-9]+    {printf("Integer: %s\n", yytext);} 

"if"   {return IF;}
"then"  {return THEN;}
"bye"   {return BYE;}  // Corrected BYE token
"else"  {return ELSE;}
"endif" {return ENDIF;}
"print" {return PRINT;}
"newline" {return NEWLINE;}

[a-zA-Z][a-zA-Z0-9]*   {printf("Identifier: %s\n", yytext);}

\"(.*?)\" {
    strncpy(str, &(yytext[1]), strlen(yytext)-2);
    str[strlen(yytext)-2] = (char) 0;
    /**
     * Copies the given string `str` to `yylval.strVal` using `strdup`.
     *
     * This function duplicates the string `str` and assigns the duplicated
     * string to the `strVal` member of the `yylval` union. The `strdup` 
     * function allocates memory for the new string, which must be freed 
     * later to avoid memory leaks.
     */
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

