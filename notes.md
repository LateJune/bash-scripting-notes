# Bash Linkedin Learning Notes

## Pre example notes and refresher

- no space before or after equal sign
- If a variable has spaces make sure is quoted

---
### Variables
Created when assigning a value or declared 
- example of this is using the *export* command
- Remove variables with *unset*
- Reference created variables with $ sign 

Shell keeps varaibles in 2 different areas

Shell script to get a copy of a shell variable, it needs to be exported
- *export mynewvar* or *declare -x mynewvar*

You can export and assign in the same statement
- *export var2="var2 value"*


### Functions basics
- *export -f myfunc* will export the new function myfunc 

Typing just export will print which varibales are part of the shell's envirnment -- those exported


### Grouping
Bash functions use braces and can modify variables of the shell that calls the function

```sh
a=1
(
a=2
)
echo $a
# prints 1
```

```sh
a=1
{
a=2
}
echo $a
# prints 2
```
---
### Bash builtins 

Get a list of Bash builtins with the *enable* command

Prefers builtins, keywords, aliases, and functions over commands in the filesystem 


### Echo command

Built into bash and doesnt start a new process
- *-n* dont print a trailing newline
- *-e* enable backslash escaped characters like \n and \t
- *-E* disable backslashed escaped characters in case they were disabled by default

ls * would list contents of directoryies
- echo * would show file and directory names

Use file redirection techniques to send thte output to other files such as stderr:
- *echo 'warning will robinson!' >&2*
	- send output to stderr

### Local Variables and Typeset

Variables can be created in a function that will not be available outside of it

The *typeset* command makes variables local, ca provide a type, or provide formatting
- *typeset -i x*
	- x must be an integer

Arithmetic is father for fariables defined to be integers

Let allows for convenient arithmetic
- *let x++; let y=x**2; let x=x*3; let x*=5; ...*


### Declare command

*declare -l* uppercase values in the variable are converted to lowercase

*delcare -u* lowercase values in the variable are converted to uppercase

*delcare -r* variable is made read only

*delcare -a MyArray* will make MyArrary an index array

*delcare -A MyArrary2* will make MyArray2 an associative array, (dictionary or a hash)



### Read commmand

read a line into a variable or multiple variables
- *read a b* - reads first word into a and the rest into b

Convenient for a while loop


### While loop

```sh
while
	command list 1
do
	command list
done
# loops while command list 1 succeeds
```

```sh
while
	((x<10))
do
	echo loop $x; date >data.$x
	((x=x+1))
done
```

```sh
while
	read a b
do
	echo a is $a b is $b
done <data_file
```

```sh
ls -l | while
	read a b c d
	do 
		echo owner is $c
	done
```

---
### For loops

```sh
for <var> in <list>
do
	command list
done
```

```sh
for i in dog cat elephant
do 
	echo i is $i
done 

```


#### Seq command
- seq 1 5
	- print 1 2 3 4 5
- for num in `seq 1 5`
	- loops over 1 2 3 4 5
- Generate sequences with {A..Z}, {1..10}

Alernative for the backticks, somewhat more readable


#### For loops cont.
```sh
for d in $(<data_file)
# loops over space/newline
# separated data in data_file
```

This is essentially saying cat the data file 

```sh
for j in *.c
# making a list with file globbing in the current directory with ext .c
```

```sh
for f in $(find . -name *.c)
# using a command to generate a list
```
Much like we have in the backticks above, this is taking a command to generate a list


---
## Bash functions

### Function

Give a name to a sequence of statements that will execute within the shell, not a new process

```sh
function name {
	function body
}

function printhello {
	echo Hello
}

printhello
# shell memorizies function like a new command
```

Exit Command
#### The Return & Exit command Command

When there are no more statements or when a return statement is executed

```sh
function myfunc {
	echo starting
	return
	echo this will not be executed
}
```

Functions produce results by writing output like commands do

hvar=$(printhello)
- Catch a result into a variable

Exit Command
- Exit <VALUE> sets the exit status represented by `$?` to <VALUE>
- Exit terminates the shell process
- Exit in a function terminates the whole shell program not just the function


## Pipes and Redirection
0 => stdin

1 => stdout

2 => stderr

### Run command
\> stdout

< stdin `*INPUT FILE RIGHTHAND SIDE*`

2> stderr

### Related Syntax & Other cases
&> Output both stdout and stderr, file is created and/or rewritten

### Pipes
comand | command2 `*Pipe stdout as stdin*`

### Others
command 2>&1 | command2 `*Redirect stdout and stderr through pipe*`

command |& command2 `*Same as above, shorthand*`

command >> file `*Append*`

command &>> file `*stdout and stderr appended to file*`

### Here Documents: <<

Here documents are a way to embed input for std input inside of a script

They avoid having to create a new file just to hold some input values

```sh
sort <<END
cherry
banana
apple
orange
END
```
---
## Open and Close file Descriptors
exec N< myfile
- Opens file descriptor N for reading from file myfile

exec N> myfile
- open file descriptor N for writing to myfile

