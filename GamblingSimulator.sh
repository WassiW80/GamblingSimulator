#!/bin/bash 
echo "Welcome to Gambling Simulator."
#CONSTANT
BET=1
WIN_LIMIT=150
LOOSE_LIMIT=50
NUMBER_OF_DAYS=20
#variables
stake=100
winningAmount=0
loosingAmount=0
currentAmount=0
wonCount=0
lostCount=0
declare -A storingLuckyUnLucky
#function for gambling
function gamble() {
	for((i=1;i<=$NUMBER_OF_DAYS;i++))
	do
		while [ $stake -lt $WIN_LIMIT ] && [ $stake -gt $LOOSE_LIMIT ]
		do
			if [ $((RANDOM%2)) -eq 0 ]
			then
				stake=$(($stake-$BET))
			else
				stake=$(($stake+$BET))
			fi
		done
		countingWonOrLostDay
	done
}
#function for Counting won and or lost days
function countingWonOrLostDay() {
	if [ $stake -ge $WIN_LIMIT ]
	then
		winningAmount=$(($winningAmount+50))
		currentAmount=$(($currentAmount+50))
		stake=100
		(( wonCount++ ))
	else
		loosingAmount=$(($loosingAmount+50))
		currentAmount=$(($currentAmount-50))
		stake=100
		(( lostCount++ ))
	fi
	storingLuckyUnLucky[$i]=$currentAmount
}
#function for checking winning or loosing amount after 20 day
function checkingWinOrLooseAmountAfter20Day() {
	gamble
	if [ $winningAmount -gt $loosingAmount ]
	then
		echo "You won by $(($winningAmount-$loosingAmount)) in 20 day"
	elif [ $winningAmount -eq $loosingAmount ]
	then
		echo "You neither won nor loose"
	else
		echo "You loose by $(($loosingAmount-$winningAmount)) in 20 day"
	fi
	echo "No of days Won : $wonCount"
	echo "No of days Lost : $lostCount"
	echo "Amount Won : $(($wonCount*50)) "
	echo "Amount Lost : $(($lostCount*50)) "

}
echo ${!storingLuckyUnLucky[@]}
echo ${storingLuckyUnLucky[@]}


function checkingLuckyUnluckyDay() {
	for i in ${!storingLuckyUnLucky[@]}
	do
		echo "$i ${storingLuckyUnLucky[$i]}"
	done | sort -k2 $1 | head -1
}


while [ $currentAmount -ge 0 ]
do
	checkingWinOrLooseAmountAfter20Day
	echo "Luckiest day"
	checkingLuckyUnluckyDay -rn
	echo "Unluckiest day"
	checkingLuckyUnluckyDay -n
	if [ ${storingLuckyUnLucky[20]} -ge 0 ]
	then
		read -p "Do want to gamble for next month to? (y/n) " answer
		if [ answer=="y" ]
		then
			winningAmount=0
			loosingAmount=0
			currentAmount=0
			wonCount=0
			lostCount=0
		else
			break
		fi
	fi
done
