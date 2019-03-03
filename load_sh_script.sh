#!/bin/sh
###############################################################################
#alias import_sh="."


export SH_FRAMEWORK="/var/multiverse/sh/framework.sh"
load_framework(){
  echo "attempting to run command: MODULES=$2 . ./$1"
  MODULES=$2 . ./$1
}
alias import_shell="load_framework"

import_shell test_lib.sh "mega test"


#}
#alias import_shell="load_modules(){ echo \"import_shell: command takes two vars... MODULES=$2 . $1 \"; }; load_modules "


#load_framework(){
#  echo "attempting to run command: MODULES=$2 . $1"
#  MODULES=$2 . $1
#}
#alias import_script="load_framework"
#import_script "./test_lib.sh" "vm io kvm"



#load_framework(){
#	echo "attempting to run command: MODULES=$2 . $1"
#	MODULES="$2" . ./$1
#}
#alias import_script="load_framework"
#import_script "test_lib.sh" "vm io kvm"







# [WORKS] This Fucking works!!!!! NOW JUST NEED TO GET ALL TJHIS IN A SINGLE LINE TO ALIAS IT
#load_framework(){
#	echo "attempting to run command: MODULES=$2 . $1"
#	MODULES="$2" . ./$1
#}
#alias import_script="load_framework"

# [WORKS] Just needs to before!
#MODULE="os vm io kvm" import_sh ./test_lib.sh

#import_sh test_lib.sh

# [WORKS] This will pass modules list successfully to the './test_lib.sh' lib
# when calling it
#MODULE_LIST="io os vm" ./test_lib.sh