exec <> myfile
- opens file descriptor N for reading and writing with myfile

exec N>&- or exec N<&-
- Closes file descriptor N

### Handy Command
Use `lsof` to see what file descriptors for a process are open

```sh
exec 2>/tmp/myfile7
# no spaces between '2>/'

lsof -p $$
# $$ is shell's PID
```

---
## Control Flow

### Case Statement

```sh
case expression in 
pattern 1 )
	command list ;;
pattern 2 )
	command list ;;
	...
esac
```

Patterns are not regular expressions, they are logic checked in sequence

```sh
case $ans in
yes|YES|y|Y|y.x ) echo "Will do";;
n*|N* ) echo "Will NOT do!";;
*) echo "Oops";;
esac
```

- `*` is a wildcard, where the default case is the last line in the case statement
- `.` is not match any case. This is not regex
- `|` logical or

Order matters, commands must be separated by spaces

### If Then Else Statement 

```sh
if
command list 
then 
command list
else
command list
fi
```

```sh
if 
grep -q important myfile
then
	echo myfile has important stuff
else
	echo myfile does not have important stuff
fi
```

### Tests in Bash

Built int test is used to check various conditions and set the return code with the result

Loops and conditionals often use the result of test

Alternative to test is `[[ ]]` or `(( ))`

```sh
if 
test -f afile

if [[ -f bfile ]]

if 
test $x -gt 5

```

### Test Operators

```
[[ ex1 -eq ex2 ]] [[ ex1 -ne ex2 ]]
[[ ex1 -lt ex2 ]] [[ ex1 -gt ex2 ]]
[[ ex1 -le ex2 ]] [[ ex1 -ge ex2 ]]
```
```
((ex1 == ex2)) ((ex1 != ex2))
((ex1 < ex2))  ((ex1 > ex2))
((ex1 <= ex2)) ((ex1 >= ex2))
((ex1 && ex2)) ((ex1 || ex2))
```

### More Tests

test -d X
- success if X is a directory

test -f X
- success if X is a regular file

test -s X
- success if X exists and is not empty

test -s X
- success if you have x with permission on X

test -s X
- success if  you have w with permission on X

test -s X
- success if you have xrwith permission on X

---
## Arithmetic Operators

Use (( )) or with let

```sh
id++ id-- ++id --id
!	~	**	*	/	%	+	-	
<<	>>	&	^	|	&&	||
expr?expr:expr # if?true:false
= *= /= %=  += <<= >>= &= ^= |=
expr1 , expr2
```

### Using Operators
```sh
n=5
((n++))
if
((n>4 || n == 0))

```
```sh
((n=2**3 + 5))
echo n = $n
((y=n^4)) # Exclusive or operator ^
echo y = $y
```

## Filters
Read from std in and writes to stdout

filters can be used in pipes

filters provide the powerful means of combining input and output of a sequence of commands to get the desired output

### Head and tail
head prints the first n lines of a file or stdin

tails prints the last n lines of a file or stdin

```sh
ls -l | head -5 
ls -l | tail -7
ls -l | head -10 | head -5 
```

```sh
wc -l #prints the number of lines
ls | wc - prints number of lines in a directory
```

```
tail -n2 output -f output 
```
`-f` for follow the file as new output is generated

---
## Note: *Run something in the background using the ampersand &*
```sh
./makeoutput.sh >output &
[1] 12345 #PID 
user@machine$ 
```

---
## Sed Command

Applies it editing to all lines in the input

With `-i` option, change a file instead of echoing the modified file to stdout

### Sed subtitute

`sed 's/old/new' myfile` 

Substitute  the first occruance of old on each line fo new in the file myfile and display the results on stdout

out is a pattern and can be a regular expresssion 

To substitute all occruances use the `g` option

`sed 's/old/new' myfile` 

```sh
sed 's/@home/@domicle'; s/truck/lorrie # semi colon means we are going to run another command
sed -e 's/[xX]/Y' -e 's/b.*n/blue/' # similarly the -e option provides this
sed -f sedscript -n sed4 # -n only echo out lines you tell it to echo out sed4 is the input file
date | sed 's/J/j' # piping in via stdout as std in, single subtitute
sed '1,5p' # print the first 5 lines, but also print all the lines without -n option
```

Sed script example

```sh
sed '/alpha/s/beta/gamma' # if the line has alpha on it, substitute beta for gamma
sed '/apple/,/orange/d' # if the line has apple, then go to a line with orange and delete the whole sequence of lines between the two
sed '/important/!s/print/throw_away/' # if the line has important, dont subtitute change the word print to throw_away. IE do the command on lines that dont match
```
---
## Awk command

Pattern matching language

Interpreted programming langauge that works as a filter 

Good for report writing

Hany for short "algorithmic" kinds of processing

Processes line at a time like sed

breaks each line into fields, $1, $2, etc

Fields are delimited by the values in the variable FS, normally white space 

`$0` is the entire line 

