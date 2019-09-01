#!/bin/bash

echo "Basic instruction tests"

./test.sh 14,15 "01 FF FF FF FF 03 70 01"

./test.sh 9,10 "02 90 89 AB CD EF 01 03 70 01"
./test.sh 9,10 "02 D0 2A 01 10 03 70 10"

./test.sh 4,5 "03 70 01 42 02"
./test.sh 9,10 "03 50 01 10 03 70 10"

./test.sh 14,15 "04 54 01 01 10 03 70 10"
./test.sh 24,25 "02 90 F2 97 46 D5 0E 02 90 37 4C 6A 75 03 04 54 0E 03 03 03 70 03"

./test.sh 14,15 "05 54 10 01 10 03 70 10"
./test.sh 24,25 "02 90 2F 97 46 D5 0E 02 90 37 4C 6A 75 03 05 54 0E 03 03 03 70 03"

./test.sh 20,21 "02 90 A9 D1 99 5B 07 02 90 7B CE 09 A1 06 06 54 07 06 0D 03 70 0D"
./test.sh 10,11 "06 A4 C6 32 26 63 C3 DF 90 2D 04 03 70 04"
./test.sh 10,11 "06 F4 18 01 4C 0C 0F 03 70 0F 00 00 94 71 9D 94"

./test.sh 15,16 "02 90 CE 8F 8C 0B 03 07 64 03 91 64 AF DD 06 03 70 06"
./test.sh 10,11 "07 B4 39 A3 87 28 74 0E 0D 03 70 0D 00 00 CF C4 C8 3E"
./test.sh 15,16 "02 90 39 0E 3A 5D 0A 07 D4 AF FF 0A 0E 03 70 0E"

./test.sh 15,16 "02 90 FF 95 00 52 05 08 74 05 F5 F9 05 03 70 05"
./test.sh 15,16 "02 90 EB DB 88 BE 06 08 94 AD 32 1B C8 06 0A 03 70 0A"
./test.sh 10,11 "08 E4 08 0E C6 D4 15 0F 0E 03 70 0E 00 00 A4 4E 1C 7D"

./test.sh 29,30 "02 90 00 00 00 00 10 09 00 04 0C 03 70 01"
./test.sh 25 "09 00 04 00 03 70 01"
./test.sh 39,40 "02 90 03 70 01 00 07 02 D0 00 64 08 03 70 07 00 0F 09 00 0A"

./test.sh 29,30 "0A 54 01 01 01 03 70 01"
./test.sh 34,35 "02 90 FF FF E8 A8 0E 0A 64 0E 17 51 08 03 70 08"
./test.sh 34,35 "02 90 74 19 98 01 06 0A 94 96 02 06 0B 03 70 0B"
./test.sh 29,30 "0A A4 57 BB D2 51 0C 03 70 0C 00 00 54 CD 1D 6B"
./test.sh 29,30 "0A D4 6E 05 01 0C 03 70 0C 00 00 D3 80 C8 EB"
./test.sh 29,30 "0A E4 97 FD FF F8 07 03 70 07"

./test.sh 24,25 "0B 54 01 01 01"
./test.sh 29,30 "02 90 FF FF E8 A8 0E 0B 58 01 0E 17 51"
./test.sh 29,30 "02 90 74 19 98 01 06 0B 64 06 96 02 06"
./test.sh 24,25 "0B 68 01 57 BB D2 51"
./test.sh 24,25 "0B 74 01 6E 04 01 4C 09"
./test.sh 24,25 "0B 78 01 97 FD FF F8"

./test.sh 804,805 "0C 00 08 03 70 10 FF FE 03 70 01"
./test.sh 824,825 "09 03 70 0C 99 FE 03 70 01"
./test.sh 809,810 "02 90 12 34 56 78 10 0C 00 08 03 70 10 00 00 03 70 10 00 00"
./test.sh 829,830 "02 D0 00 64 01 0C 00 06 09 00 06 09 00 08 03 70 01 00 00 03 70 01"
./test.sh 1614,1615 "01 FF FF FF FF 0C 00 0E 0C 00 08 03 70 01 00 00 03 70 01 0C 00 08 03 70 01 00 00 03 70 01"

./test.sh 14,15 "0D 90 89 AB CD EF 01 03 70 01"
# okay so apparently lld loads a short for whatever reason when called with an ind arg
./test.sh 14,15 "0D D0 00 01 10 03 70 10"
./test.sh 14,15 "0D D0 00 02 10 03 70 10"
./test.sh 24,25 "02 90 1F 90 6F 8D 0F 03 70 0F FE 01 0D D0 FD FC 03 03 70 03"

./test.sh 64,65 "02 90 CF 0B FE FE 04 03 70 04 FE 01 0E 54 04 04 01 03 70 01"
./test.sh 59,60 "02 90 FF FF E8 A8 0E 0E 64 0E 17 51 08 03 70 08"
./test.sh 59,60 "02 90 E4 19 00 01 06 0E 94 00 02 06 0B 03 70 0B"
./test.sh 54,55 "0E A4 57 BB A8 51 0C 03 70 0C 00 00 54 CD 1D 6B"
./test.sh 54,55 "0E D4 97 FD 01 0C 03 70 0C 00 00 00 00 D3 80 C8 EB"
./test.sh 64,65 "02 90 FF FF 7E 2A 10 03 70 10 FE 01 0E E4 FF F6 7F D2 07 03 70 07"

