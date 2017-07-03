#!/bin/bash
printf "Enter password for your mysql root account:"
read passwd
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
echo "Enter the command for app name:"
read app_name
echo "Enter the extension it will cover, without '.' character like mp3 etc. :"
function enter_data(){
	main_1="mysql -u root --password=$passwd -N -e"
	$main "use data_open; insert into data_open_table(ext_name,size) values('$1','0');" >> /dev/null 2>&1
	if [ $? -eq 1 ]
		then
			printf "it exist, "
			size=`$main_1 "use data_open; select size from data_open_table where ext_name='$1';"`
			let size=size+1
			$main "use data_open;update data_open_table set size='$size',app$size='$app_name' where ext_name='$1';"	>> /dev/null 2>&1
			echo "updated with values"
		else
			size=`$main_1 "use data_open; select size from data_open_table where ext_name='$1';"`
			let size=size+1
			$main "use data_open; update data_open_table set app$size='$app_name', size='$size' where ext_name='$1';" >> /dev/null 2>&1
			echo "Added to the database :"
	fi
}
i="y" 
while [ "$i" == 'y' ]
	do
		read ext_name
		enter_data $ext_name
		printf "Want to enter more extension (y/n):"
		read i
	done
