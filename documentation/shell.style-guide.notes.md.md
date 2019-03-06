# Shell ('/bin/sh') Scripting Research And Notes
===============================================================================
*This section is exclusively a shell (`/bin/sh`) style guide for Multiverse OS*
*and will be mandatory guideline for all shell scripts included in Multiverse,*
*all scripts that are maintained my Multiverse developers, and all submitted*
*chages from anyone must either follow this guidelines or modified to follow*
*this style guide.*

**What Shell To Use**
For maximum compatibility with all the various distributions that are used as
service VMs, such as Alpine Linux use in our current iteration of Multiverse
OS routers, to the various controller VMs Linux distrubitons, which currently
is only Debian and Ubuntu, and the final micro/uni-kernels 




===============================================================================
*Below is mixture of style AND general notes and research. It needs to be*
*organized better later*


For now this is not simply a style guide but also a repository for research
and notes regarding shell scripting. 

* * A `sh` function can NOT be empty. So if a script is emptied for development
    purposes, for example, the content is commented out. You must comment out
    the ENTIRE function including declaration, and if that function is used 
    elsewhere then and would break things, then an `echo` needs to be\
    temporarily added so that there is something inside the function. This is
    worth noting because `sh` essentially provides no errors or information 
    when things do not interpret (maybe we can in the future provide a sh
    interpreter that lints, and possibly one that provides color output
    and better errors.
   

* * The preferred way to handle the way to boolean checking, ideally this would
    also be apart of then sh framework so that the actual function can be 
    managed within the framework and functions in the script would just pass
    the value the developer needs checked and assign it local
	`if_bool(){ `echo "$($BOOL)"; }`

* *(This may not be preferred, it may be better to stick with)*
  *(single line if calls, and just using
  **Instead of using the bulky if [ x -eq y ]; then ...** block
  statements, (ONLY IF ITS ALSO INCLUDED IN ALPINE) a developer
  can use: `
      `test -f "~/.ssh/id_rsa`

  and the commands that would be:
      `test -f ~/.vimrc && echo "appears vimrc exists, cool."


* **New best practice for handling and naming argument variables**
  so that they become human readable soon as possible, while 
  standardizing at the very least a validation step that 
  does insanity checks based on expected data type.

````
	# TODO: I like this use of validation, returning the 
	# value if its validated, possibly transformed, possibly
	# downcased. This is cleaner and puts our argument in
	# a variable that is human readable instead of leaving it
	# in  a argument number that says nothinga bout what it 
	# contains. 
	# I believe that `sh` best practice should become every
	# function with arguments (almost all), first thing passes
	# each argument to the appropriate validate function. To
	# do insanity checks based on its value. Then return it
	# for it to be assigned to a variable name that describes
	# the validated content.	
	ARG=$(validate_arguments $1)
````
* **Get value from user using the `REST` command; similar to Ruby's
  `gets` command.** ALWAYS validate input, in fact to guarantee 
   at the very least that every user input is at least validated
   with insaniy checks based on basic type validation.
   
   Ideally, a style of declaration of user input variable name
   can and will include declation of possibly set of valid characters
   such as alphabetic or alphanumeric, or if a number explicit
   variableName_MIN and variableName_MAX or variableName_BETWEEN "5 10"
   can be essential parts of the developing MUltiverse OS Shelwl 
   style guide that variable specific validations can be apart of 
   the procss. Like how in Go if we wanted to gaurantee these
   min and amx values were always included they woulld be apart of 
   the struct and resulted in an error if they were not defined. 


