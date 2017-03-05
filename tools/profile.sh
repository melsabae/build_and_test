#!/bin/sh

pushd $(realpath $(dirname $0))

limit=0

if [ $# -eq 0 ]; then
	limit=100;
else
	limit=$1
fi

echo $limit

for i in $(seq 1 $limit); do
	../bin/the_program_dbg 2>&1 > /dev/null;
	mv gmon.out gmon.out.$i ;
done

gprof -s ../bin/the_program_dbg gmon.out.*
gprof -lbp ../bin/the_program_dbg gmon.sum

popd
