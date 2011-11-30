for f in "$srcdir/samples/"*.pp; do
    "../src/tinin" < "$f" || exit $?
done
