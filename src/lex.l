%{
#include "parse.h"
%}

digit [0-9]
lower [a-z]
upper [A-Z]
letter [a-zA-Z]
alphanum [a-zA-Z0-9_]
int_const {digit}+

%option noyywrap
%x single_str
%x double_str

%%

'                       { BEGIN(single_str); }
<single_str>'           { BEGIN(INITIAL); return STRING_LITERAL; }
<single_str>[^\']       {}

\"                      { BEGIN(double_str); }
<double_str>\"          { BEGIN(INITIAL); return STRING_LITERAL; }
<double_str>[^\"]       {}

class           { return CLASS; }
case            { return CASE; }
if              { return IF; }
else            { return ELSE; }
elsif           { return ELSIF; }
default         { return DEFAULT; }
define          { return DEFINE; }
"->"            { return BEFORE; }
"~>"            { return NOTIFY; }
"=>"            { return ROCKET; }
[{}=,():;?\]\[] { return *yytext; }
"$"{alphanum}+  { return VARIABLE; }
{lower}{alphanum}*      { return NAME; }
{upper}{alphanum}*      { return RSCREF; }

[ \t]*          {}
[\n]            { yylineno++; }

.               { yyerror("lex hates you"); exit(1); }
