#!/bin/sh
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

## Global Variables
##============================================================================
PACKAGE_DEPS="git" # Space separated if more than 1, then use cut to split
CURRENT_USER=$(whoami)
BASHRC="~/.bashrc"
#OS
HIDE_ERRORS="2>/dev/null"
#UI
##INSTALL STEPS
STEP_COMPLETED="$accent'................................................................$reset$text  [$reset$success OK$reset$text ]$reset"

##============================================================================
## Global Function(s)
##============================================================================
print_banner(){
	echo $header"Multiverse OS$reset$text:$reset$strong Shell Framework Installer"$reset
	echo $accent"==============================================================================="$reset
	echo $accent"Installer to provide consistent method of installation that will guide future"$reset
	echo $accent"shell framework installation during alpha installation.\n"$reset
}

print_without_errors(){
	echo "$1"$HIDE_ERRORS
}

print_step(){
	echo $text"[$reset$header STEP $1$reset$text] $2:$reset$accent  .....................$reset$text  [$reset$accent$3$reset$text]"$reset
}

##-----------------------------------------------------------------------------
is_root(){
  if [ $CURRENT_USER -ne "root" ]; then
    echo $fail"[Error]$reset$accent Must be logged in as root. Run 'su' and try again."$reset
    exit 0
  fi
}
##-----------------------------------------------------------------------------
#DO ACTION
do_action(){
	$1
	print_without_errors $1


}


##-----------------------------------------------------------------------------
#STEP FUNCTIONS
do_step(){ # 1=StepNumber 2=StepDescription 3=StepValue 4=Action
  step_print $1 $2 $3
  do_action $4
  # TODO: Advanced version would check if sucessful and print completed or fail
  echo "$STEP_COMPLETED"

}


##============================================================================
## main() Function
##============================================================================
main() {
	print_banner
	# INSTALLATION STEPS
	#=====================================================================
	# STEP FUNCTION INFO
	# do_step $StepNumber $StepDescription $StepValue $Action
        #---------------------------------------------------------------------
	# STEP 1: Install *.deb package dependencies
	do_step 1 "Install \*.deb package dependencies" "$PACKAGE_DEPS" "sudo apt-get install $PACKAGE_DEPS"


	# STEP 2: Git clone repository into '~/.local/share/'
	do_step 2 "Clone repo:'github.com/multiverse-os/sh' to ~/.local/share/" "git" "cd ~/.local/share/ && git clone https://github.com/multiverse-os/sh"


	# STEP 3: Install ENV variable in '~/.bashrc'
	do_step 2 "Install \$SH_FRAMEWORK 'env' variable in '~/.bashrc'" "sh" "echo \"export SH_FRAMEWORK=\"~/.local/share/sh/framework.sh\"\" >> ~/.bashrc && "



	echo "Adding ENV (environmental variable): SH_FRAMEWORK"




	export SH_FRAMEWORK="/var/multiverse/sh/framework.sh"
	load_framework(){
		echo "attempting to run command: MODULES=$2 . ./$1"
		MODULES=$2 . ./$1
	}
	alias import_shell="load_framework"



}

##==[ EXECUTION ]=============================================================##
main

