#!/bin/sh
###############################################################################
# SH(ell Scripting) FRAMEWORK                                                 #
###############################################################################
# Framework Global Variables: Basic application, system data, and aliasing    #
#                                                                             #
###############################################################################
# TASK LIST
# TODO Add a pure shell YAML parser, then store basic globals, and settings   #
#      in a YAML file to simplify updating, management and extending the      #
#      overall framework.                                                     #
###############################################################################
    # Application Status                                                      #
    ###########################################################################
# Easily way to ignore output 
ignore_errors="2>/dev/null"
ignore_output="&>/dev/null"

#_SH_DEBUG=1
current_user=$USER 

# Data Types
_numeric="0123456789"
_upcased_alphabetic="ABCDEFGHIJKLMNOPQRSTUVQRSTUVWXYZ"
_downcased_alphabetic="abcdefghijklmnopqrstuvqrstuvwxyz"
_alphabetic=$upcased_alphabetic$downcased_alphabetic
_alphanumeric=$alphabetic$numeric

# Aliases 
_alpha=$alphabetic
_digit=$numeric
    ###########################################################################
    # Boolean Aliasing                                                        #
    ###########################################################################
_true=1
_false=0
_true_string="true"
_false_string="false"
_true_character="t"
_false_character="f"
_yes_string="yes" 
_no_string="no"
_yes_character="y"
_no_character="n"
    ############################################################################
    # Color Palette                                                            #
    ############################################################################
# ANSI Styles
_ansi_light="\e[0m"
_ansi_strong="\e[1m"
_ansi_underline="\e[4m"
_ansi_crossed_out="\e[9m"

# ANSI Colors
_ansi_black="\e[30m"
_ansi_red="\e[31m"
_ansi_green="\e[32m"
_ansi_yellow="\e[33m"
_ansi_blue="\e[34m"
_ansi_purple="\e[35m" # Magenta
_ansi_silver="\e[37m" # White
_ansi_cyan="\e[38m"

# ANSI Bright Colors
_ansi_white="\e[97m" # Bright White
_ansi_gray="\e[90m" # Bright Black
_ansi_bright_purple="\e[95m" # Bright Magenta
_ansi_bright_green="\e[92m"
_ansi_bright_yellow="\e[93m"
_ansi_bright_blue="\e[94m"
_ansi_bright_cyan="\e[96m"
_ansi_bright_red="\e[91m"

_ansi_reset="\e[0m"
# UI Palette 
# NOTE Allows developers to change these to universely change
#      all their scripts coloring, making them all consistent. 
_header="$_ansi_strong$_ansi_purple"
_subheader=$_ansi_blue
_text=$_ansi_gray
_accent="$_ansi_light$_ansi_blue"
_strong="$_ansi_strong$_ansi_white"
_success=$_ansi_green
_warning=$_ansi_yellow
_fail=$_ansi_red
_reset=$_ansi_reset
    ###########################################################################
    # Error Messages                                                          #
    ###########################################################################
has_substring(){ # 1=string 2=substring
	modified_string=$(echo "$1" | tr -d "$2")
	if [ $(length $1) -eq $(length $modified_string) ]; then
		echo 0
	else
		echo 1
	fi
}

