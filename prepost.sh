p="/usr/local/bin/hotdog.sh"
echo whole path is $p
echo Remove prefix ${p#/*local/} # pattern matches on everything staring through local/ and remove it
echo Remove suffix ${p%.sh} # pattern matches .sh and removes it from the suffix
cmd=${p#*/bin/} # remove the prefix up to bin/
cmd2=${cmd%.sh} # remove the remaining .sh from the suffix
echo the command without .sh is $cmd2
