%{
    /*Deffinitions*/
    #include "y.tab.h"
    # include <stdio.h>
    # include <stdlib.h>
    # include <string.h>

    int yyerror(char *errormsg);
    char str[1024];
%}


/*Rule section*/
%%
[*] {printf("operator: * \n");}
[+] {printf("operator: + \n");}
[-] {printf("operator: - \n");}
[/] {printf("operator: / \n");}

[0-9] {printf("Intager: %s\n", yytext);}

\"(.*?)\" {strncpy(str, &(yytext[1]), strlen(yytext)-2);
str[strlen(yytext)-2] = (char) 0;
{printf("Quote: %s\n", str);}}



\n {return 0;}
%%

int yywrap(void) {
    return 0;
}

int main(){
    printf("Enter String: ");
    yylex();

    return 0;
}

int yyerror(char *errormsg)
{
    fprintf(stderr, "%s\n", errormsg);
    exit(1);
}