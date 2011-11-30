TESTS = check_tinin all.sh

check_PROGRAMS = check_tinin
check_tinin_SOURCES = check_tinin.c check_parse.c
check_tinin_CFLAGS = @CHECK_CFLAGS@
check_tinin_LDADD = $(top_builddir)/src/libtinin.a @CHECK_LIBS@

dist_check_SCRIPTS = all.sh
dist_check_DATA = samples
