#include <stdlib.h>
#include <check.h>
#include "suites.h"

START_TEST(test_check)
{
  fail_unless(2==2, "interesting.");
}
END_TEST

Suite *
tinin_suite (void)
{
  Suite *s = suite_create ("Tinin");

  TCase *tc_core = tcase_create ("Core");
  tcase_add_test (tc_core, test_check);
  suite_add_tcase (s, tc_core);

  return s;
}

int
main(void)
{
  int number_failed;
  Suite *s = tinin_suite ();
  SRunner *sr = srunner_create (s);
  srunner_add_suite (sr, parse_suite ());
  srunner_run_all (sr, CK_NORMAL);
  number_failed = srunner_ntests_failed (sr);
  srunner_free (sr);
  return (number_failed == 0) ? EXIT_SUCCESS : EXIT_FAILURE;
}
