#!/bin/bash
i=5
while [ $i -ne 0 ]
	do
   		printf "[sudo] password for $USER:" && read -s passwd
    	echo ""
    	sudo -k -S ls <<< $passwd > /dev/null 2>&1
    	i=$?
    	if [ $i -ne 0 ]
    	then
        	sleep 1
        	echo "[sudo], try again."
    	fi
	done
function check_db_tb(){
	main="mysql -u root --password=$passwd -e"
	$main "create database if not exists data_open;"
	$main "use data_open ; create table if not exists data_open_table (
			ext_name varchar(50),
			first_app varchar(50),
			second_app varchar(50),
			third_app varchar(50),
			fourth_app varchar(50),
			fifth_app varchar(50),
			primary key(ext_name)
			);"
}
check_db_tb
echo "Enter the command for app name:"
read app_name
echo "Enter the extension it will cover, without '.' character like mp3 etc. :"
i="y" 
while [ "$i" == 'y' ]
	do
		read ext_name
		echo "Want to enter more extension (y/n):"
		read i
	done

