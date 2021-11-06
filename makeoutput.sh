#!/bin/bash
for i in {1..100}
do
	read a b c d e <<END
	$(date)
END
	echo $a $b $c $e $d
	sleep 1
done 
