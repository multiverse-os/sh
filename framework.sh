#!/bin/sh
###############################################################################
debug=1
###############################################################################
## NOTE: Bourne shell doesn't support $(thing)! Update framework
## Library Imports



current_working_directory=$(pwd)
if [ $debug -eq 1 ]; then
	echo "current_working_directory is:" $current_working_directory
fi

 . ./sh-arguments.sh


###############################################################################
## Multiverse OS Shell Framework
###############################################################################
## [Import Example]: Importing Shell Framework (using $SH_FRAMEWORK env)
#------------------------------------------------------------------------------
#```
# #!/bin/bash  
# import_sh $SH_FRAMEWORK 
#   ^              ^
#   |      ________|____________________________________________
#   |     |                                                     |
#   |     | env variable, installed in '~/.bashrc' as 'export:  |
#   |     |   SHELL_FRAMEWORK="~/.local/share/sh/framework.sh   |
#   |     |_____________________________________________________|
#   | 
#  _|_________________________________________
# |                                           |
# | 'source' aliased to 'import_sh', and '.': |
# |    import_sh $SH_FRAMEWORK                |
# |    . $SH_FRAMEWORK                        |
# |    source $SH_FRAMEWORK                   | 
# |                                           |
# |___________________________________________|
#
# [...shell source code...]
#```
##=============================================================================
## Task List
##-----------------------------------------------------------------------------
##
## TODO: Can we enter and leave root as soon as the root permission requiring
##       tasks are completed to reduce the amount of time root priviledges
##       are maintained? Because a root account is an attack surface, and
##       the longer one is using the root account, the longer that attack
##       surface is a viable target. 
##
## TODO: Provide function to provide these messages with X value. Then use those to generate these messages. 
## then stick all non-standard like beyond maybe 4 and 8 bit, the rest go into a special number/math module. 
##
##
## TODO: Most likely dont want to assign these until they are needed and so
##       use a function to etiher assign them or just move this logic into
##       a either OS module or a OS user module. 
##
## TODO: OS VALIDATION
## 	 Root
## 	 X user (is x user, is NOT x user) [TODO]
## 	 Is Valid Path (May not exist but valid characters, and format) [TODO]
## 	 Path Exists [TODO]
## 	 Is Process Running [TODO]
##
## TODO: Add path_valid?; add check if_exists?; check has_permissions?
##
## TODO: Is member of X group?
##
## Does X directory exist? Does X file exist? (merge these to simplify)
##
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

## TODO: Transform case
##       * Downcase
##       * Upcase

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

## NUMBER VALIDATION
# * Numericality (less (equal) than, greater (equal) than, equal) [TODO]
# * Is Number (Whole, Decimal, Negative, Positive, Even, Odd) [TODO]

## Multiverse OS VALIDATION
# * Signature Validation (GPG, Scramble Key, ECDSA, SSH,...) [TODO]
# * Is X VM Running [TODO]
# * Is X VM Have Internet Connectivity (Router VMs, Controller VMs,...) [TODO]
#
#
#=============================================================================
# **Functionality Idea Brainstorming**
# 
#  * Simplify boolean checks through functions to parse a string or a int to
#    see if it is a boolean; return either 0 or 1
#  
#  * provide a simple function to check length of a string
#
#  * provide function to check if a path exists; and one to check if a path
#    is valid. one of the best ways to check validity is to touch a file 
#    in that path see it it exists. then just delete it and report if it 
#    was successful or not. 
#
#  * Function to list all available framework modules, then this list can 

#  * Provide functions for creating simple wrapper scripts. For example:
#    1) a wrapper that will ensure an executable is always running even
#       after a crash. This is done by surrounding the  `./executable`
#       with a while true; then ./executable; done loop.
#    2) Or a wrapper that defines some env variables or uses some env
#       variables or runs some other stuff before launching a problem

#  * Add some Ruby language human-readable like aliases to function owr
#    on reproduce functionality in Ruby like until, x times do, and so
#    on (obviously where its possible) to make vanilla shell scripting
#    much easier. This could be a module too so its optional and not
#    bloating the core program

