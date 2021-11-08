trap 'echo just got int; exit' INT # INT - name of the interrupt signal I.E. ctrl-c
trap "echo you cannot quit now" QUIT # QUIT - name of the quit signal I.E. ctrl-/
cd / 
while
true
do
	echo looping
	du -m * 2>/dev/null
	echo sleeping
	sleep 5
done
