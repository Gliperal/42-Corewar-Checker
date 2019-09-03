#!/bin/bash

source colors.sh
source info.sh

# Validate parameters
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
	echoerr "usage: $0 corewar.info cycles \"champ1 champ2 ...\""
	exit 1
fi

# Extract variables from .info file
load_corewar_info_file $1
if [ $? -ne 0 ] ; then
	exit 1
fi

# Make dump
output=$($corewar $dump_flag $2 $3)
dump=$(echo "$output" | tail -n $dump_tail | head -n $dump_size | cut -c $dump_line_start-$dump_line_end)
if [ -z "$dump_delimiter" ]
then
	echo "$dump" | tr -d '\n' | tr 'a-f' 'A-F'
else
	echo "$dump" | sed "s/$dump_delimiter//g" | tr -d '\n' | tr 'a-f' 'A-F'
fi
