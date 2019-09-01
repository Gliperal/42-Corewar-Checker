#!/bin/bash

source colors.sh

# Validate parameters
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
	echoerr "usage: ./dump.sh corewar.info \"champ1 champ2 ...\" cycles"
	exit 1
fi

# Extract variables from .info file
corewar_info_file=$1
source info.sh

# Make dump
output=$($corewar $2 $dump_flag $3)
dump=$(echo "$output" | tail -n $dump_tail | head -n $dump_size | cut -c $dump_line_start-$dump_line_end)
if [ -z "$dump_delimiter" ]
then
	echo "$dump" | tr -d '\n' | tr 'a-f' 'A-F'
else
	echo "$dump" | sed "s/$dump_delimiter//g" | tr -d '\n' | tr 'a-f' 'A-F'
fi
