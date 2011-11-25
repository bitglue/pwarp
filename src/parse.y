%token IDENTIFIER
%token ROCKET
%token CLASS
%token STRING_LITERAL
%token DEFAULT
%token VARIABLE

%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

input:
    /* empty */
    | statements_and_declarations

statements_and_declarations:
    statement_or_declaration
    | statements_and_declarations statement_or_declaration

statement_or_declaration:
    resource
    | assignment

resource:
    IDENTIFIER '{' resourceinstances endsemi '}'

resourceinstances:
    resourceinst
    | resourceinstances ';' resourceinst

resourceinst:
    expr ':' params endcomma

params:
    /* empty */
    | param
    | params ',' param

param:
    IDENTIFIER ROCKET expr

expr:
    STRING_LITERAL

endcomma:
    /* empty */
    | ','

endsemi:
    /* empty */
    | ';'

assignment:
    VARIABLE '=' expr

%%

extern char *yytext;
extern int yylineno;

int yyerror(char *s) {
    fprintf(stderr, "ERROR: %s at symbol %s on line %i\n", s, yytext, yylineno);
    exit(1);
}
