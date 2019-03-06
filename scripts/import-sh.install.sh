##===========================================================================
## Can be used for VERY simple manual installation if issues arise
##---------------------------------------------------------------------------
#

## TODO: Future installations need to check if the lines exist and skip installation if
##       they already exist

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
