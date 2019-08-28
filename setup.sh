#!/bin/sh

if [ -z $1 ]
then
	echo "usage: ./setup.sh /path/to/corewar/folder"
	exit 1
fi

echo "Making corewar..."
make -C $1 corewar > /dev/null
if [ $? != 0 ]
then
	echo "Failed to make corewar executable. Make sure that a Makefile exists in $1 and that it has the \"corewar\" rule."
	exit 1
elif [ ! -f $1/corewar ]
then
	echo "Makefile ran but no corewar file was created."
	exit 1
fi
COREWAR=$1/corewar

echo "Extracting information..."
# Extract victory message
sh makeChampion.sh "" NAME > /tmp/empty.cor
if [ ! -f /tmp/empty.cor ]
then
	echo "makeChampion.sh failed to create champion."
	exit 1
fi
OUTPUT=$($COREWAR /tmp/empty.cor)
status=$?
if [ $status != 0 ]
then
	echo "$COREWAR /tmp/empty.cor failed."
	echo "corewar returned exit status $status."
	exit 1
fi
VICTORY_MESSAGE=$(echo "$OUTPUT" | grep NAME | tail -1)
if [ -z "$VICTORY_MESSAGE" ]
then
	echo "Could not locate victory message. Make sure corewar outputs something like \"My Awesome Champion (player 3) won!\""
	exit 1
fi
VICTORY_FORMAT=$(echo "$VICTORY_MESSAGE" | sed 's/1/NUM/1')

# Extract dump format
sh makeChampion.sh "11 22 33 44 55 66 77 88 99 AA BB CC DD EE FF" > /tmp/alphabet.cor
OUTPUT=$($COREWAR /tmp/alphabet.cor -dump 1)
status=$?
if [ $status != 0 ]
then
	echo "$COREWAR /tmp/alphabet.cor -dump 1 failed."
	echo "corewar returned exit status $status."
	exit 1
fi
STRIPPED_OUTPUT=$(echo "$OUTPUT" | sed "s/[[:space:]]//g")
DUMP_START=$(echo "$STRIPPED_OUTPUT" | grep -Fnm 1 "112233445566778899AABBCCDDEEFF" | tail -1 | cut -f 1 -d ':')
if [ -z $DUMP_START ]
then
	echo "Failed to identify dump in output."
	exit 1
fi

OUTPUT_END=$(echo "$STRIPPED_OUTPUT" | wc -l)
DUMP_END=$OUTPUT_END
while [ $DUMP_END -ge $DUMP_START ]
do
	DUMP=$(echo "$STRIPPED_OUTPUT" | sed -n "$DUMP_START,$DUMP_END p")
	BYTE_COUNT=$(echo "$DUMP" | tr -d '\n' | wc -c)
	if [ $BYTE_COUNT -le 8192 ] ; then
		break
	fi
	let "DUMP_END = DUMP_END - 1"
done
if [ $BYTE_COUNT -ne 8192 ]
then
	echo "Could not match dump in output. Make sure that MEM_SIZE is 4096 in op.h, that the dump is on contiguous lines containing no other information, and that the only delimiters in the dump zone are whitespace."
	exit 1
fi
if [[ ! $(echo "$DUMP" | tr -d '\n') =~ ^112233445566778899AABBCCDDEEFF0*$ ]]
then
	echo "Dump did not match expected output."
	exit 1
fi
let "DUMP_SIZE = DUMP_END - DUMP_START + 1"
let "LINES_AFTER_DUMP = OUTPUT_END - DUMP_END"

echo "$1path to corewar folder
$DUMP_SIZEnumber of lines in dump
$LINES_AFTER_DUMPnumber of extra lines following dump (if any)
$VICTORY_FORMATformat of victory message" | column -t -s ''
