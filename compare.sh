#!/bin/bash
x=01
y=1
echo compareing $x and $y
if
	[ $x == $y ]
then
	echo ==
else
	echo !=
fi

if 
	[ $x -eq $y ]
then 
	echo eq
else
	echo ne
fi

if
	((x==y))
then
	echo '(())' ==
else
	echo not '(())' ==
fi

