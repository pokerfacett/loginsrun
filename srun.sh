#!/bin/bash

usage() {
	printf "Usage: -u <username> -p <password>\n"
}

succeed() {
	echo "login succeed!!"
	exit 0
}

failed() {
	echo "login failed!!"
	exit 1
}

username=""
password=""

while getopts 'u:p:' OPTION
do
	case $OPTION in
	u)	username="$OPTARG"
		;;
	p)	password="$OPTARG"
		;;
	?)	usage
		failed
		;;
	esac
done

if [ -z "$username" ] || [ -z "$password" ]
then
	usage
	failed
else
	result=$(curl http://10.0.0.55:803/include/auth_action.php -d "action=login&username=$username&password=$password&ac_id=1&user_ip=&nas_ip=&user_mac=&save_me=0&ajax=1"|grep -n 'login_ok'|cut -d : -f 1)
fi

if [ '1' == $result ]
then
	succeed
	exit 0
else
	echo "username or password is wrong!!"
fi

