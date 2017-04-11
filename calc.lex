%{
#define YYSTYPE double
#include "calc.tab.h"
#include <stdlib.h>
%}

white [ \t]+
digit [0-9]
integer {digit}+
exponent [eE][+-]?{integer}
real {integer}("."{integer})?{exponent}?

%%

{white} { }
{real} { yylval=atof(yytext); 
 return NUMBER;
}

"sin" return SIN;
"cos" return COS;
"tan" return TAN;
"!" return FACTORIAL;
"+" return PLUS;
"-" return MINUS;
"*" return TIMES;
"/" return DIVIDE;
"^" return POWER;
"(" return LEFT;
")" return RIGHT;
"\n" return END;
 