#!/bin/bash
printf "Enter password for your mysql root account:"
read passwd
main="mysql -u root --password=$passwd -e"
function fetch_data(){
	main_1="mysql -u root --password=$passwd -N -e"
	size=`$main_1 "use data_open; select size from data_open_table where ext_name='$1';"`
	if [ -z "$size" ]
		then
			size='0'
		fi
	echo "You have $size apps for this extension :"
	if [ "$size" != '0' ]
		then 
			for i in `seq 1 $size`
				do
					fetched_name=`$main_1 "use data_open; select app$i from data_open_table where ext_name='$1';"`
					echo "$i) $fetched_name "
				done
			echo "Enter your choice like 1 ,2,etc:"
			read choice
			selected_app=`$main_1 "use data_open; select app$choice from data_open_table where ext_name='$1';"`
			echo $selected_app
			$selected_app $2
		fi
}
#echo "Enter the name of extension :"
#read ext_name
ext_name="$2"
fetch_data $ext_name "$1"

