%{

#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1

#define PROMP "> "

%}

%union {
  int    int_value;
  double double_value;
}

%token  <double_value>  DOUBLE_LITERAL
%token  ADD SUB MUL DIV
%token  CR LP RP
%token  EXIT

%type   <double_value>  expression term primary_expression

%%

line_list
: line
| line_list line
;

line
: expression CR | CR
{
  printf("= %1f\n%s", $1, PROMP);
}
| EXIT CR
{
  exit(0);
}
;

expression
: term
| expression ADD term
{
  $$ = $1 + $3;
}
| expression SUB term
{
  $$ = $1 - $3;
}
;

term
: primary_expression
| term MUL primary_expression
{
  $$ = $1 * $3;
}
| term DIV primary_expression
{
  $$ = $1 / $3;
}
;

primary_expression
: DOUBLE_LITERAL
| SUB DOUBLE_LITERAL
{
  $$ = -$2;
}
| LP expression RP
{
  $$ = $2;
}
;

%%

int yyerror(char const *str)
{
  extern char *yytext;
  fprintf(stderr, "parser error near %s\n", yytext);
  return 0;
}

int main(void)
{
  extern int yyparse(void);
  extern FILE *yyin;

  printf(PROMP);

  yyin = stdin;
  if(yyparse())
    {
      fprintf(stderr, "Error!\n");
      exit(1);
    }
}
