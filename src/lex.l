%{
#include "parse.h"
#include "lex.h"

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
lowerword {lower}{alphanum}*
operator [{}=,():;\]\[+-/*%<>!?@]

%option noyywrap
%option nounput
%x single_str
%x double_str

%%

'                       { BEGIN(single_str); }
<single_str>\\.         {}
<single_str>'           { BEGIN(INITIAL); return STRING_LITERAL; }
<single_str>[^\']       {}

\"                      { BEGIN(double_str); }
<double_str>\\.         {}
<double_str>\"          { BEGIN(INITIAL); return STRING_LITERAL; }
<double_str>[^\"]       {}

true            { return TRUE; }
false           { return FALSE; }
and             { return AND; }
or              { return OR; }
in              { return IN; }
class           { return CLASS; }
node            { return NODE; }
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
"<|"            { return SPACESHIP_LEFT; }
"|>"            { return SPACESHIP_RIGHT; }
{operator}      { return *yytext; }
{digit}+                { return INT_LITERAL; }
0x{hexdigit}+           { return INT_LITERAL; }
{digit}+\.{digit}*      { return FLOAT_LITERAL; }
"$"{alphanum}+(::{alphanum}+)*  { return VARIABLE; }
{lowerword}(::{lowerword})*     { return NAME; }
{upper}{alphanum}*      { return RSCREF; }

[ \t]*|#[^\n]*  {}
[\n]            { yylineno++; }

.               { yyerror("lex hates you"); exit(1); }

%%

int
parse_string (char *s)
{
  int result;
  YY_BUFFER_STATE sbuf = yy_scan_string(s);
  result = yyparse();
  yy_delete_buffer(sbuf);
  return result;
}
