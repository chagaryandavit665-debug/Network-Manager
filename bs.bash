#!/bin/bash
echo '---------------------------'
echo 'Network settings manager'
echo 'Enter the option you want to change'
echo '---------------------------'
echo '0.   - EXIT from the script'
echo '1.   - Add new IP address in your device'
echo '2.   - Delete IP address from your device'
echo '3.   - Add route to your network(use (4) before using this option'
echo '4.   - Delete IP route'
echo '5.   - Information '
echo '---------------------------'
opts=''
while [[ $opts != 0 ]];do
	read opts
	if [[ $opts =~ ^[0-9]+$ ]];then
		if (( $opts == 0 ));then
			echo '---------------------------'
			echo 'You are exited from the script'
			echo '---------------------------'
			break
		elif (( $opts == 1 )); then
			sleep 1
			echo '---------------------------'
			echo 'Please enter an IP address you want to add:'
			read ipaddress
			echo '---------------------------'
			echo 'Enter the device when you want add your new ip address'
			echo '---------------------------'
			read dev
			echo '---------------------------'
			if [[ $ipaddress =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}/([0-9]|[1-2][0-9]|3[0-2])$ ]];then
				sleep 2
				ip a add $ipaddress dev $dev
				echo "IP address ${ipaddress} added into device ${dev}"
				echo '---------------------------'
				ip a show dev $dev
				echo '---------------------------'
			else echo "Something is writen wrong Please try again"
			fi
		elif (( $opts == 2 )); then
			sleep 1 
			echo '---------------------------'
			echo 'Please enter an IP address you want delete:'
			read ipaddress
			echo '---------------------------'	
			echo 'Enter the device from where you want to delete this IP address'
			echo '---------------------------'
			read dev
			echo '---------------------------'
			sleep 2
			if [[ $ipaddress =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}/([0-9]|[1-2][0-9]|3[0-2])$ ]] ;then

				ip a del $ipaddress dev $dev
				echo "IP address $ipaddress removed from device $dev"
				echo '---------------------------'
				ip a show dev $dev
				echo '---------------------------'
			else echo "Something is writen wrong Please try again"
			fi
		elif (( $opts == 3 )); then
			sleep 1 
			echo '---------------------------'
			echo 'Please enter an PUBLIC IP address(router interface IP) you want to add:'
			read ipaddress
			echo '---------------------------'	
			echo 'Enter the device where you want to add this IP address to routing'
			echo '---------------------------'
			read dev
			echo '---------------------------'
			sleep 2
			if [[ $ipaddress =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] ;then

				ip route add default via $ipaddress dev $dev
				echo "$ipaddress is your routing IP address to device $dev"
				echo '---------------------------'
				ip route show | grep default
				echo '---------------------------'
			else echo "Something is writen wrong Please try again"
			fi
		elif (( $opts == 4 )); then
			sleep 1 
			echo '---------------------------'
			echo 'Please enter an PUBLIC IP address(router interface IP) you want to delete:'
			read ipaddress
			echo '---------------------------'	
			echo 'Enter the device from where you want to remove this IP address to routing'
			echo '---------------------------'
			read dev
			echo '---------------------------'
			sleep 2
			if [[ $ipaddress =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]] ;then

				ip route del default via $ipaddress dev $dev
				echo "$ipaddress removed from your routing IP addresses of device $dev"
				echo '---------------------------'
				ip route show | grep default
				echo '---------------------------'
			else echo "Something is writen wrong Please try again"
			fi
		elif (( $opts == 5 ));then
			echo '---------------------------'
			echo 'About device nets'
			echo '---------------------------'
			ip a
			echo '---------------------------'
			echo 'About net routing'
			echo '---------------------------'
			ip route show
			echo '---------------------------'
			echo '----------------------------'
			echo '0.   - EXIT from the script'
			echo '1.   - Add new IP address in your device'
			echo '2.   - Delete IP address from your device'
			echo '3.   - Add route to your network(use (4) before using this option'
			echo '4.   - Delete IP route'
			echo '5.   - Information '
			echo '----------------------------'
		else echo 'Use only NUMBERS IN TOP!!!'
		fi
	else echo 'Use only NUMBERS IN TOP!!!'
	fi
done
