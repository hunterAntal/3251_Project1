%{
int linenum=1;
int temp_int;
char temp_str[200];
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "y.tab.h"
%}

%%
\n     {linenum++;}

[\t ]          /* skip spaces */
\/\/[^\n]*     /* ignore comments */

"+"        {return '+';}
"-"        {return '-';} 
"*"        {return '*';} 
"/"        {return '/';} 
")"        {return ')';}
"("        {return '(';}
";"        {return ';';}
"print"    {return PRINT;}
"newline"  {return NEWLINE;}

[0-9]+   {sscanf(yytext, "%d", &temp_int);
          yylval.int_val = temp_int;
          return INT;}

\"[^"\n]*\" {strncpy(temp_str, &(yytext[1]), strlen(yytext)-2);
             temp_str[strlen(yytext)-2] = (char) 0;
             yylval.str_val = temp_str;
             return STRING;}

.  {printf("LEX: unknown input string found in line %d \n", linenum);
    abort();}
%% 

int yywrap()  {return 1;}


