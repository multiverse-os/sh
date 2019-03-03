#!/bin/sh
###############################################################################
## Multiverse OS: Install
##=============================================================================
# VARIABLE(s)
#------------------------------------------------------------------------------
debug=0
verbose=0
current_user=$(whoami)

##PATH(s)
home="/home/$current_user"
bashrc="$home/.bashrc"
SH_FRAMEWORK="$home/.local/share/sh/framework.sh"
#==============================================================================
# FUNCTION(s)
#------------------------------------------------------------------------------
##OPERATING STATUS
is_verbose_mode(){
	if [ -z $verbose ]; then
		return 0
	else
		return 1
	fi
}

is_debug_mode(){
	if [ -z $debug ]; then
		return 0
	else
		return 1
	fi
}

##PRINT TEXT
print_append_info(){
	echo "Attempting to apend string: \"$1\" to file \"$2\""
}

##FILE I/O FUNCTION(s)
length(){
	echo ${#1}
}

## TODO should always return result of the if statement not check then
##      ouput separate value. Only like this for speed.
exists(){
	if [ -z $bashrc ]; then
		return 0
	else
		return 1
	fi
}

## TODO: Not ideal because they are doing string comparsion
append_to_file(){
	if [ "$(is_debug_mode)" = "1" ]; then
		print_append_info $1 $2
	fi
	#echo "[DEV OUTPUT] Can't do \$echo \"\$1\" >> \"\$2\""
	echo "$(echo \"\$1\" >> \"\$2\")"
} 

append_to_bashrc(){
	if [ "$(is_debug_mode)" = "1" ]; then
		print_append_info $1 $bashrc
	fi
	append_to_file "$1" >>"$bashrc"
}

append_import_sh_patch(){
	echo "Attempting to append \"\`import_sh\` patch\" to \`$bashrc\`; in order to enable passing data to imported file."
	#echo "[DEV OUTPUT] Attempting manual append"
	
	#append_to_bashrc "export SH_FRAMEWORK=\"\$SH_FRAMEWORK\""
	echo "Calling `source` command on \`$bashrc\` to activate changes made by patch."
	source $bashrc

	echo "SH_FRAMEWORK is \"$SH_FRAMEWORK\""
	echo "Length of $(length $SH_FRAMEWORK) SH_FRAMEWORK variable that is supposed to be set in ~/.bashrc"

#	if [ $(length $SH_FRAMEWO
	## TODO: NOW test if everything was successful by checking if $SH_FRAMEWORK is empty/lengtg=0

}


# 1) append_to_bashrc "export SH_FRAMEWORK=\"\$SH_FRAMEWORK\""

# 2) append_to_bashrc "load_framework\(\){"
# 2) append_to_bashrc "	echo \"attempting to run command: MODULES=\$2 . ./\$1\""
# 2) append_to_bashrc "	MODULES=\$2 . ./\$1                                     "
# 2) append_to_bashrc "}                                                                                 "

# 3) append_to_bashrc "alias import_shell=\"load_framework\"                                             "

#==============================================================================
# MAIN_LOOP
#------------------------------------------------------------------------------

# NOTE: Must be completely commented out, software will fail with bad errors
# if the function is incomplete.
#append_verbose_helptext(){
#append_to_bashrc "##================================================================================"
#append_to_bashrc "## Multiverse OS: Shell \(\'/bin\/sh\'\) Import Alias, Function, and Variable     "
#append_to_bashrc "##================================================================================"
#append_to_bashrc "## Import Upgrade Installation Summary: explanation of changes to \`~/.bashrc\`   "
#append_to_bashrc "##--------------------------------------------------------------------------------"
#append_to_bashrc "#   The shell scripting import upgrade provided by either installing Multiverse OS"
#append_to_bashrc "# or by installing using the shell script in the shell framework git repository   "
#append_to_bashrc "# currently available at: \'https://github.com/multiverse-os/sh\`.                "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   Either using the installation script in the repository or installed during the"
#append_to_bashrc "# Multiverse OS installation process results in the same outcome: three \(3\) lines"
#append_to_bashrc "# are appended to the end of the user\'s \`~/.basrc\` file.                       "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   The three installed lines work in tandem to provide a substantial upgrade to  "
#append_to_bashrc "# the way shell scripts are able to import other shell scripts\; this change adds  "
#append_to_bashrc "# an alternative to the original \`source\` and \`.\` methods of importing shell files"
#append_to_bashrc "# and the original way is unaffected by this new change and can still be used.    "
#append_to_bashrc "#   The three shell components that make up the upgrade are:                      "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   An \`env\` \(environemntal variable\) using the \`export\` command. a \`sh\` function"
#append_to_bashrc "# using the the previously defined \`env\` to import the \`sh\` framework that passes"
#append_to_bashrc "# additional data to the \`sh\` script being imported.                            "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   And using the \`alias\` command, the previously defined \`sh\` function is    "
#append_to_bashrc "# improved by both simplifying the syntax, which improves the human readability.  "
#append_to_bashrc "# The \`alias\` encapsulates the previously defined \`sh\` function, to provide a "
#append_to_bashrc "# better syntax, and a second parameter for arbitrary data.                       "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   Most importantly, the upgrade adds a second paramter in our import definition,"
#append_to_bashrc "# enabling developers to pass arbitrary data to the shell script being imported.  "
#append_to_bashrc "# The data is only used by the imported script, if it contains a corresponding    "
#append_to_bashrc "# as the one defined in the \`sh\` function definition.                           "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   The shell script import definition like a normal shell function, the \`alias\`"
#append_to_bashrc "# name followed by two paramters:                                                 "
#append_to_bashrc "#     1\) The path to the script, library, or framework that will be imported     "
#append_to_bashrc "#     2\) The string or int data that is passed to the shell script, library, or  "
#append_to_bashrc "#        shell framework when the file defined in the path is loaded.             "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   The second parameter, used to pass data to the imported shell script, is used "
#append_to_bashrc "# by the shell framework to define which modules to include with the minimal shell"
#append_to_bashrc "# framework base. The second paramter can be either: \"all\", which imports the   "
#append_to_bashrc "# the shell framework, and all working modules in the \`~/.local/share/sh/modules\`"
#append_to_bashrc "# folder:                                                                         "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#     \`import_sh	\"~/.local/share/sh/framework.sh\" \"all\"\`                "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#   OR by by providing nothing or an empty string to not load any modules:        "
#append_to_bashrc "#	                                                                            "
#append_to_bashrc "#     \`import_sh	\"~/.local/share/sh/framework.sh\"\`                        "
#append_to_bashrc "#	                                                                            "
#append_to_bashrc "#   OR by by providing nothing or an empty string to not load any modules:        "
#append_to_bashrc "#	                                                                            "
#append_to_bashrc "#     \`import_sh	\"~/.local/share/sh/framework.sh\" \"vm io kvm\"\`          "
#append_to_bashrc "#	                                                                            "
#append_to_bashrc "# TODO: Maybe use \`import_script\` for import that is human readable without added"
#append_to_bashrc "#       added data. And use \`import_framework\` for an import that includes added"
#append_to_bashrc "#       data field. But then again, arbitrary data may be useful in use cases out "
#append_to_bashrc "#       side the range of just frameworks.                                        "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "#                                                                                 "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "##################################################################################"
#append_to_bashrc "## Multivers: Shell Scripting Import Upgrade                                      "
#append_to_bashrc "##================================================================================"
#append_to_bashrc "# Environmental Variable \(env\): shell framework path                            "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "                                                                                  "
#append_to_bashrc "export SH_FRAMEWORK=\"\$SH_FRAMEWORK\"                                             "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "# \`sh\` Function: add paramter to pass data to imported file                     "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "                                                                                  "
#append_to_bashrc "load_framework\(\){                                                               "
#append_to_bashrc "	echo \"attempting to run command: MODULES=\$2 . ./\$1\"                       "
#append_to_bashrc "	MODULES=\$2 . ./\$1                                                           "
#append_to_bashrc "}                                                                                 "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "# Environmental Variable \(env\) storing shell framework path                     "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "                                                                                  "
#append_to_bashrc "alias import_shell=\"load_framework\"                                             "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "                                                                                  "
#append_to_bashrc "\`\`\`\'/bin/sh\'                                                                 "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "# Example Usage Called At Top Of Shell Script                                     "
#append_to_bashrc "#---------------------------------------------------------------------------------"
#append_to_bashrc "\#!/bin/sh                                                                        "
#append_to_bashrc "\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#	                                            "
#append_to_bashrc "import_sh \$SH_FRAMEWORK \"all\"                                                \n\n" 
#append_to_bashrc "...\[shell source code here\]...                                                 \n"
#append_to_bashrc "\`\`\                                                                            \n"
#append_to_bashrc "                                                                                  "
#}

#==============================================================================
# MAIN_LOOP
#------------------------------------------------------------------------------

## TODO: Add ability to pass flags that set 'verbose' mode, and 'debug' mode
## from command-line.

main(){
	#if [ $(is_verbose) -eq 1]; then
	#	append_verbose_helptext
	#fi
	append_import_sh_patch
}


#[ Execute ]==================================================================
main

