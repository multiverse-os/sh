#!/bin/sh
###################################

. "./framework.sh"

has_substring(){ # 1=string 2=substring
	modified_string=$(echo "$1" | tr -d "$2")
	if [ $(length $1) -eq $(length $modified_string) ]; then
		echo 0
	else
		echo 1
	fi
}
string="does this string work?"
substring="str"

echo "Substring checker"
echo "================="

result=$(has_substring "$string" "$substring")
echo "Checked if our string: '$string' has substring '$substring'"
echo "Resulted in: $result"
