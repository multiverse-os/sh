#!/bin/sh
 
SH_FRAMEWORK="/home/user/multiverse/scripts/sh-framework"

## IMPORT
. $SH_FRAMEWORK/sh-framework.sh

## Using Multiverse OS Shell Framework
## ===================================
##
## Simple example usage
##

## Multiverse OS Bash Framework: Simple Example
## --------------------------------------------
##
## Below are examples of the core features of the shell framework
## which are intended to provide consistency across user experience
## and provide a base level of functionality for scripts. Beyond visual
## consistency, functional consistency is important beyond general quality
## reasons but specifically security reasons, when it comes to validation
## functions.
##

##
## Below each feature is used 1 by 1 which can be used as unit tests for
## each functional feature of the minimalistic framework:
##



## (*) length() function to check size of string

echo "Using length() function to print length of string 'printlength'"
echo "[TEST] length() of 'printlength' SHOULD BE 11 characters"

length_result=(length "printlength")

if [ length_result == 11 ]; then
	echo $success"PASSED! The length_result returned from length() is 11 as expected."$reset
else
	echo $fail"FAILED! The length_result returned from length() is 11 as expected."$reset
fi


## TEST 



## ============================================

echo "Using the print_banner function to title the sh script"


print_banner() "test" 