# Input Validation
# NOTE This design quickly makes it possible to support different locales and
#      this satisfies critical design requirements of Multiverse OS.  
# 
# LANG environmental variables allows us to use OS default
# Use env based locales: if [ $(has_substring $LANG "en") ]; then
error_message(){ # 1=error_type 
	if [ $_invalid_input_error -eq $1 ]; then
		if [ $(has_substring $LANG "nl") ]; then
			echo "Not supported"
		else # en
			echo "One or more of the command arguments are invalid."
		fi
	elif [ $_filepath_not_found_error -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Specified file does not exist."
		fi
	elif [ $_path_not_found_error -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Specified path does not exist."
		fi
	elif [ $_not_root_error -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Root priviledges required to run this command." 
		fi
	elif [ $_not_alphabetic_error -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Must contain ONLY alphabetical characters."
		fi
	elif [ $_not_numeric_error -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Must contain ONLY number characters."
		fi
	elif [ $_not_alphanumeric -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Must contain ONLY alphanumeric characters."
		fi
	elif [ $_not_positive_error -eq $1 ]; then
		if [ $(has_substring $LANG "en") ]; then
			echo "Must be greater than 0."
		fi
	else
		if [ $(has_substring $LANG "en") ]; then
			echo "Undefined error message"
		fi
	fi
}
###########################################################################
# Enumerators (Allow avoiding a lot of potential string comparisons)      #
###########################################################################
# Log Type
_debug_log=0
_info_log=1
_warn_log=2
_error_log=3
_success_log=4
_fatal_log=5

# Input Type
_alphanumeric=0
_numeric=1
_alphabetic=2
_ascii=3
_utf8=4
###############################################################################
# Framework Functions: Input Validation, Error Handling, Helpers & Utilities  #
#                                                                             #
###############################################################################
# OS Functions                                                            #
###########################################################################
is_root(){ # --no-input--
	if [ $current_user -ne "root" ]; then
		error $error_must_be_root
		echo $_false
	else
		echo $_true
	fi
}

user_exists(){   echo $(not_empty $(grep $1 /etc/passwd)); } # 1=user_name
group_exists(){  echo $(not_empty $(grep $1 /etc/groups)); } # 1=group_name
in_group(){      echo $(not_empty $(groups | grep $1)); }    # 1=group_name 
#######################################################################
## File Functions #####################################################
#######################################################################
can_write(){ # 1=path
	if [ -w $2 ]; then
		echo $_true
	else
		echo $_false
	fi
}

can_read(){ # 1=path
	if [ -r $2 ]; then
		echo $_true
	else
		echo $_false
	fi
}

can_execute(){ # 1=excutable_path
	if [ -x $1 ]; then
		echo $_true
	else
		echo $_false
	fi
}
###########################################################################
# STRING Functions                                                        #
###########################################################################
# NOTE  [Using 'tr' command]                                              #
#       -c removes everything BUT supplied characters, -d deletes, so our #
#       below tr command is everything but digits, delete.                #
###########################################################################
length(){            echo ${#1}; }                              # 1=string
replace(){           echo $(echo $1 | tr $2 $3);  } # 1=string 2=old 3=new
remove_whitespace(){ echo $(echo $1 | tr     [:blank:] ''); }   # 1=string

# Filter For Specific Type
only_numeric(){      echo $(echo $1 | tr -cd [:digit:]); }      # 1=string
only_alphabetic(){   echo $(echo $1 | tr -cd [:alpha:]); }      # 1=string
only_alphanumeric(){ echo $(echo $1 | tr -cd [[:alphanum:]]); } # 1=string
only_ascii(){        echo $(echo $1 | tr -cd [:ascii:]); }      # 1=string
only_utf8(){         echo $(echo $1 | tr -cd [:utf8:]); }       # 1=string

# Change Letter Case
upcase(){            echo $(echo $1 | tr [a-z] [A-Z]); }        # 1=string
downcase(){          echo $(echo $1 | tr [A-Z] [a-z]); }        # 1=string
###########################################################################
# VALIDATION FUNCTIONS                                                    #
###########################################################################
parse_input(){ # 1=input_type 2=value
	if [ $_alphanumeric -eq $1 ]; then
		echo $(only_alphanumeric $2)
	elif [ $_numeric -eq $1 ]; then
		echo $(only_numeric $2)
	elif [ $_alphabetic -eq $1 ]; then 
		echo $(only_alphabetic $2)
	elif [ $_utf8 -eq $1 ]; then 
		echo $(only_utf8 $2)
	elif [ $_ascii -eq $1 ]; then 
		echo $(only_ascii $2)
	else
		fatal_error "Failed to parse input, unsupported data type."
	fi
}
#######################################################################
#### BOOLEAN TYPE #####################################################
#######################################################################
is_zero(){ # 1=value
	if [ $1 -eq 0 ]; then
		echo $_true
	else
		echo $_false
	fi
}

not_zero(){ # 1=value
	if [ $1 -gt 0 -a $1 -lt 0 ]; then
		echo $_false
	else
		echo $_true
	fi
}

# NOTE Checking (downcased input): [1, "true", "t", "yes", "y"]
is_true(){ # 1=value 
	1=$(remove_whitespace $1) 
	if [ $(length $1) -eq 1 -a 1 ]; then
		echo $_true
	elif [ $(length $1) -eq 1 -a $(is_zero $1) ]; then
		echo $_false
	else
		1=$(downcase $1)
		if [ $(length $1) -eq 1 -a $1 -eq $_true_character]; then
			echo $_true
		elif [ $(length $1) -eq 1 -a $1 -eq $_yes_character]; then
			echo $_true
		elif [ $(length $1) -eq 3 -a $1 -eq $_yes_string ]; then
			echo $_true
		elif [ $(length $1) -eq 4 -a $1 -eq $_true_string ]; then
			# NOTE: Do we need to check "1" is that
			#       even register as separate from 1 
			#       checked at the top in `sh`?
			echo $_true
		else 
			echo $_false
		fi
	fi
}

# NOTE Checking (downcased input): [0, "false", "f", "no", "n"]
is_false(){ # 1=value
	1=$(remove_whitespace $1) 
	if [ $(length $1) -eq 1 -a $(is_zero $1) ]; then
		echo $_false
	elif [ $(length $1) -eq 1 -a $1 -eq 1 ]; then
		echo $_true
	else
		1=$(downcase $1)
		if [ $(length $1) -eq 1 -a $1 -eq $_false_character ]; then
			echo $_flase
		elif [ $(length $1) -eq 1 -a $1 -eq $_no_character ]; then
			echo $_flase
		elif [ $(length $1) -eq 2 -a $1 -eq $_false_string ]; then
			echo $_flase
		elif [$(length $1) -eq 4 -a $1 -eq $_no_string ]; then
			echo $_flase
		else 
			echo $_true
		fi
	fi
}
#######################################################################
#### STRING TYPE ######################################################
#######################################################################
is_blank(){ # 1=input(output from commands like grep) 
	if [ $(length $1) -eq 0 ]; then
		echo $_true
	else
		echo $_false
	fi
}


not_bank(){ # 1=input(output from commands like grep) 
	if [ $(length $1) -gt 0 ]; then
		echo $_true
	else
		echo $_false
	fi
}

is_positive(){ # 1=input(output from commands like grep) 
	if [ $(length $1) -gt 0 ]; then
		echo $_true
	else
		echo $_false
	fi
}

is_negative(){ # 1=input(output from commands like grep) 
	if [ $(length $1) -lt 0 ]; then
		echo $_true
	else
		echo $_false
	fi
}

is_empty(){ echo $(is_blank $1); }
not_empty(){ echo $(not_blank $1); }

is_numeric(){ # 1=string
	if [ $(length $(only_numeric $1)) -eq $(length $1) ]; then
		echo $_true
	else
		echo $_false
	fi
} 

is_alphabetic(){ # 1=string
	if [ $(length $(only_alphabetic $1)) -eq $(length $1) ]; then
		echo $_true
	else
		echo $_false
	fi
} 

is_alphanumeric(){ # 1=string
	if [ $(length $(only_alphanumeric $1)) -eq $(length $1) ]; then
		echo $_true
	else
		echo $_false
	fi
} 

is_ascii(){ # 1=string
	if [ $(length $(only_ascii $1)) -eq $(length $1) ]; then
		echo $_true
	else
		echo $_false
	fi
}

is_utf8(){ # 1=string
	if [ $(length $(only_utf8 $1)) -eq $(length $1) ]; then
		echo $_true
	else
		echo $_false
	fi
}
#######################################################################
#### STRING Type ######################################################
#######################################################################
length_above_minimum(){ # 1=string 2=minimum_length
	if [ $(length $1) -lt $2 ]; then
		echo $_true
	else
		echo $_false
	fi
}

length_below_maximum(){ # 1=string 2=maximum_length
	if [ $(length $1) -gt $2 ]; then
		echo $_true
	else
		echo $_false
	fi
}

length_between(){ # 1=string 2=minimum_length 3=maximum_length
	string_length=$(length $1)
	if [ $string_length -gt $2 -a $string_length -lt $3 ]; then
		echo $_true
	else
		echo $_false
	fi
}
#######################################################################
#### NUMBER Type ######################################################
#######################################################################
is_above_minimum(){ # 1=value 2=minimum_value
	if [ $1 -gt $2 ]; then
		echo $_true
	else
		echo $_false
	fi
}

is_below_maximum(){ # 1=value 2=maximum_value
	if [ $1 -lt $2 ]; then
		echo $_true
	else
		echo $_false
	fi
}

is_between(){ # 1=value 2=minimum_value 3=maximum_value
	if [ $1 -lt $2 -o $1 -gt $3 ]; then
		echo $_true
	else
		echo $_false
	fi
}
	#######################################################################
	#### PATH Type ########################################################
	#######################################################################
	path_exists(){ #1=path
		if [ -f $1 -o -d $1 ]; then
			echo $_true
		else
			echo $_false
		fi
	}

file_exists(){ #1=file_path
	if [ -f $1 ]; then
		echo $_true
	else
		echo $_false
	fi
}

directory_exists(){  #1=directory_path
	if [ -d $1 ]; then
		echo $_true
	else
		echo $_false
	fi
}
###########################################################################
# TextUI (Print Helpers)                                                  #
###########################################################################
# Very minimal text user interface elements, such as horizontal lines     #
# basic prompts (yes/no), path, and menu, anything more complex should    #
# rely on higher level languages.                                         #
###########################################################################
#### Simplify ANSI Coloring ###########################################
#######################################################################
black(){  echo "$_ansi_black$1$_ansi_reset"; }   # 1=Text
red(){    echo "$_ansi_red$1$_ansi_reset"; }     # 1=Text
green(){  echo "$_ansi_green$1$_ansi_reset"; }   # 1=Text
yellow(){ echo "$_ansi_yellow$1$_ansi_reset"; }  # 1=Text
purple(){ echo "$_ansi_purple$1$_ansi_reset"; }  # 1=Text
silver(){  echo "$_ansi_silver$1$_ansi_reset"; } # 1=Text
cyan(){   echo "$_ansi_cyan$1$_ansi_reset"; }    # 1=Text
blue(){   echo "$_ansi_blue$1$_ansi_reset"; }    # 1=Text

gray(){   echo "$_ansi_gray$1$_ansi_reset"; }   
white(){  echo "$_ansi_white$1$_ansi_reset"; }  
bright_red(){    echo "$_ansi_bright_red$1$_ansi_reset"; }   
bright_purple(){ echo "$_ansi_bright_purple$1$_ansi_reset"; } 
bright_green(){  echo "$_ansi_bright_green$1$_ansi_reset"; }     
bright_yellow(){ echo "$_ansi_bright_yellow$1$_ansi_reset"; }     
bright_blue(){   echo "$_ansi_bright_blue$1$_ansi_reset"; }     
bright_cyan(){   echo "$_ansi_bright_cyan$1$_ansi_reset"; }     

light(){       echo "$_ansi_light$1$_ansi_reset"; }          
strong(){      echo "$_ansi_strong$1$_ansi_reset"; }         
underline(){   echo "$_ansi_underline$1$_ansi_reset"; }      
crossed_out(){ echo "$_ansi_crossed_out$1$_ansi_reset"; }  

header(){    echo "$_header$1$_reset"; }
subheader(){ echo "$_subheader$1$_reset"; }
strong(){    echo "$_strong$1$_reset"; }            
accent(){    echo "$_accent$1$_reset"; }   
text(){      echo "$_text$1$_reset"; }
success(){   echo "$_success$1$_reset"; }
warning(){   echo "$_warning$1$_reset"; }
fail(){      echo "$_fail$1$_reset"; }
#######################################################################
#### Simplify Log Messages ############################################
#######################################################################
# 1=text 2=color(optional)
brackets(){ echo "$(strong '[')$2$1$(strong ']')"; } 
#parens(){  echo "$(accent '(')$2$1$(accent ')')"; } # 1=text 2=color
#braces(){  echo "$(accent '{')$2$1$(accent '}')"; } # 1=text 2=color
#arrows(){  echo "$(accent '<')$2$1$(accent '>')"; } # 1=text 2=color

log_type_to_string(){ # 1=log_type
	if [ $(length $(only_numeric $1)) -gt 0 ]; then
		if [ $_info_log -eq $1 ]; then 
			echo $(subheader "Info")
		elif [ $_warn_log -eq $1 ]; then 
			echo $(warning "Warn")
		elif [ $_success_log -eq $1 ]; then 
			echo $(success "Success")
		elif [ $_error_log -eq $1 ]; then 
			echo $(fail "Error")
		elif [ $_fatal_log -eq $1 ]; then 
			echo $(fail "Fatal")
		else # $_debug_log
			echo $(header "Debug")
		fi
	else 
		echo $(header $1)
	fi
}

log(){  # 1=log_type 2=message 
	if [ $(length $1) -eq 0 ]; then
		1=$_debug_log
	fi
	_print_log "$1" "$2"
}  

debug_log(){   _print_log "$_debug_log" "$1"; } # 1=message
info_log(){    _print_log "$_info_log" "$1"; }  # 1=message
warn_log(){    _print_log "$_warn_log" "$1"; }  # 1=message 
success_log(){ _print_log "$_success_log" "$1"; }  # 1=message 
error_log(){   _print_log "$_error_log" "$1"; } # 1=message 

fatal_error(){ # 1=message
	_print_log "$_fatal_log" "$1"
	exit 1 
} 

_print_log(){ # 1=log_type 2=message
	echo "$(brackets "$(log_type_to_string "$1")") $(strong "$2")"
}
#######################################################################
#### Simplify Banners #################################################
#######################################################################
horizontal_line(){ # --no-input
	# 80 length
	echo $(strong "===============================================================================")
}

banner(){ # 1=header 2=subheader
	title="$(header "$1")$(white ":") $(light "$(subheader "$2")")"
	echo $title
	horizontal_line
}
