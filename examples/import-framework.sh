#!/bin/sh
 
## Using Multiverse OS Shell Framework
## ===================================
##
## Below is a simplified example of how to use the minimalistic
## Multiverse OS shell framework. 
##

SH_FRAMEWORK="/home/user/multiverse/scripts/sh-framework"

## IMPORT
. $SH_FRAMEWORK/sh-framework.sh

## NOTE Here is another instance where switching the multiverse-os
## repository to /var/multiverse would feel more natural, while at
## the same time, shrinking the accessible attack surface from 
## potential directory transveral attacks. 

## From a Controller VM, the import path would be different, since
## we mount shared storage in a way that they appear as individual 
## hard disks on the Controller VM using the following path:

#. /media/user/MultiverseOS/scripts/sh/mvos-framework.sh 

# This location also feels much more natural when importing too,
# since its not pointing at an individual users home folder. However
# /var/multiverse/scripts/sh/mvos-framework would be the best 
# import path, and should be the path in the future after the next
# restructuring. 


echo "Testing import of framework was successful by calling"
echo $header"FUNCTION:$reset print_banner() $text with string 'test'"$reset


print_banner "test"

