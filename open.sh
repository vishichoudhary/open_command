#!/bin/bash
function main_function(){
	input=$1
	IFS='.'
	read -a input <<< $input
	name=${input[0]}
	ext=${input[1]}
	IFS=$OIFS
	if [ "$ext" == '' ]
		then
			echo "Error: extension missing:"
			return 
		fi
}
function enter_function(){
	echo "in progress"
}
if [ "$1" == "121" ]
	then
		enter_function "$1"
	else
		if [ "$1" == '' ]
			then
				echo "Error: what to open?: 121 for updating database;"
			else
				main_function "$1"
		fi
fi