```sh
user@machine$ ps -ef | awk '/pts/||$8~/35/{printf("%5d %5d %s\n", $4, $5, $14)}'
# if the line has pts or field #8 matches the string 35 then print 5 decimal digit number, space, 5 decimal digit number, space, a string, and a newline where the corresponding values are what are in the feilds denoted by $# I.E. $4 $5 $14
```

```sh
#!/bin/awk -f
{szsum+=$9
rsssum+=$8}
END{printf("RSS\tSZ\n%d\t%d\n",rsssum,szssum)}

user@machine$ ps -ly | ./awk1
RSS		SZ
507124	2796780
```

```sh
{for (i=1; i<NF;;i++) # NF stands for number of feilds on current line
	words[$i]++} # count number of occurances of every word in the file
END{printf("is=%d,ls=%d,the=%d\n",words["is"],words["ls"],words["the"])}

user@machine$ man ls | col -b awk -f words.awk
is=56,ls=14,the=130
# col -b strips formatting and colors that may be printed out
```

## Script Parameters and {}

Parameters to a shell program $1, $2, ...

Called positional parameters

To reference multidigit use {}, I.E. ${10}

`$0` is the path to the program itself

Shift moves $2 into $2, $3 into $2, etc.

It is sometimes handyt or require to use {} with named variable

`echo ${abc}DEF`

```sh
x=abc
abc=def
echo ${!x} #prints def, indirections
```

```sh
${variable <ORP> value}
x=${var:-Hotdog}
```

`:-` If var is unset/null, return value; otherwise return value of var

`:=` if var unset/null var is assigned the value and returned

`:?` Displays an error and exist script if var unset/net

`:+` If var unset/null return nothing; otherise return value

### Colon ':' by itself and other operators

```sh
${var:offset} # value of var starting at offset

${var:offset:len} # Value of var starting at offset up to length len
```
```sh
${#var} # length of var

${var#pre} # Remove matching prefix

${var%post} # Remote suffix
```
prexif and postfix are hand for processing filenames/paths

# Advanced Bash

## Coprocesses

A corprocess is a background process where your shell gets file descriptors for the process's stdin and stdout 
- implemented with a pipe

### Using Coprocesses
We need a script that is a filter

```sh
#!/bin/bash
while
	read line
do
	echo $line | tr "ABC" "abc" # translate command 1:1 conversion
done
```

Running a coprocess
```sh
coproc ./mycoproc.sh
[1] 12345
user@machine$

echo BANANA >&"${COPROC[1]}"
cat <&"${COPROC[0]}"
```
Essentially is a daemon running, can send data and read data from it

Shell gets a new *array* called `COPROC` 
- COPROC[1] is the file descriptor to redirect stdout
- COPROC[0] is the file descriptor to redirect stdin

In a way acts like an anonymous coprocess. Array name is automatically defined as `COPROC`

Can give coproc a name

```sh
coproc my { ./mycoproc.sh; }
[1] 12345
user@machine$

echo BANANA >&"${my[1]}"
cat <&"${my[0]}"
```

## Note 
bash, zsh, ksh, dash, etc. behave subtilely different from one another.

The above examples worked in a bash environment, but caused file descriptor errors when attempting to execute in a zsh environment. Differences in POSIX/standard implementation? Not sure.

### Killing backgrounded processes
```sh
user@machine$ jobs
[1]  + running ./myfile.sh

user@machine$ kill %1
[1]  + 12345 terminated
```

---
## Debugging Scripts 

bash prog
- run bash program; dont need execute permissions

bash -x prog
- echo commands after processing; can also do set -x or set +x inside of script

bash -n prog
- Do not execute commands, check for syntax errors only

set -u
- reports usage of an unset variable

lots of echo statements

tee command
- `cmd | tee log.file | ...`


## Trap: Using Signals

The bash track command is for signal handling
- Change behavior of signals within a script
- Ignore singals during critial sections in a script
- Allow the script to die gracefully
- Perform some operations when a signal is recieved 

```sh
user@machine$ cat trapint
trap 'echo just got int; exit' INT # INT - name of the interrupt signal I.E. ctrl-c
trap "echo you cannot quit now" QUIT # QUIT - name of the quit signal I.E. ctrl-\
cd / 
while
true
do
	echo looping
	du -m * 2>/dev/null
	echo sleeping
	sleep 5
done
```

`kill -l` lists all of the signals available

## Eval command

Use to have bash evaluate a string

Makes a "second pass" over the string and then runs it as a command

runs "data" in effect, so be careful about providing a way for arbitrary code execution

```sh
c="ls | tr 'a' 'A'"; $c # this does not work
eval $c # works 
```

## Getopt Command
get opt is used to process command line options

Option names, long and single letter, are specified and whether they take an argument 

```sh
opts=`getopt -o a: -l apple -- "$@"`
```

- Option a, log form -apple, takes an argument 
- getopt prints the parse arguments 
- `$@` standard bash notiation
	- bash variable for lost of paratemters passed
- `--` used to mark end of processing 

Typical to loop through the argiments using a case statment to match and handle them