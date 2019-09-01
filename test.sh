#!/bin/bash

source colors.sh

# Error checking
if [ $# -lt 2 ] || [ -z $1 ]
then
	echo "usage: ./test.sh cycle1,cycle2 bytecode1 bytecode2 ..."
	exit 0
fi
if ! [[ "$1" =~ ^([0-9],?)+$ ]]
then
	printerr "Expected a comma-separated list of positive numbers for first argument."
	exit 1
fi
cycles=$(echo $1 | tr "," " ")
if ! [ -f zaz.info ]
then
	printerr "Missing file: zaz.info"
	exit 1
fi
if ! [ -f user.info ]
then
	printerr "Missing file: user.info"
	exit 1
fi

# Print test header
printf "Running test"
for bytecode in "${@:2}"
do
	printf " \"$bytecode\""
done
printf " ... "

# Creation of test champion(s)
i=1
champs=""
for bytecode in "${@:2}"
do
	sh makeChampion.sh "$bytecode" > /tmp/champ$i.cor
	if [ $? -ne 0 ]
	then
		echo
		printerr "Champion creation failed."
		exit 1
	fi
	champs="$champs /tmp/champ$i.cor"
	let "i++"
done

# Test
for cycle in $cycles
do
	# Generate dump files
	sh dump.sh zaz.info "$champs" $cycle > /tmp/cor_expected_dump
	if [ $? -ne 0 ]
	then
		echo
		printerr "Failed to dump zaz's corewar."
		exit 1
	fi
	sh dump.sh user.info "$champs" $cycle > /tmp/cor_actual_dump
	if [ $? -ne 0 ]
	then
		echo
		printerr "Failed to dump user's corewar."
		exit 1
	fi

	# Compare
	diff=$(diff /tmp/cor_expected_dump /tmp/cor_actual_dump)
	if [ ! -z "$diff" ]
	then
		printf "${c_red}KO (cycle $cycle)${c_off}\n"
		exit 1
	fi
done
printf "${c_green}OK${c_off}\n"
exit 0
