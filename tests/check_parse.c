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

Suite *
parse_suite (void)
{
  Suite *s = suite_create ("Parse");

  TCase *tc_core = tcase_create ("Core");
  tcase_add_test (tc_core, test_literal_string);
  tcase_add_test (tc_core, test_literal_int);
  tcase_add_test (tc_core, test_literal_hex_int);
  tcase_add_test (tc_core, test_literal_float);
  tcase_add_test (tc_core, test_literal_float_no_frac);
  tcase_add_test (tc_core, test_neg);
  tcase_add_test (tc_core, test_parens);
  tcase_add_test (tc_core, test_empty_array);
  tcase_add_test (tc_core, test_comma_array);
  tcase_add_test (tc_core, test_array);
  tcase_add_test (tc_core, test_array_trailing_comma);
  tcase_add_test (tc_core, test_empty_hash);
  tcase_add_test (tc_core, test_hash);
  tcase_add_test (tc_core, test_comma_hash);
  tcase_add_test (tc_core, test_hash_trail_comma);
  tcase_add_test (tc_core, test_getitem);
  tcase_add_test (tc_core, test_variable);
  tcase_add_test (tc_core, test_add);
  tcase_add_test (tc_core, test_sub);
  tcase_add_test (tc_core, test_mul);
  tcase_add_test (tc_core, test_div);
  tcase_add_test (tc_core, test_mod);
  tcase_add_test (tc_core, test_true);
  tcase_add_test (tc_core, test_false);
  tcase_add_test (tc_core, test_and);
  tcase_add_test (tc_core, test_or);
  tcase_add_test (tc_core, test_bang);
  tcase_add_test (tc_core, test_in);
  tcase_add_test (tc_core, test_eq);
  tcase_add_test (tc_core, test_lt);
  tcase_add_test (tc_core, test_lte);
  tcase_add_test (tc_core, test_gt);
  tcase_add_test (tc_core, test_gte);
  tcase_add_test (tc_core, test_ne);
  suite_add_tcase (s, tc_core);

  return s;
}
