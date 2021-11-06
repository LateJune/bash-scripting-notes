#!/bin/bash
x=abc
abc="Start of Alphabet"
echo x is $x
echo abc is $abc
echo '${!x}' is ${!x} # this prints out the value of the variable whos name is x
