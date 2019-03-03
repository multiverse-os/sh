###############################################################################
## Multiverse OS Shell Framework
###############################################################################
# The shell framework is a modular shell framework that centralizes security
# critical components and include testing suite that provides some assurance
# that features important to software security function;.
#
# Security critical shell components include: file IO, user input, OS
# interaction (comprised of OS user management, terminal IO with text coloring
# and text based iamges/tables/graphs (sometimes referred to as "ASCII art"
# or "Macros").
# 
# Below are the files included in the framework; the entire framework, with
# all modules can be imported, or any number of modules can be imported
# together or indvidiually. 

#==============================================================================
# HOW TO USE
#------------------------------------------------------------------------------
# Import the full framework and all modules by importing the primary
# shell framework file, passing "ALL" after the filename:
#
# **Importing Shell Source Code [libraries, frameworks]**
# The 'source' command takes a path the a shell file, and if ran from a shell
# script effectively imports all the code in the file that is being called byh
# 'source' By defaul in Debian, 'source' command has the alias '.' as shorthand
# and under Multiverse OS, 'source' command has the alias 'import_sh' to be a
# human readable method of importing shell files. 
# 
# **Simplifying importation of shell framework source code**
# To simplify the process of importing the shell framework even further, by
# default Multiverse OS provides an additional line in your user account's
# `~/.bashrc` file. This line provides an environemtanl variable (or 'env'). 
# To see all activated environmental variables for a session, execute the 
# 'env' command, and a list of active environmental variables will be shown.
# To add an environmental variable on-the-fly simply export the shell variable
# in terminal using the 'export' command:
#   export SH_FRAMEWORK="~/.local/share/sh/framework.sh


## TODO: It would be nice to simply include all modules by passing:
#    import_sh $SH_FRAMEWORK "all"
#
#  TODO: Then the API could allow for individual importation of modules using:
#    # For example, to import 'vm', 'os', and 'io' modules
#    import_sh $SH_FRAMEWORK "vm os io"
#
#  TODO: And to import a single module:
#    # For example, to import only 'vm' module
#    import_sh $SH_FRAMEWORK "vm"


##-----------------------------------------------------------------------------
## Framework and Available Moduels 
##-----------------------------------------------------------------------------
## /sh/framework.sh
#################################
## /sh/modules/
## /sh/modules/globals.sh


## Pulled from source, is more relevant for explaining how the shell bashrc 
## ugprades work how to install and upgrade them.


main(){
	append_to_bashrc "\n\n# Multiverse OS: Shell ('/bin/sh') Import Alias, Function, and Variable"
	append_to_bashrc "#================================================================================\n"
	append_to_bashrc "# The alias, function, and variable combination provided below allow importing    "
	append_to_bashrc "# shell framework easily. These components enable Multiverse developers and users "
	append_to_bashrc "# to very easily define exactly what modules are included.                        "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "# Environmental Variable (env) storing shell framework path                       "
	append_to_bashrc "#----------------------------------------------------------                       "
	append_to_bashrc "export SH_FRAMEWORK=\"$SH_FRAMEWORK\"                                            \n"
	append_to_bashrc "                                                                                  "
        append_to_bashrc "                                                                                  "
	append_to_bashrc "```'/bin/sh'                                                                      "
	append_to_bashrc "\#!/bin/sh                                                                        "
	append_to_bashrc "\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#	                                            "
	append_to_bashrc "import_sh $SH_FRAMEWORK "all"                                                  \n\n" 
	append_to_bashrc "...[shell source code here]...                                                   \n"
	append_to_bashrc "```                                                                              \n"
	append_to_bashrc "                                                                                  "

	

}


#------------------------------------------------------------------------------
#Execute
main

#!/bin/sh
###############################################################################
## Multiverse OS: Install
##=============================================================================
#VARIABLE(s)
#------------------------------------------------------------------------------
##PATH(s)
BASHRC="~/.bashrc"
SH_FRAMEWORK="~/.local/share/sh/framework.sh"

#FUNCTION(s)
#------------------------------------------------------------------------------
append_to_file(){
	echo "$1" >> $2
} 

append_to_bashrc(){
	append_to_file $1 >> $BASHRC
}


