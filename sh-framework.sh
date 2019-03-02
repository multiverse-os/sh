#!/bin/sh
###############################################################################
## Multiverse OS Shell Framework
##=============================================================================
## The primary reason to use `sh` framework is used for Multiverse OS shell
## scripting, and recommended to the user, is because it centralized the
## security related responsbilities in shell scripts, implements thorough tests
## written for each security related (not completed yet) function. And all the
## auxillary logic beyond those security functions and other basic OS and other
## helpers are implemented as small modules that can be used individually or
## al together as to let both Multiverse OS developers and users of Multiverse
## to call in this shell framework for any task from very simple scripting to
## prototypes and anything else with as little unnecessary resource use as
## possible and benefit from a community developed shell framework focusing
## on the more complicated parts of software development to allow the script
## writer to focus on what makes their script:
##   1) Validations for basic types: strings, numbers, arrays, filepaths, and
##      more... 
#
##   2) User input functions, to securely take in user input and validate 
##      the input before using it, beacuse all input should be validated 
##      even if the user is assumed to be trusted.
#
##      This is how we conform to the security in depth philosphy required
##      by the Multiverse OS design specification, which defines not just
##      the software, and protocols, but also any software included in the
##      Multiverse OS operating system.)  
#
##   3) Tests that ensure any changes to the shell framework do not break
##      existing logic, to avoid any breaking changes from being merged 
##      into the production branch and released.
#
#
## One important reason why we implemented our own framework was not just
## simply to satisfy our specific prototyping requirements and to add 
## basic helpers that simplify our specific build patterns.
#
## In Additon to the above reasons, the primary reason is because shell and
## bash script developers rarely  implement tests. And by centralizing
## security related logic into the framework, and writing tests we believe
## reliably and reasonably test the security logic.

## Enabling Multiverse developers to provide assurance that using this shell
## library that will be included by default in Multiverse OS, easily
## accessible to users and developers by importing via the use of an
## environmental variable (aka ENV; from shell a list can be viewed by using
## the `env` command). 
#
## The environmental variable is set by default: 
##
##     SH_FRAMEWORK="/home/user/multiverse/scripts/sh-framework"
##
#
## Then a script developer simply prefixes their script with
## #!/bin/sh
## source $SH_FRAMEWORK
## ...(shell source code)...
# 
## And `source` is also aliased to `.` by default allowing a
## developer to import with the shorthand:
#
## #!/bin/sh
## . $SH_FRAMEWORK
#
## In Multiverse OS, an additional `source` command alias
## is set by default `sh_import` in addition to `.` added
## by default in Debian.  
#
## The `sh_import` alias, the variable/function naming in
## the source code of the `sh-framework`, in addition to
## all the Multiverse OS source code is directly inspired
## by Ruby source code philosophy. This is reflected in
## the Multiverse OS design specification that puts 
## heavy emphasis on general intuitiveness, and a focus
## on ensuring the source code is human readable.
#
## #!/bin/sh
## sh_import $SH_FRAMEWORK
## ...(shell source code)... 
#
## 
## Currently this framework is designed around the ability to
## build shell scripts that function in both:
##   * Debian Linux
##   * Alpine Linux
#
## In the future, all major linux operating systems and a variety
## of micro/uni-kernels will be supported by both Multiverse OS
## and the `sh-framework`. But the alpha release of Multiverse OS
## will only guarantee support for the two above operating 
## systems. 
#
## **NOTE**_This is '/bin/sh' NOT '/bin/bash'._
#
#
###############################################################################
## Multiverse OS: Shell Framework
##=============================================================================
###[ GLOBAL Variables ]########################################################

###############################################################################
## OS Helpers
##=============================================================================
# OS HELPER GLOBALs
ROOT_USER="root"
ROOT_USER_ID=$(id -u root)
CURRENT_USER=$(whoami)
CURRENT_USER_ID=$(id -u)


