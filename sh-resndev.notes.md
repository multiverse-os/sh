# Shell ('/bin/sh') Scripting Research And Notes
===============================================================================

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

