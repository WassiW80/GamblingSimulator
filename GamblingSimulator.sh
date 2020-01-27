#!/bin/bash -x
echo "Welcome to Gambling Simulator."
stake=100
bet=1
while [ $stake -lt 150 ] && [ $stake -gt 50 ]
do
	if [ $((RANDOM%2)) -eq 0 ]
	then
		stake=$(($stake-$bet))
	else
		stake=$(($stake+$bet))
	fi
done