#------------------------------------------------------------------------------
main(){
	append_to_bashrc "##================================================================================"
	append_to_bashrc "## Multiverse OS: Shell ('/bin/sh') Import Alias, Function, and Variable          "
	append_to_bashrc "##================================================================================"
	append_to_bashrc "## Import Upgrade Installation Summary: explanation of changes to `~/.bashrc`     "
	append_to_bashrc "##--------------------------------------------------------------------------------"
	append_to_bashrc "#   The shell scripting import upgrade provided by either installing Multiverse OS"
	append_to_bashrc "# or by installing using the shell script in the shell framework git repository   "
	append_to_bashrc "# currently available at: `https://github.com/multiverse-os/sh`.                  "
	append_to_bashrc "#                                                                                 "
        append_to_bashrc "#   Either using the installation script in the repository or installed during the"
	append_to_bashrc "# Multiverse OS installation process results in the same outcome: three (3) lines "
        append_to_bashrc "# are appended to the end of the user's `~/.basrc` file.                          "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "#   The three installed lines work in tandem to provide a substantial upgrade to  "
	append_to_bashrc "# the way shell scripts are able to import other shell scripts; this change adds  "
        append_to_bashrc "# an alternative to the original `source` and `,` methods of importing shell files"
        append_to_bashrc "# and the original way is unaffected by this new change and can still be used.    "
	append_to_bashrc "#   The three shell components that make up the upgrade are:                      "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "#   An `env` (environemntal variable) using the `export` command. a `sh` function "
	append_to_bashrc "# using the the previously defined `env` to import the `sh` framework that passes "
        append_to_bashrc "# additional data to the `sh` script being imported.                              "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "#   And using the `alias` command, the previously defined `sh` function is        "
	append_to_bashrc "# improved by both simplifying the syntax, which improves the human readability.  "
        append_to_bashrc "# The `alias` encapsulates the previously defined `sh` function, to provide a     "
        append_to_bashrc "# better syntax, and a second parameter for arbitrary data.                       "
	append_to_bashrc "#                                                                                 "
        append_to_bashrc "#   Most importantly, the upgrade adds a second paramter in our import definition,"
        append_to_bashrc "# enabling developers to pass arbitrary data to the shell script being imported.  "
	append_to_bashrc "# The data is only used by the imported script, if it contains a corresponding    "
	append_to_bashrc "# as the one defined in the `sh` function definition.                             "
	append_to_bashrc "#                                                                                 "
        append_to_bashrc "#   The shell script import definition like a normal shell function, the `alias`  "
        append_to_bashrc "# name followed by two paramters:                                                 "
	append_to_bashrc "#     1) The path to the script, library, or framework that will be imported      "
	append_to_bashrc "#     2) The string or int data that is passed to the shell script, library, or   "
	append_to_bashrc "#        shell framework when the file defined in the path is loaded.             "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "#   The second parameter, used to pass data to the imported shell script, is used "
	append_to_bashrc "# by the shell framework to define which modules to include with the minimal shell"
	append_to_bashrc "# framework base. The second paramter can be either: \"all\", which imports the   "
	append_to_bashrc "# the shell framework, and all working modules in the `~/.local/share/sh/modules` "
	append_to_bashrc "# folder:                                                                         "
	append_to_bashrc "#                                                                                 "
        append_to_bashrc "#     `import_sh	\"~/.local/share/sh/framework.sh\" \"all\"`                 "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "#   OR by by providing nothing or an empty string to not load any modules:        "
        append_to_bashrc "#	                                                                            "
        append_to_bashrc "#     `import_sh	\"~/.local/share/sh/framework.sh\"`                         "
        append_to_bashrc "#	                                                                            "
	append_to_bashrc "#   OR by by providing nothing or an empty string to not load any modules:        "
        append_to_bashrc "#	                                                                            "
        append_to_bashrc "#     `import_sh	\"~/.local/share/sh/framework.sh\" \"vm io kvm\"`           "
        append_to_bashrc "#	                                                                            "
	append_to_bashrc "# TODO: Maybe use `import_script` for import that is human readable without added "
	append_to_bashrc "#       added data. And use `import_framework` for an import that includes added  "
	append_to_bashrc "#       data field. But then again, arbitrary data may be useful in use cases out "
	append_to_bashrc "#       side the range of just frameworks.                                        "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "#                                                                                 "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "##################################################################################"
	append_to_bashrc "## [Multivers: Shell Scripting Import Upgrade                                     "
	append_to_bashrc "##================================================================================"
	append_to_bashrc "# Environmental Variable (env): shell framework path                              "
	append_to_bashrc "#----------------------------------------------------------------                 "
	append_to_bashrc "export SH_FRAMEWORK=\"$SH_FRAMEWORK\"                                             "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "# `sh` Function: add paramter to pass data to imported file                       "
	append_to_bashrc "#----------------------------------------------------------------                 "
	append_to_bashrc "export SH_FRAMEWORK=\"$SH_FRAMEWORK\"                                             "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "# Environmental Variable (env) storing shell framework path                       "
	append_to_bashrc "#----------------------------------------------------------                       "
	append_to_bashrc "export SH_FRAMEWORK=\"$SH_FRAMEWORK\"                                             "
	append_to_bashrc "                                                                                  "
	append_to_bashrc "                                                                                  "
        append_to_bashrc "                                                                                  "
	append_to_bashrc "```'/bin/sh'                                                                      "
	append_to_bashrc "\#!/bin/sh                                                                        "
	append_to_bashrc "\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#	                                            "
	append_to_bashrc "import_sh $SH_FRAMEWORK "all"                                                  \n\n" 
	append_to_bashrc "...[shell source code here]...                                                   \n"
	append_to_bashrc "```                                                                              \n"
	append_to_bashrc "                                                                                  "

	

}


#------------------------------------------------------------------------------
#Execute
main


echo  >>
load_framework(){
  echo "attempting to run command: MODULES=$2 . ./$1"
  MODULES=$2 . ./$1
}
alias import_shell="load_framework"

import_shell test_lib.sh "mega test"
