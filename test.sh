#!/bin/bash

source colors.sh
source info.sh

# Extract cycles (if applicable)
if [ "$1" = "-c" ]
then
	if ! [[ "$2" =~ ^([0-9],?)+$ ]]
	then
		printerr "Expected a comma-separated list of positive numbers following -c."
		exit 1
	fi
	cycles=$(echo $2 | tr "," " ")
	shift 2
else
	cycles=""
fi

# Error checking
if [ $# -eq 0 ]
then
	echo "usage: $0 [-c cycle1,cycle2,...] bytecode1 bytecode2 ..."
	exit 0
fi
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
for bytecode in "${@:1}"
do
	printf " \"$bytecode\""
done
printf " ... "

# Creation of test champion(s)
i=1
champs=""
for bytecode in "${@:1}"
do
	./makeChampion.sh "$bytecode" "test_champ_$i" > /tmp/champ$i.cor
	if [ $? -ne 0 ]
	then
		echo
		printerr "Champion creation failed."
		exit 1
	fi
	champs="$champs /tmp/champ$i.cor"
	let "i++"
done

# Test the diff at the end of various cycles
function cycle_dump_test
{
	for cycle in $cycles
	do
		# Generate dump files
		sh dump.sh zaz.info $cycle "$champs" > /tmp/cor_expected_dump
		if [ $? -ne 0 ]
		then
			echo
			printerr "Failed to dump zaz's corewar."
			exit 1
		fi
		sh dump.sh user.info $cycle "$champs" > /tmp/cor_actual_dump
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
			return 1
		fi
	done
	printf "${c_green}OK${c_off}\n"
	return 0
}

# Test the content of the victory message
function victory_message_test
{
	# Obtain the expected victory message
	load_corewar_info_file zaz.info
	if [ $? -ne 0 ] ; then
		exit 1
	fi
	output=$($corewar $champs | tail -1)
	status=$?
	if [ $status -ne 0 ]
	then
		echo
		printerr "zaz's corewar returned exit status $status."
		exit 1
	fi

	# Test against formatted strings until we find the victor
	for i in 1 2 3 4 5
	do
		if [ $i -eq 5 ]
		then
			echo
			printerr "Could not parse zaz's victory message."
			exit 1
		fi
		msg=$(echo "$victory_format" | sed "s/__NUM__/$i/g" | sed "s/__NAME__/test_champ_$i/g")
		if [ "$output" = "$msg" ]
		then
			break
		fi
	done

	# Obtain the user's victory message
	load_corewar_info_file user.info
	if [ $? -ne 0 ] ; then
		exit 1
	fi
	output=$($corewar $champs | tail -1)
	if [ $status -ne 0 ]
	then
		echo
		printerr "corewar returned exit status $status."
		exit 1
	fi

	# Compare
	msg=$(echo "$victory_format" | sed "s/__NUM__/$i/g" | sed "s/__NAME__/test_champ_$i/g")
	if [ "$output" = "$msg" ]
	then
		printf "${c_green}OK${c_off}\n"
		return 0
	fi
	printf "${c_red}KO${c_off}\n"
	return 1
}

# Test
if [ -z "$cycles" ]
then
	victory_message_test
else
	cycle_dump_test
fi
exit $?
