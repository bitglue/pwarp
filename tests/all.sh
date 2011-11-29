parser=$1

for f in "samples/"*.pp; do
    "../src/tinin" < "$f" || exit $?
done
