%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE FACTORIAL POWER
%token LEFT RIGHT
%token END

%left PLUS MINUS
%left TIMES DIVIDE
%left NEG
%right FACTORIAL
%right SIN COS TAN
%right POWER

%start Input
%%

Input:
    
     | Input Line
;

Line:
     END
     | Expression END { printf("\nResult: %f\n", $1); }
;

Expression:
     NUMBER { $$=$1;}
| Expression PLUS Expression   { $$=$1+$3; printf("PLUS : %f %f", $1, $3); printf(" +\n");}
| Expression MINUS Expression  { $$=$1-$3; printf("MINUS : %f %f", $1, $3);  printf(" -\n");}
| Expression TIMES Expression  { $$=$1*$3; printf("TIMES : %f %f", $1, $3);  printf(" *\n");}
| Expression DIVIDE Expression { $$=$1/$3; printf("DIVIDE : %f %f", $1, $3);  printf(" /\n");}
| Expression FACTORIAL { $$=$2; int temp = $2; for (int i = $2 - 1; i > 0; i--) {temp = i * temp;} $$ = temp; printf("FACTORIAL : %f", $2); printf(" !\n");}
| Expression SIN { $$=$2; $$ = sin($2*3.14159265/180); printf("SIN : %f", $2);  printf("sin\n");}
| Expression COS { $$=$2; $$ = cos($2*3.14159265/180); printf("COS : %f", $2);  printf("cos\n");}
| Expression TAN { $$=$2; $$ = tan($2*3.14159265/180); printf("TAN : %f", $2);  printf("tan\n");}
| MINUS Expression %prec NEG { $$=-$2; }
| Expression POWER Expression { $$=pow($1,$3); printf("POWER : %f", $2);  printf(" ^\n");}
| LEFT Expression RIGHT { $$=$2; }
;

%%

int yyerror(char *s) {
  printf("%s\n", s);
}

int yywrap(void)
{
  return 1;
}

int main() {
  if (yyparse())
     fprintf(stderr, "Successful parsing.\n");
  else
     fprintf(stderr, "error found.\n");
}
