export LD_PRELOAD=/home/saba/tmp/testing/lib/criterion/build/libcriterion.so

cd test

for i in $(ls -1); do
	if [ -x $i ] && [ ! -d $i ]; then
		echo running $i
		./$i ;
	fi;
done
