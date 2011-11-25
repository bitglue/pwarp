%token IDENTIFIER
%token ROCKET
%token CLASS
%token CASE
%token STRING_LITERAL
%token DEFAULT
%token VARIABLE
%token IF
%token ELSE
%token ELSIF
%token DEFINE

%{
#include <stdio.h>
#include <stdlib.h>
%}

%%

input:
    opt_statements_and_declarations

opt_statements_and_declarations:
    /* empty */
    | statements_and_declarations

statements_and_declarations:
    statement_or_declaration
    | statements_and_declarations statement_or_declaration

statement_or_declaration:
    resource
    | assignment
    | casestatement
    | ifstatement
    | definition

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

casestatement:
    CASE expr '{' caseopts '}'

caseopts:
    caseopt
    | caseopts caseopt

caseopt:
    casevalues ':' '{' opt_statements_and_declarations '}'

casevalues:
    caselvalue
    | casevalues ',' caselvalue

caselvalue:
    expr
    | DEFAULT

ifstatement:
    IF expr '{' opt_statements_and_declarations '}' else

else:
    /* empty */
    | ELSIF expr '{' opt_statements_and_declarations '}' else
    | ELSE '{' opt_statements_and_declarations '}'

definition:
    DEFINE IDENTIFIER argumentlist '{' opt_statements_and_declarations '}'

argumentlist:
    /* empty */
    | '(' ')'
    | '(' arguments endcomma ')'

arguments:
    argument
    | arguments ',' argument

argument:
    VARIABLE
    | VARIABLE '=' expr

%%

extern char *yytext;
extern int yylineno;

int yyerror(char *s) {
    fprintf(stderr, "ERROR: %s at symbol %s on line %i\n", s, yytext, yylineno);
    exit(1);
}
