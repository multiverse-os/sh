#!/bin/sh
###############################################################################
## Experimental Functions Commented Out #######################################

#print_transform_type(){
#	if [ $1 -eq $numeric ]; then
#		echo "numeric"
#	elif [ $1 -eq $alphabetic ]; then
#		echo "alphabetic"
#	elif [ $1 -eq $alphanumeric ]; then
#		echo "alphanumeric"
#	elif [ $1 -eq $utf8 ]; then
#		echo "utf-8"
#	else # $ascii
#		echo "ascii"
#	fi
#}

#print_variable_type(){
#	if [ $1 -eq $string_type ]; then
#		echo "string"
#	elif [ $1 -eq $number_type ]; then
#		echo "number"
#	elif [ $1 -eq $decimal_type ]; then
#		echo "decimal"
#	elif [ $1 -eq $path_type ]; then
#		echo "path"
#	elif [ $1 -eq $url_type ]; then 
#		echo "url"
#	else
#		echo 
#	fi
#}
# NOTE: These enable us to enable the framework to work without any dependency 
#       binaries. Right now the number of dependency binaries is down to 1 
#       ('tr'). This is not only maximally compatible and portalbe; but 
#       importantly it doesn't require direct execution of a command that 
#       provides attack surface for a breakout. 
#upcase_character(){
#	if [ $1 -eq "a" ]; then
#		echo "A"
#	elif [ $1 -eq "b" ]; then
#		echo "B"
#	elif [ $1 -eq "c" ]; then
#		echo "C"
#	elif [ $1 -eq "d" ]; then
#		echo "D"
#	elif [ $1 -eq "e" ]; then
#		echo "E"
#	elif [ $1 -eq "f" ]; then
#		echo "F"
#	elif [ $1 -eq "g" ]; then
#		echo "G"
#	elif [ $1 -eq "h" ]; then
#		echo "H"
#	elif [ $1 -eq "i" ]; then
#		echo "I"
#	elif [ $1 -eq "j" ]; then
#		echo "J"
#	elif [ $1 -eq "k" ]; then
#		echo "K"
#	elif [ $1 -eq "l" ]; then
#		echo "L"
#	elif [ $1 -eq "m" ]; then
#		echo "M"
#	elif [ $1 -eq "n" ]; then
#		echo "N"
#	elif [ $1 -eq "o" ]; then
#		echo "O"
#	elif [ $1 -eq "p" ]; then
#		echo "P"
#	elif [ $1 -eq "q" ]; then
#		echo "Q"
#	elif [ $1 -eq "r" ]; then
#		echo "R"
#	elif [ $1 -eq "s" ]; then
#		echo "S"
#	elif [ $1 -eq "t" ]; then
#		echo "T"
#	elif [ $1 -eq "u" ]; then
