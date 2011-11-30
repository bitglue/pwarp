#include <check.h>
#include "suites.h"
#include "../src/lex.h"

#define TEST_INV_EXPR(test_name, string) \
  START_TEST (test_name) \
  { \
    fail_unless (parse_string (string)); \
  } \
  END_TEST

#define TEST_EXPR(test_name, string) \
  START_TEST (test_name) \
  { \
    fail_if (parse_string (string)); \
  } \
  END_TEST

/* Expressions */
TEST_EXPR (test_literal_string,         "$foo = \"literal string\"")
TEST_EXPR (test_literal_int,            "$foo = 1234")
TEST_EXPR (test_literal_hex_int,        "$foo = 0xdead")
TEST_EXPR (test_literal_float,          "$foo = 0.0")
TEST_EXPR (test_literal_float_no_frac,  "$foo = 0.")
TEST_EXPR (test_neg,                    "$foo = -42")
TEST_EXPR (test_parens,                 "$foo = (42)")
TEST_EXPR (test_empty_array,            "$foo = []")
TEST_INV_EXPR (test_comma_array,        "$foo = [,]")
TEST_EXPR (test_array,                  "$foo = [1,\"string\"]")
TEST_EXPR (test_array_trailing_comma,   "$foo = [1,\"string\",]")
TEST_EXPR (test_empty_hash,             "$foo = {}")
TEST_INV_EXPR (test_comma_hash,         "$foo = {,}")
TEST_EXPR (test_hash,                   "$foo = {1 => \"one\", 2 => \"two\"}")
TEST_EXPR (test_hash_trail_comma,       "$foo = {1 => \"one\", 2 => \"two\",}")
TEST_EXPR (test_getitem,                "$foo = {1 => \"one\", 2 => \"two\",}[1]")
TEST_EXPR (test_variable,               "$foo = $bar")
TEST_EXPR (test_add,                    "$foo = 1 + 2")
TEST_EXPR (test_sub,                    "$foo = 1 - 2")
TEST_EXPR (test_mul,                    "$foo = 1 * 2")
TEST_EXPR (test_div,                    "$foo = 1 / 2")
TEST_EXPR (test_mod,                    "$foo = 1 % 2")
TEST_EXPR (test_true,                   "$foo = true")
TEST_EXPR (test_false,                  "$foo = false")
TEST_EXPR (test_and,                    "$foo = true and true")
TEST_EXPR (test_or,                     "$foo = true or true")
TEST_EXPR (test_bang,                   "$foo = !true")
TEST_EXPR (test_in,                     "$foo = 1 in [1, 2, 3]")
TEST_EXPR (test_eq,                     "$foo = 1 == 1")
TEST_EXPR (test_lt,                     "$foo = 1 < 1")
TEST_EXPR (test_lte,                    "$foo = 1 <= 1")
TEST_EXPR (test_gt,                     "$foo = 1 > 1")
TEST_EXPR (test_gte,                    "$foo = 1 >= 1")
TEST_EXPR (test_ne,                     "$foo = 1 != 1")

/* Class definitions */
TEST_EXPR (test_empty_class,            "class foo {}")
TEST_EXPR (test_empty_param_class,      "class foo () {}")
TEST_INV_EXPR (test_empty_param_comma_class, "class foo (,) {}")
TEST_EXPR (test_class_statement,        "class foo { $statements = 'cool' }")
TEST_EXPR (test_1param_class,           "class foo ($argument) {}")
TEST_EXPR (test_default_param_class,    "class foo ($argument,$another='with default') {}")
TEST_EXPR (test_param_trail_comma_class,"class foo ($many,$arguments,) {}")

/* Resource declarations */
TEST_EXPR (test_rsc_noparams,           "notify { '1': }")
TEST_EXPR (test_rsc_param,              "notify { '2': message => 'fun times' }")
TEST_EXPR (test_rsc_2param,             "notify { '3': name => '3', message => 'fun times' }")
TEST_EXPR (test_rsc_2param_comma,       "notify { '4': name => '4', message => 'fun times', }")
TEST_EXPR (test_rsc_2decls,             "notify { '5': message => 'fun times'; '6': message => 'more fun' }")
TEST_EXPR (test_rsc_2decls_endsemi,     "notify { '7': message => 'fun times'; '8': message => 'more fun'; }")
TEST_EXPR (test_rsc_2decl_empty,        "notify { '9':; '10':; }")

Suite *
parse_suite (void)
{
  Suite *s = suite_create ("Parse");

  TCase *tc = tcase_create ("Expression");
  tcase_add_test (tc, test_literal_string);
  tcase_add_test (tc, test_literal_int);
  tcase_add_test (tc, test_literal_hex_int);
  tcase_add_test (tc, test_literal_float);
  tcase_add_test (tc, test_literal_float_no_frac);
  tcase_add_test (tc, test_neg);
  tcase_add_test (tc, test_parens);
  tcase_add_test (tc, test_empty_array);
  tcase_add_test (tc, test_comma_array);
  tcase_add_test (tc, test_array);
  tcase_add_test (tc, test_array_trailing_comma);
  tcase_add_test (tc, test_empty_hash);
  tcase_add_test (tc, test_hash);
  tcase_add_test (tc, test_comma_hash);
  tcase_add_test (tc, test_hash_trail_comma);
  tcase_add_test (tc, test_getitem);
  tcase_add_test (tc, test_variable);
  tcase_add_test (tc, test_add);
  tcase_add_test (tc, test_sub);
  tcase_add_test (tc, test_mul);
  tcase_add_test (tc, test_div);
  tcase_add_test (tc, test_mod);
  tcase_add_test (tc, test_true);
  tcase_add_test (tc, test_false);
  tcase_add_test (tc, test_and);
  tcase_add_test (tc, test_or);
  tcase_add_test (tc, test_bang);
  tcase_add_test (tc, test_in);
  tcase_add_test (tc, test_eq);
  tcase_add_test (tc, test_lt);
  tcase_add_test (tc, test_lte);
  tcase_add_test (tc, test_gt);
  tcase_add_test (tc, test_gte);
  tcase_add_test (tc, test_ne);
  suite_add_tcase (s, tc);

  tc = tcase_create ("Class");
  tcase_add_test (tc, test_empty_class);
  tcase_add_test (tc, test_empty_param_class);
  tcase_add_test (tc, test_empty_param_comma_class);
  tcase_add_test (tc, test_class_statement);
  tcase_add_test (tc, test_1param_class);
  tcase_add_test (tc, test_default_param_class);
  tcase_add_test (tc, test_param_trail_comma_class);
  suite_add_tcase (s, tc);

  tc = tcase_create ("Resource");
  tcase_add_test (tc, test_rsc_noparams);
  tcase_add_test (tc, test_rsc_param);
  tcase_add_test (tc, test_rsc_2param);
  tcase_add_test (tc, test_rsc_2param_comma);
  tcase_add_test (tc, test_rsc_2decls);
  tcase_add_test (tc, test_rsc_2decls_endsemi);
  tcase_add_test (tc, test_rsc_2decl_empty);
  suite_add_tcase (s, tc);

  return s;
}
