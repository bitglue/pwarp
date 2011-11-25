parser=$1
samples=$2

for f in "$samples/"*.pp; do
    "$parser" < "$f" || exit $?
done
