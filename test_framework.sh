#!/bin/sh
###############################################################################

SH_FRAMEWORK="/home/user/multiverse/scripts/sh-framework"

## IMPORT #####################################################################
. $SH_FRAMEWORK/sh-framework.sh

## ==================================================##
##
##  Multiverse OS: Minimal Shell Framework Unit Testing
##
## ==================================================##
print_banner "Minimal Shell Framework Unit Tests"
## Unit Test Global Variables
PASSED=0
FAILED=0
TESTS=0
TOTAL=3 # Not ideal since we have to increment it manually

## function_result_should_be() function to provide basic check for unit testing
function_with_paramters_result_should_be() {
  # 1=function name
  # 2=function parameters
  # 3=function result
  # 4=should_be result
  TESTS=$((TESTS+1))
  echo $text"[ Running test $TESTS / $TOTAL] Testing $1 function "$reset
  echo $text"  $1 function with parameters: $2 SHOULD BE $4... $reset"
  if [ ! -z $3 -a ! -z $4 ]; then
    if [ $3 = $4 ]; then
      echo $success"[PASSED!] The function result returned from $3 is $2 as expected."$reset
      PASSED=$((PASSED+1))
    else
      echo $fail"[FAILED!] Function returned: [$3]. Expected result to be == $4."$reset
      FAILED=$((FAILED+1))
    fi
  fi
}

## print_test_status() function to view running stats of unit tests
print_test_status() {
	echo "\n$text[ $success$PASSED$text / $TESTS tests have passed out of a total of $strong$TOTAL$text tests ]$reset\n"
}

## ==================================================##
##                                              
##  Shell Framework Unit Tests     
##
##== VALIDATION UNIT TESTS ==========================##
## =(1)==============================================##
## length() function to check size of string    
## ==================================================##
echo $header"[ length() | input: [string] | returns length of input string ]"$reset
length_result=$(length "printlength")
function_with_paramters_result_should_be "length()" "['printlength']" $length_result "11" 
print_test_status


## STRING VALIDATION                                 ##
## =(2)==============================================##
## is_minimum_length_of() function to check size of string    
## ==================================================##
echo $header"[ is_minimum_length_of() | input: [string, int] | returns length of input string ]"$reset
minimum_length_check_result=$(is_minimum_length_of "test_string" 5)
function_with_paramters_result_should_be "is_minimum_length_of()" "['test_string', 5]" $minimum_length_check_result 5
print_test_status





## ==================================================##
##== TEXTUI UNIT TESTS ==============================##
## =(2)==============================================##
## print_x_times() function for visual elements like
## horizontal lines
## ==================================================##
echo $header"[ print_x_times() | input: [int, string (character)] | returns string comprised of x number of string (character), intended to create horizontal lines easily ]"$reset
print_x_times_result=$(print_x_times 11 'x')
function_with_paramters_result_should_be "print_x_times()" "[11, 'x']" $print_x_times_result "xxxxxxxxxxx"
print_test_status


## ==================================================##
##== VALIDATION UNIT TESTS ==========================##
## =(3)==============================================##




## ==================================================##




