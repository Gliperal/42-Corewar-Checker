#!/bin/sh

source colors.sh

if [ -z $1 ]
then
	echo "usage: ./setup.sh /path/to/corewar/folder"
	exit 1
fi

echo "Making corewar..."
make -C $1 corewar > /dev/null
if [ $? != 0 ]
then
	printerr "Failed to make corewar executable."
	echo "Make sure that a Makefile exists in $1 and that it has the \"corewar\" rule."
	exit 1
elif [ ! -f $1/corewar ]
then
	printerr "Makefile ran but no corewar file was created."
	exit 1
fi
corewar=$1/corewar

echo "Extracting information..."
# Extract victory message
sh makeChampion.sh "" NAME > /tmp/empty.cor
if [ ! -f /tmp/empty.cor ]
then
	printerr "makeChampion.sh failed to create champion."
	exit 1
fi
output=$($corewar /tmp/empty.cor)
status=$?
if [ $status != 0 ]
then
	printf "${c_lred}Failed to run ${c_yellow}$corewar /tmp/empty.cor${c_off}\n"
	printerr "corewar returned exit status $status."
	exit 1
fi
victory_message=$(echo "$output" | grep NAME | tail -1)
if [ -z "$victory_message" ]
then
	printerr "Could not locate victory message."
	echo "Make sure corewar outputs something like \"My Awesome Champion (player 3) won!\""
	exit 1
fi
victory_format=$(echo "$victory_message" | sed 's/1/NUM/1')

# Extract dump format
sh makeChampion.sh "11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF" > /tmp/alphabet.cor
output=$($corewar /tmp/alphabet.cor -dump 1)
status=$?
if [ $status != 0 ]
then
	printf "${c_lred}Failed to run ${c_yellow}$corewar /tmp/alphabet.cor -dump 1${c_off}\n"
	printerr "corewar returned exit status $status."
	exit 1
fi
stripped_output=$(echo "$output" | sed "s/[[:space:]]//g")
dump_start=$(echo "$stripped_output" | grep -Fnm 1 "112233445566778899AABBCCDDEEFF" | tail -1 | cut -f 1 -d ':')
if [ -z $dump_start ]
then
	printerr "Failed to identify dump in output."
	exit 1
fi

output_end=$(echo "$stripped_output" | wc -l)
dump_end=$output_end
while [ $dump_end -ge $dump_start ]
do
	dump=$(echo "$stripped_output" | sed -n "${dump_start},${dump_end}p")
	byte_count=$(echo "$dump" | tr -d '\n' | wc -c)
	if [ $byte_count -le 8192 ] ; then
		break
	fi
	let "dump_end = dump_end - 1"
done
if [ $byte_count -ne 8192 ]
then
	printerr "Could not match dump in output."
	echo "Make sure that MEM_SIZE is 4096 in op.h, that the dump is on contiguous lines containing no other information, and that the only delimiters in the dump zone are whitespace."
	exit 1
fi
if [[ ! $(echo "$dump" | tr -d '\n') =~ ^112233445566778899AABBCCDDEEFF0*$ ]]
then
	printerr "Dump did not match expected output."
	exit 1
fi
let "dump_size = dump_end - dump_start + 1"
let "lines_after_dump = output_end - dump_end"

# Create corewar information file
rm -rf user.info
if [ $? -ne 0 ]
then
	printerr "Unable to modify user.info"
	exit 1
fi
echo "$1path to corewar folder
$dump_sizenumber of lines in dump
$lines_after_dumpnumber of extra lines following dump (if any)
$victory_formatformat of victory message" | column -t -s '' > user.info
if [ ! -f user.info ]
then
	printerr "Failed to write to user.info"
	exit 1
fi

# Output results
printf "${c_green}Setup ran successfully.${c_off}\n"
echo "The following information was obtained about your corewar program. If anything is incorrect, modify user.info accordingly."
cat user.info | sed -e 's/^/	/'
