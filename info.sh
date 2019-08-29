#!/bin/bash

source colors.sh

if [ ! -f "$corewar_info_file" ]
then
	printerr "$corewar_info_file is not a file."
	exit 1
fi

# Read variables
vars=$(cat $corewar_info_file | cut -d '' -f 1)
corewar_folder=$(echo "$vars" | sed -n 1p)
dump_flag=$(echo "$vars" | sed -n 2p)
dump_size=$(echo "$vars" | sed -n 3p)
lines_after_dump=$(echo "$vars" | sed -n 4p)
dump_line_start=$(echo "$vars" | sed -n 5p)
dump_line_end=$(echo "$vars" | sed -n 6p)
dump_delimiter=$(echo "$vars" | sed -n 7p)
victory_format=$(echo "$vars" | sed -n 8p)
if	[ -z "$corewar_folder" ] || \
	[ -z "$dump_flag" ] || \
	[ -z "$dump_line_start" ] || \
	[ -z "$dump_line_end" ] || \
	[ -z "$victory_format" ]
then
	printerr "Unable to parse $corewar_info_file"
	exit 1
fi
num_regex="^[0-9]+"
if	[[ ! $dump_size =~ $num_regex ]] || \
	[[ ! $lines_after_dump =~ $num_regex ]]
then
	printerr "Unable to parse $corewar_info_file"
	exit 1
fi
let "dump_tail = dump_size + lines_after_dump"

# Make corewar
make -C $corewar_folder corewar > /dev/null
if [ $? != 0 ]
then
	printerr "Failed to make corewar executable."
	echoerr "Make sure that a Makefile exists in $corewar_folder and that it has the \"corewar\" rule."
	exit 1
elif [ ! -f $corewar_folder/corewar ]
then
	printerr "Makefile ran but no corewar file was created."
	exit 1
fi
corewar=$corewar_folder/corewar