#
#  * (had an idea for another way to simplify things but cant remember)
#
###############################################################################
## TODO: Go through this document and migrate stuff to modules so that this
##       is lean and minimial as reasonably possible. And the other logic
##       is then optional and used when needed. 
## 
###############################################################################
## Gloabl(s)
##=============================================================================
# GLOBAL ALISES AND HELPERS
#------------------------------------------------------------------------------







##[_BOOLEAN_ALIASES_]
#TRUE
TRUE=1
true=1
YES=1
yes=1
##TODO: Need to also catch the string "Y", "YES", "Yes", and same for no)
#FALSE
FALSE=0
false=0
NO=0
no=0

parse_boolean(){# 1=ValueToCheck




}

is_true(){# 1=BooleanToCheck
	ParseBoolean
	if [ ]; then

	fi
}
	 

#==============================================================================
# MULTIVERSE TERMINAL PALETTE
#------------------------------------------------------------------------------
##COLOR_VARIABLE(s)
header="\e[0;95m"   # PURPLE
accent="\e[37m"     # WHITE
subheader="\e[98m"  # GRAY 
strong="\e[96m"     # CYAN
text="\e[94m"       # BLUE
success="\e[92m"    # GREEN
warning="\e[93m"    # YELLOW
fail="\e[91m"       # RED
reset="\e[0m"       # Terminal Default

##COLOR_FUNCTION(s)

##=============================================================================
## ERROR MESSAGES
##-----------------------------------------------------------------------------
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


# OS GLOBAL Variables


##IMPORTANT PATH(s)
##-----------------------------------------------------------------------------
BASHRC="~/.bashrc"
SH_FRAMEWORK="~/.local/share/sh/framework.sh"
#USER(s)
##-----------------------------------------------------------------------------
##ROOT
ROOT_USER="root"
ROOT_USER_ID=$(id -u root)
ROOT_USER_GID=$(id -g root)
##CURRENT USER
CURRENT_USER=$(whoami)
CURRENT_USER_ID=$(id -u)
CURRENT_USER_GID=$(id -g)


#OS_FUNCTION(s)
#------------------------------------------------------------------------------
##USER_FUNCTION(s)
is_root(){
  if [ $CURRENT_USER = "user" ]; then
    echo "[Error] Must be logged in as root. Run 'su' and try again."
    exit 0
  fi
}


user_exists(){  # 1=Username
  echo $(grep $1 /etc/passwd | cut -d ':' -f1)
}

group_exists(){  # 1=GroupName
  echo $(grep $1 /etc/groups | cut -d ':' -f1)
}

root_user_exists(){
	user_exists "root"
}


#UTILITIE(s)
##STRING_UTILITIE(s)
#------------------------------------------------------------------------------
length(){
	echo ${#1}
}

#split(){ # 1=String 2=SplitAtSymbol
#	## TODO Should just split and ensure the new separating character is
#	## space because, there is no array/slice.
#	echo "echo $1 | cut -d '$2')"
#}

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


#File IO
#------------------------------------------------------------------------------
append_to_file(){ # 1=StringToAppend 2=FilePath
	echo "$1" >> $2
}

append_to_bashrc(){ # 1= StringToAppend
	append_to_file $1 >> $BASHRC
}


###############################################################################
## Validations and Errors
##=============================================================================
# VALIDATIONS
#------------------------------------------------------------------------------
##[String]
#------------------------------------------------------------------------------
ALPHA="abcdefghijklmnopqrstuvqrstuvwxyz"
NUMERIC="0123456789"
ALPHANUMERIC=$($ALPHA+$NUMERIC)

##[Number]
##------------------------------------------------------------------------------
ZERO=0
MIN_UINT=0
MAX_2BIT=4   #         [ 2^2 ]
MAX_4BIT=16  #         [ 2^4 ]
MAX_6BIT=64  # A Nible [ 2^6 ]
MAX_8BIT=255 # A Byte  [ 2^8 ]


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



##====================================================================
## TextUI And Text Transformation(s)
##--------------------------------------------------------------------
## Very minimal text user interface elements, such as horizontal lines
## basic prompts (yes/no), path, and menu, anything more complex should
## rely on higher level languages. 
#

print_banner(){ # 1=Subtitle
	echo $header"Multiverse OS$reset$text:$reset$accent $1"$reset
	echo $accent"======================================================================"$reset
}

print_x_times(){
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


