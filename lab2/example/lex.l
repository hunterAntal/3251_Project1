%{
/* Definitions */
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int yyerror(char *errormsg);
    char str[1024];
%}

%%

"print"      { return PRINT; }    // Recognize the 'print' keyword
\"(.*?)\" {strncpy(str, &(yytext[1]), strlen(yytext)-2);
str[strlen(yytext)-2] = (char) 0;
{return STRING;}}  // Capture the string without quotes
\n           { return NEWLINE; }  // Recognize newline characters
[0-9]+       { yylval.val = atoi(yytext); return INT; }  // Recognize integers
[ \t]+       ;  // Ignore whitespace
";"          { return ';'; }  // Recognize semicolons
.            { return yytext[0]; }  // Catch all for other characters

%%

int yywrap() {
    return 1;
}