# OS HELPER FUNCTIONs
#[OS User Functions]
user_exists(){  # 1=username
  echo $(grep root /etc/passwd | cut -d ':' -f1)
}

root_user_exists(){
	user_exists "root"
}


 

## TODO: Is member of X group?
## Does X directory exist? Does X file exist? (merge these to simplify)
## Does X directory or file have X permissions or group?
## Create folder of file if does not exist (open_or_create

## iterate through every line of a file and do X, or load every line of file
## into comma separated string or array (if arrays are possible)

## Load JSON or YAML data

## If root? Login as Root if not. ANd just login as root function

## Coloring text

## Length of string

## Does X string contain substring?

## Substitute all instances of X with Y

## Downcase
## Upcase

## String equals == X (regular and case insensitve using downcase)
## Does X sha256 checksum match ANY file on disk?

## Create user

## Kill process

## Start procses, return PID

## Is X *.deb package installed? If not install
## Is X *.apk package installed? if not install

## Expand home folder into full path

## Split path into base path, filename and existension if exists

## Using magic numbers check file type


## TODO: Random number generation



###############################################################################
## Multiverse OS: Basic Terminal Coloring
##=============================================================================
# MULTIVERSE TERMINAL PALETTE
header="\e[0;95m"   # PURPLE
accent="\e[37m"     # WHITE
subheader="\e[98m"  # GRAY 
strong="\e[96m"     # CYAN
text="\e[94m"       # BLUE
success="\e[92m"    # GREEN
warning="\e[93m"    # YELLOW
fail="\e[91m"       # RED
reset="\e[0m"       # Terminal Default

# TEXT COLORING




###############################################################################
## Validations and Errors
##=============================================================================

# VALIDATIONS
##[String]
ALPHA="abcdefghijklmnopqrstuvqrstuvwxyz"
NUMERIC="0123456789"
ALPHANUMERIC=$($ALPHA+$NUMERIC)

##[Number]
 
ZERO=0
## TODO: This may belong in a module, maybe specifically a ComplexNumberValidation
MIN_UINT=0
#MIN_2BIT=0
#MIN_4BIT=0
#MIN_6BIT=0
#MIN_8BIT=0
MAX_2BIT=4   #         [ 2^2 ]
MAX_4BIT=16  #         [ 2^4 ]
MAX_6BIT=64  # A Nible [ 2^6 ]
MAX_8BIT=255 # A Byte  [ 2^8 ]

MIN_8BIT_BINARY=00000000
MAX_8BIT_BINARY=11111111

# ERROR MESSAGES
##[Operating System]
ERROR_MUST_BE_ROOT="Must be logged in as root, or run command with root priviledges. Try again using: \`su\` or \`sudo !!\`." 
ERROR_INVALID_INPUT="Invalid command-line argument supplied with running command."
ERROR_FILE_NOT_FOUND="Specified file does not exist."
ERROR_PATH_NOT_FOUND="Specified path does not exist."


##[String]
ERROR_NOT_ALPHA="Invalid input, must contain ONLY alphabetical characters."
ERROR_NOT_NUMERIC="Invalid input, must contain ONLY number characters."
ERROR_NOT_ALPHANUMERIC="Invalid input, must contain ONLY alphanumeric characters."

##[Number]
ERROR_NOT_GREATER_THAN_ZERO="Invalid input, must be greater than 0. Must not be negative value."
ERROR_NOT_GREATER_THAN_2BIT="Invalid input, must be greater than 4."
ERROR_NOT_GREATER_THAN_4BIT="Invalid input, must be greater than 16."
ERROR_NOT_GREATER_THAN_6BIT="Invalid input, must be greater than 64."
ERROR_NOT_GREATER_THAN_8BIT="Invalid input, must be greater than 255."

ERROR_NOT_LESS_THAN_2BIT="Invalid input, must be less than 4."
ERROR_NOT_LESS_THAN_4BIT="Invalid input, must be less than 16."
ERROR_NOT_LESS_THAN_6BIT="Invalid input, must be less than 64."
ERROR_NOT_LESS_THAN_8BIT="Invalid input, must be less than 255."

