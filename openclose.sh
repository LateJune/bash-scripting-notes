#!/bin/bash
exec 19<data_file
echo PID of running process:$$
lsof -p $$
#exec 19<data_file
cat 0<&19
exec 7>&1 # save stdout in 7
exec 1>&- # close stdout
lsof -f $$
cat # no stdout now
exec 2>&7 # copy 7 back to stdout
cat 
