#!/bin/bash

unset x
a=${x:-Hotdog} # give us the value but not change x
echo a is $a
echo x is $x

a=${x:=Hotdog} # changes x and returns the value
echo a is $a
echo x is $x

unset x
${x:?} # should be and error and return the script
echo will not get here
