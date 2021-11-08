#!/bin/bash
function usage {
	echo Options are -r -h -b --branch -- version --help
	exit 1
}

function handleopts {
	OPTS=`getopt -o r:hb:: -l branch:: -l help -l version -- "$@"`
	if [ $? != 0 ]
	then 
		echo ERROR parsing arguments >&2
		exit 1
	fi 
	eval set -- "$OPTS" # reset what getopt processes, we have to invoke this with eval
	while true ; do
		# sleep 2 # debugging
		case "$1" in
			-r ) rightway=$2
				shift 2;; # shift our arguments two places $3->$1, removes $1 and $2
			--version ) echo "Version 1.2";
				exit 0;;
			-h | --help ) usage;
				shift ;;
			-b | --branch )
				case "$2" in
					"") branchname="default" ; shift 2;;
					*) branchname="$2" ; shift 2;;
				esac ;;
			--) shift; break;;
		esac
	done
	if [ "$#" -ne 0 ]
	then
		echo Error extra command line arts "$@"
		usage
	fi
}

rightway=no
handleopts $@
echo rightway = $rightway
echo branchname = $branchname
