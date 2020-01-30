#!/bin/bash -x
echo "Welcome to Gambling Simulator."
#CONSTANT
STAKE=100
BET=1
WIN_LIMIT=150
LOOSE_LIMIT=50
NUMBER_OF_DAYS=20
#variables
winningAmount=0
loosingAmount=0
wonCount=0
lostCount=0
#function for gambling
function gamble() {
	for((i=0;i<$NUMBER_OF_DAYS;i++))
	do
		while [ $STAKE -lt $WIN_LIMIT ] && [ $STAKE -gt $LOOSE_LIMIT ]
		do
			if [ $((RANDOM%2)) -eq 0 ]
			then
				STAKE=$(($STAKE-$BET))
			else
				STAKE=$(($STAKE+$BET))
			fi
		done
		countingWonOrLostDay
	done
}
#function for Counting won and or lost days
function countingWonOrLostDay() {
	if [ $STAKE -ge $WIN_LIMIT ]
	then
		winningAmount=$(($winningAmount+50))
		STAKE=100
		(( wonCount++ ))
	else
		loosingAmount=$(($loosingAmount+50))
		STAKE=100
		(( lostCount++ ))
	fi
}
#function for checking winning or loosing amount after 20 day
function checkingWinOrLooseAmountAfter20Day() {
	if [ $winningAmount -gt $loosingAmount ]
	then
		echo "You won by $(($winningAmount-$loosingAmount)) in 20 day"
	elif [ $winningAmount -eq $loosingAmount ]
	then
		echo "You neither won nor loose"
	else
		echo "You loose by $(($loosingAmount-$winningAmount)) in 20 day"
	fi
}

gamble
checkingWinOrLooseAmountAfter20Day
echo "No of days Won : $wonCount"
echo "No of days Lost : $lostCount"
echo "Amount Won : $(($wonCount*50)) "
echo "Amount Lost : $(($lostCount*50)) "
