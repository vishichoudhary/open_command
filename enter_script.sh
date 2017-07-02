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
function check_db(){
	echo "In progress"
}
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

