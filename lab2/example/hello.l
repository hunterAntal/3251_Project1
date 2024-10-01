%{
#include <stdlib.h>
  #include "y.tab.h"
%}
%%

("tchau"|"bye")"\n"   { return BYE; }
("hi"|"oi")"\n"       { return HI;  }
.                     { yyerror();  }
%%
int main(void)
  {
    while(1){
        yyparse();
        return 0;
    }
     
  }
int yywrap(void)
  {
     return 0;
  }
int yyerror(void)
  {
      printf("Error\n");
      exit(1);
  }
