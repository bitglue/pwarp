%{
#include "parse.h"

extern int yyerror(char *s);

#define YY_NO_INPUT
%}

digit [0-9]
hexdigit [0-9a-fA-F]
lower [a-z]
upper [A-Z]
letter [a-zA-Z]
alphanum [a-zA-Z0-9_]
int_const {digit}+

%option noyywrap
%option nounput
%x single_str
%x double_str

%%

'                       { BEGIN(single_str); }
<single_str>'           { BEGIN(INITIAL); return STRING_LITERAL; }
<single_str>[^\']       {}

\"                      { BEGIN(double_str); }
<double_str>\"          { BEGIN(INITIAL); return STRING_LITERAL; }
<double_str>[^\"]       {}

true            { return TRUE; }
false           { return FALSE; }
and             { return AND; }
or              { return OR; }
in              { return IN; }
class           { return CLASS; }
case            { return CASE; }
if              { return IF; }
else            { return ELSE; }
elsif           { return ELSIF; }
default         { return DEFAULT; }
define          { return DEFINE; }
"=="            { return EQ; }
"!="            { return NE; }
"<="            { return LTE; }
">="            { return GTE; }
"->"            { return BEFORE; }
"~>"            { return NOTIFY; }
"=>"            { return ROCKET; }
[{}=,():;\]\[+-/*%<>!]  { return *yytext; }
{digit}+                { return INT_LITERAL; }
0x{hexdigit}+           { return INT_LITERAL; }
{digit}+\.{digit}*      { return FLOAT_LITERAL; }
"$"{alphanum}+          { return VARIABLE; }
{lower}{alphanum}*      { return NAME; }
{upper}{alphanum}*      { return RSCREF; }

[ \t]*          {}
[\n]            { yylineno++; }

.               { yyerror("lex hates you"); exit(1); }
