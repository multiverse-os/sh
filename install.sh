#!/bin/sh
###############################################################################
. ./framework.sh 
# Adds 513 lines, which is important for locating errors                  
###############################################################################
# Globals                                                                     #
###############################################################################
_data_path="$HOME/.local/share/"
_config_path="$HOME/.config/"

_sh_filename="framework.sh"
_sh_directory="sh"
_sh_repository="https://github.com/multiverse-os/sh"
_sh_data="$_data_path$_sh_directory/"
_sh_config="$_config_path$_sh_directory/"

_sh_dependencies="git" # space separated *.deb dependencies

sh_framework="$_sh_data$_sh_filename"

debug(){ # --no-input--
	echo ".--[DEBUG]---------."
	echo "| framework:       |"
	echo "| $sh_framework     "
	echo "| name:            |"
	echo "| $_sh_filename     "
	echo "| directory:       |"
	echo "| $_sh_directory    "
	echo "| repository:      |"
	echo "| $_sh_repository   "
	echo "| data path:       |"
	echo "| $_sh_data         "
	echo "| config path:     |"
	echo "| $_sh_config       "
	echo "'__________________'"
}

###############################################################################
# Package Manager                                                             #
###############################################################################
# NOTE Ideally this should be migrated into its own file and used as a 
#      or module of this framework.
_pm="apt" # Default to 'apt', Debian/Ubuntu package manager

## PM Enumerator (Prevents unncessary string comparisons)
_apt=0
_apk=1
_dnf=2

## Action Enumerator (Prevents unncessary string comparisons)
_update=0
_install=1

## Action Functions
detect_package_manager(){ # --no-input--
	if [ $(length $(uname -a | grep "Debian")) -gt 0 ]; then
		echo 0
	elif [ $(length $(uname -a | grep "Alpine")) -gt 0 ]; then 
		echo 1
	else
		fatal_error "Could not determine the package manager!"
	fi
}

package_manager(){ # 1=action 2=packages(optional)
	if [ $_update -eq $1 -a $(length $(only_numeric $_pm)) -gt 0 ]; then
		log $_pm "Updating the package manager..."
		if [ $_apt -eq $_pm ]; then
			sudo apt-get update
		elif [ $_pm -eq $_pm ]; then
			sudo apk update
		else 
			fatal "Defined package manager is not supported."
		fi
	elif [ $_install -eq $1 ]; then
		log "$_pm" "Installing package..."
		if [ $_pm -eq $_apt ]; then
			shift
			sudo apt-get install $@
		elif [ $_pm -eq $_apk ]; then
			shift
			sudo apk add $@
		else 
			fatal_error "Defined package manager is not supported."
		fi
	else
		error_log "Package manager action is not supported."
	fi
}

###############################################################################
# Framework Installation                                                      #
###############################################################################
# Dependent Binaries: [tr, echo, git] # Eventually gpg. 
main(){ # --no-input--
	banner "Multiverse OS" "Sh(ell) Framework Installation"
	#######################################################################
	# Confirm Install Dependencies Exist                                  #
	#######################################################################
	log $_sh_filename "Checking for dependencies: $_sh_dependencies"
	if [ $(length $(git | grep "git help")) -gt 0 ]; then
		log $_sh_filename " Dependencies are already installed..."
	else
		log $_sh_filename " Dependencies missing, updating and installng..."
		_pm=$(detect_package_manager)
		package_manager $_update
		package_manager $_install $_sh_dependencies
	fi
	#######################################################################
	success_log "Dependencies successfully installed!"

	#######################################################################
	# Install Shell Framework Files                                       #
	#######################################################################
	cp -rf * $_sh_data
	#if [ -f $_sh_config$_sh_filename ]; then
	#	log $_sh_filename "Sh(ell) framework already exists."
	#	log $_sh_filename "Pulling down changes from git repository..."
	#	cd $_sh_data && git pull
	#else
	#	log $_sh_filename "No existing installation..."
	#	log $_sh_filename "Creating default config path & data path."
	#	if [ -d $_sh_data ]; then
	#		rm -rf $_sh_data
	#	fi
	#	mkdir -p $_sh_data
	#	if [ -d $_sh_config ]; then
	#		rm -rf $_sh_config
	#	fi
	#	mkdir -p $_sh_config
	#	git clone $_sh_repository $_sh_data
	#fi
	#######################################################################
	success_log "'sh' successfully installed in local user data path!"

	#######################################################################
	# Add Configuration To '~./bashrc'                                    #
	#######################################################################
	if [ $(length "$(grep "export SH_FRAMEWORK" ~/.bashrc)") -gt 0 ]; then
		log $_sh_filename "'~/.bashrc' entry exists."
	else
		log $_sh_filename "Adding helpers/env variable in '~/.bashrc'"
		echo "" >> ~/.bashrc
		echo "###############################################################################" >> ~/.bashrc
		echo "# Shell Framework                                                             #" >> ~/.bashrc
		echo "###############################################################################" >> ~/.bashrc
		echo "export SH_FRAMEWORK=\"$_sh_data$_sh_filename\"" >> ~/.bashrc
		echo "sh_import(){" >> ~/.bashrc
		echo "    SH_IMPORT_PARAMETER=\$2 . ./\$1" >> ~/.bashrc
		echo "}" >> ~/.bashrc
		echo "" >> ~/.bashrc
		echo "alias import=\"sh_import\"" >> ~/.bashrc
		echo "" >> ~/.bashrc
	fi
	#######################################################################
	success_log "Shell configuration completed!"
}

#### Executing main function ##################################################
main
success_log "Installation Completed!"


# Old style may be useful in the near future
#echo -e ""                                                                                 >> ~/.bashrc
#echo -e "## Multiverse OS: Bourne Shell Framework Import Syntax Patch"                     >> ~/.bashrc
#echo -e "################################################################################" >> ~/.bashrc
#echo -e "## SH_FRAMEWORK environmental variable is set to simplify import"                 >> ~/.bashrc
#echo -e "## delclarations "                                                                >> ~/.bashrc
#echo -e "#"                                                                                >> ~/.bashrc
#echo -e ""                                                                                 >> ~/.bashrc
#echo -e ""                                                                                 >> ~/.bashrc
#echo -e "export SH_FRAMEWORK=\"\$SH_FRAMEWORK\""                                           >> ~/.bashrc
#echo -e "import_script_with_data\(\){"                                                     >> ~/.bashrc
#echo -e "SH_IMPORT_PARAMETER=\$2 . ./\$1"                                                  >> ~/.bashrc
#echo -e "}"                                                                                >> ~/.bashrc
#echo -e "alias sh_import=\"import_script_with_data\""                                      >> ~/.bashrc
