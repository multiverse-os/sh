#!/bin/sh
###############################################################################

NESTED=$(cat /sys/module/kvm_intel/parameters/nested)

if [ "$NESTED" = "Y" ]; then
	echo "1"
	return 1
else
	echo "0"
	return 0
fi

