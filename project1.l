%{
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
"//".*    {/* Ignore single-line comments */}
[*]       {printf("operator: * \n");}
[+]       {printf("operator: + \n");}
[-]       {printf("operator: - \n");}
[/]       {printf("operator: / \n");}
[=]       {printf("operator: = \n");}
[<]       {printf("operator: < \n");}
[>]       {printf("operator: > \n");}  
[(]       {printf("Parenthesis: %s", yytext);}
[)]       {printf("Parenthesis: %s", yytext);}
[0-9]+    {printf("Integer: %s\n", yytext);} 


\bif\b    {printf("Keyword: %s \n", yytext);}
\bthen\b  {printf("Keyword: %s \n", yytext);}
\belse\b  {printf("Keyword: %s \n", yytext);}
\bendif\b {printf("Keyword: %s \n", yytext);}
\bprint\b {printf("Keyword: %s \n", yytext);}
\bnewline\b {printf("Keyword: %s \n", yytext);}

[a-zA-Z][a-zA-Z0-9]*   {printf("Identifier: %s\n", yytext);}

\"(.*?)\" {strncpy(str, &(yytext[1]), strlen(yytext)-2);
str[strlen(yytext)-2] = (char) 0;
{printf("Quote: %s\n", str);}}

. {printf("Input Not Reconized: %s \n", yytext);} /* Error handling*/
\n        {return 0;}
%%

int yywrap(void) {
    return 0;
}

int main(){
    // printf("Enter String: \n");
    yylex();
    return 0;
}

int yyerror(char *errormsg) {
    fprintf(stderr, "%s\n", errormsg);
    exit(1);
}
