#!/bin/bash -x
echo "Welcome to Gambling Simulator."
stake=100
bet=1
winningAmount=0
loosingAmount=0
for((i=0;i<20;i++))
do
	while [ $stake -lt 150 ] && [ $stake -gt 50 ]
	do
		if [ $((RANDOM%2)) -eq 0 ]
		then
			stake=$(($stake-$bet))
		else
			stake=$(($stake+$bet))
		fi
	done
	if [ $stake -ge 150 ]
	then
		winningAmount=$(($winningAmount+50))
		stake=100
	else
		loosingAmount=$(($loosingAmount+50))
		stake=100
	fi
done

if [ $winningAmount -gt $loosingAmount ]
then
	echo "You won by $(($winningAmount-$loosingAmount)) in 20 day"
elif [ $winningAmount -eq $loosingAmount ]
then
	echo "You neither won nor loose"
else
	echo "You loose by $(($loosingAmount-$winningAmount)) in 20 day"
fi


echo $winningAmount
echo $loosingAmount
