%{

#include <stdio.h>
#include "y.tab.h"

int yywrap(void)
{
  return 1;
}

%}

number ([1-9][0-9]*)|0|([0-9]+\.[0-9]*)
space  [ \t]
quit   (exit|quit|q)

%%

\+     return ADD;
-      return SUB;
\*     return MUL;
[/\\]  return DIV;
\(     return LP;
\)     return RP;
\n     return CR;

{number} {
  double temp;
  sscanf(yytext, "%lf", &temp);
  yylval.double_value = temp;
  return DOUBLE_LITERAL;
}

{quit} return EXIT;

{space} ;

. {
  fprintf(stderr, "lexical error.\n");
  exit(1);
}

%%
