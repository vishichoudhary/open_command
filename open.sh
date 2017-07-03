#!/bin/bash
printf "Enter password for your mysql root account:"
read passwd
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
		else
			./fetch_script.sh "$1" "$ext" "$passwd"
	fi
}
function enter_function(){
	./enter_script.sh "$passwd"
}
main="mysql -u root --password=$passwd -e"
function check_db_tb(){
	$main "create database if not exists data_open;"
	$main "use data_open; create table if not exists data_open_table (
			ext_name varchar(50),
			app1 varchar(50),
			app2 varchar(50),
			app3 varchar(50),
			app4 varchar(50),
			app5 varchar(50),
			size int ,
			primary key(ext_name)
			);"
}
$main "use data_open;" >> /dev/null 2>&1
if [ $? -eq 1 ]
	then
		check_db_tb
	fi
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