./test.sh 1024,1025 "09 03 70 0F FF FE 03 70 01"
./test.sh 1009,1010 "02 90 12 34 56 78 10 0F 00 08 03 70 10 00 00 03 70 10 00 00"
./test.sh 1029,1030 "02 D0 00 64 01 0F 00 06 09 00 06 09 00 08 03 70 01 00 00 03 70 01"
./test.sh 2014,2015 "01 FF FF FF FF 0F 00 0E 0F 00 08 03 70 01 00 00 03 70 01 0F 00 08 03 70 01 00 00 03 70 01"
./test.sh 1009,1010 "0F 0F F4 02 90 03 70 01 00 09 03 70 09 FF F5"
./test.sh 1015,1016 "0F 0F F4 02 90 03 70 01 00 09 03 70 09 FF F5"

./test.sh 6,7 "10 40 01 03 70 01"

echo "Carry flag tests"

# carry-modifying instructions
# ld
./test.sh 30,54,55 "02 90 00 00 00 00 10 09 00 05 03 70 02 90 80 00 00 00 10 09 00 06 03 70 01"
./test.sh 30,54,55 "02 D0 00 64 10 09 00 05 03 70 02 D0 00 09 10 09 00 06 03 70 01"
# add/sub
./test.sh 35,64,65 "04 54 02 02 02 09 00 05 03 70 04 54 01 01 01 09 00 06 03 70 01"
./test.sh 35,64,65 "05 54 02 02 02 09 00 05 03 70 05 54 01 02 01 09 00 06 03 70 01"
# and/or/xor
./test.sh 31,56,57 "06 B4 00 00 FF FF 00 00 04 09 00 05 03 70 06 D4 00 0B 01 01 09 00 06 03 70 01"
./test.sh 31,56,57 "07 74 06 FF FC 06 09 00 05 03 70 07 E4 00 04 80 00 00 00 07 09 00 06 03 70 07"
./test.sh 31,56,57 "08 54 06 0D 10 09 00 05 03 70 08 A4 89 AB CD EF 09 AB CD EF 04 09 00 06 03 70 04"
# lld/lldi
./test.sh 35,64,65 "0D 90 00 00 00 00 10 09 00 05 03 70 0D 90 80 00 00 00 10 09 00 06 03 70 01"
./test.sh 35,64,65 "0D D0 00 64 10 09 00 05 03 70 0D D0 00 09 10 09 00 06 03 70 01"
./test.sh 34,35 "0D D0 FF FE 10 09 00 04 0C 03 70 01"
./test.sh 75,144,145 "0E A4 FF FE FF FE 02 09 00 05 03 70 0E 54 03 06 0B 09 00 06 03 70 01"
./test.sh 74,75 "0E D4 00 01 04 0D 09 00 04 0C 03 70 01"

# non-modifying instructions (carry 0)
./test.sh 34,35 "01 00 00 00 00 09 00 06 03 70 01"
./test.sh 29,30 "03 70 09 00 00 09 00 06 03 70 01"
./test.sh 44,45 "09 00 00 09 00 06 03 70 01"
./test.sh 49,50 "0A 94 FF FC 09 06 09 00 06 03 70 01"
./test.sh 49,50 "0B 78 06 00 00 00 00 09 00 06 03 70 01"
./test.sh 824,825 "0C 00 00 09 00 06 03 70 01"
./test.sh 1024,1025 "0F 00 00 09 00 06 03 70 01"
./test.sh 26,27 "10 40 08 09 00 06 03 70 01"

# non-modifying instructions (carry 1)
./test.sh 39,40 "02 D0 00 64 01 01 00 00 00 00 09 00 04 0C 03 70 01"
./test.sh 34,35 "02 D0 00 64 05 03 50 01 0F 09 00 04 0C 03 70 01"
./test.sh 49,50 "02 D0 00 64 05 09 00 04 0C 09 00 04 0C 03 70 01"
./test.sh 54,55 "02 D0 00 64 05 0A 64 08 FF FF 07 09 00 04 0C 03 70 01"
./test.sh 54,55 "02 D0 00 64 05 0B 74 01 00 64 0E 09 00 04 0C 03 70 01"
./test.sh 829,830 "02 D0 00 64 05 0C 00 64 09 00 04 0C 03 70 01"
./test.sh 1029,1030 "02 D0 00 64 05 0F 00 64 09 00 04 0C 03 70 01"
./test.sh 31,32 "02 D0 00 64 05 10 40 01 09 00 04 0C 03 70 01"

# IDX_MOD tests
# is carry modified on failed ACB reg etc
# negative offsets
# cycle to die tests
# ACB tests
# fork order / program order tests
# concurrent modification tests
#./test.sh 804 "0C 00 05 03 70 03 70 01 00 03"
#./test.sh 805 "0C 00 05 03 70 03 70 01 00 03"
#./test.sh 804 "0C 00 05 03 70 03 70 01"
#./test.sh 805 "0C 00 05 03 70 03 70 01"
# live tests (living on invalid numbers and all those quirks; what if no one lives?)

# Simple program tests

# Randomly generated tests
