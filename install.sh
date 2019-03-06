#!/bin/sh
##==============================================================================
## Install Default Configuration
##------------------------------------------------------------------------------
framework_repository="https://github.com/multiverse-os/sh"
local_share_path="~/.local/share/"
framework_path="sh/"
framework_basename="framework.sh"
framework_relative_path="$framework_path$framework_basename"
framework_full_path="$local_share_path$framework_relative_path"
sh_config_path="~/.bashrc"
install_dependencies="git" # space separated *.deb dependencies
##==[ Task List ]===============================================================
## TODO: In the future, add loading of configuration via YAML or perhaps, 
##       by command line flags, and if not specified, then prompt the user
##       for input
## TODO: Use method that just uses text file directly so an http request via
##       and already installed program can be used.


print_banner(){
	echo "Multiverse OS: Framework Installation"
	echo "================================================================================"
	echo "[$framework_relative_path] Shell framework will check if already exists,..."
}


##==[ Framework Installation ]==================================================
main(){
	## [Step 1]: Checking if 'git' exists; if NOT then installk ############
	if uname -a | grep -Fqe "Debian"; then
		package_manager="apt"
	elif uname -a | grep -Fqe "Alpine"; then
		package_manager="apk"
	fi
	echo "[$framework_relative_path] Confirming required installation dependencies are installed: $install_dependencies"
	#if git | grep -Fqe "usage"; then
		sudo apt-get -y install install $install_dependencies
	#else
	#	echo -e "[$framework_relative_path] Dependencies already installed, pulling repository into the local user share folder."
	#fi
	#
	## [Step 2]: Checking if framework is installed, if NOT then clone #####
	#
	if [ -z "$framework_full_path" ]; then
		echo "[$framework_relative_path] Bourne shell framework will check installation already exists."
	else
		echo "[$framework_relative_path] Bourne shell framework NOT installed, cloning repository into: $framework_full_path"
		git clone $framework_repository $framework_full_path
	fi
	if printf '%s\n\' "$1" | grep -Fqe "export SH_FRAMEWORK"; then
		echo "~/.bashrc part of the installation ALREADY exists!!"
	else
		echo -e ""                                                                                 >> ~/.bashrc
		echo -e "## Multiverse OS: Bourne Shell Framework Import Syntax Patch"                     >> ~/.bashrc
		echo -e "################################################################################" >> ~/.bashrc
		echo -e "## SH_FRAMEWORK environmental variable is set to simplify import"                 >> ~/.bashrc
		echo -e "## delclarations "                                                                >> ~/.bashrc
		echo -e "#"                                                                                >> ~/.bashrc
		echo -e ""                                                                                 >> ~/.bashrc
		echo -e ""                                                                                 >> ~/.bashrc
		echo -e "export SH_FRAMEWORK=\"\$SH_FRAMEWORK\""                                           >> ~/.bashrc
		echo -e "import_script_with_data\(\){"                                                     >> ~/.bashrc
		echo -e "SH_IMPORT_PARAMETER=\$2 . ./\$1"                                                  >> ~/.bashrc
		echo -e "}"                                                                                >> ~/.bashrc
		echo -e "alias sh_import=\"import_script_with_data\""                                      >> ~/.bashrc
		echo -e ""                                                                                 >> ~/.bashrc
	fi
}

##[ Executing main function ]##################################################
main