## TODO: Provide function to provide these messages with X value. Then use those to generate these messages. 
## then stick all non-standard like beyond maybe 4 and 8 bit, the rest go into a special number/math module. 


###############################################################################
##   VALIDATION FUNCTIONS
##=============================================================================
## GENERAL VALIDATION
# * Argument Count (Minimum arguments, maximum arguments) [TODO]
# * Argument Type (Is String, Is Number, Is Path, Is In List) [TODO]



## STRING VALIDATION
# * Type (alpha, alphanumeric, numeric) [TODO]
# * Length (minimum, maximum, between) [TODO]
# * Not Included In (whitelist, blacklist) [TODO]
is_alphanumeric() {
	# VALIDATE number of arguments IS 1 [TODO]
	return [ $1 =~ [^a-zA-Z0-9] ]
}


is_minimum_length_of() {
	#1=string to check
	#2=minimum length
	[ $(length $1) -eq $2 ]
}


## NUMBER VALIDATION
# * Numericality (less (equal) than, greater (equal) than, equal) [TODO]
# * Is Number (Whole, Decimal, Negative, Positive, Even, Odd) [TODO]



## OS VALIDATION
# * Root
# * X user (is x user, is NOT x user) [TODO]
# * Is Valid Path (May not exist but valid characters, and format) [TODO]
# * Path Exists [TODO]
# * Is Process Running [TODO]

is_root(){
  if [ $CURRENT_USER = "user" ]; then
    echo "[Error] Must be logged in as root. Run 'su' and try again."
    exit 0
  fi
}

## Multiverse OS VALIDATION
# * Signature Validation (GPG, Scramble Key, ECDSA, SSH,...) [TODO]
# * Is X VM Running [TODO]
# * Is X VM Have Internet Connectivity (Router VMs, Controller VMs,...) [TODO]



## ===================================================================
## 
##   TextUI
##
## -------------------------------------------------------------------
## Very minimal text user interface elements, such as horizontal lines
## basic prompts (yes/no), path, and menu, anything more complex should
## rely on higher level languages. 

## print_banner function
print_banner(){
	# TODO: add count of $1 and expand the horizontal bar same length	
	echo $header"Multiverse OS: $1"$reset
	echo $accent"================="$reset
}


##
## * For loop
##

for_loop(){
	#1=starting index
	#2=do x times
	#3=ending index
	if [ $1 -lt 0 -o $1 -gt "255" ]; then
		1=1
	fi
	# VALIDATE character is alphanumeric (avoid escapes or other junk)
	content=""
	i=0
	#while [ $i -lt $1 ]; do
	#done
}

##
## * print x number of y characters
## Useful for basic TextUI elements like horizontal lines
##

print_x_times(){
	# VALIDATE number of arguments IS 2 [TODO]
	# VALIDATE character is alphanumeric (avoid escapes or other junk) [TODO]
	# VALIDATE is NUMBER greater than 0 AND less than 255
	if [ $1 -lt 0 -o $1 -gt "255" ]; then
		1=1
	fi

	content=""
	i=0
	while [ $i -lt $1 ]; do
		content="$content$2"
		i=$((i+1))
	done
	echo $content
}

##
## * length function 
##   Provide the length of a given string
##

length(){
	echo ${#1}
}

##
##
##

## Unimplemented Features
## ----------------------
## Below are features that would be useful for simplifying and providing basic
## functionality to hasten shell script development. If you have time, please
## impelement these features and issue a pull request.



##
## Multiverse OS Specific
## Specifically functions relating to the direct operation or validation of
## Multiverse OS and not generic shell functions that would be broadly useful
## for other scripts and software.

## 
## * is_controller_active? function 
##   Boolean check if ANY Multiverse OS VM is active, would simplify validation. 
##   For example, allow for simple switching PCI devices back to host if FALSE
##
##
## * 
