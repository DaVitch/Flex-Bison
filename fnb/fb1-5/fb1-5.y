%{
#include <stdio.h>
%}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP

%%

calclist:
	| calclist exp EOL { printf("= %d\n", $2); }
	;

exp: factor
	| exp ADD factor { $$ = $1 + $3; }
	| exp SUB factor { $$ = $1 - $3; }
	;

factor: term
      	| factor MUL term { $$ = $1 * $3; }
	| factor DIV term { $$ = $1 / $3; }
	;

term: NUMBER
    	| ABS term { $$ = $2 >= 0? $2 : - $2; }
	| OP exp CP { $$ = $2; }
	;
%%

main(int argc, char **Argv)
{
	yyparse();
}

yyerror(char *s)
{
	fprintf(stderr, "error: %s\n", s);
}
