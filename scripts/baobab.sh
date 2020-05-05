#!/bin/sh
###############################################################################











echo "Multiverse OS: Large file locator"
echo "==================================="
echo "Analyzing file tree for large files..."

# A very simple 1 link implementation of baobab like functionality 
# (i.e. finding the biggest files in the fs) using only tree+grep
# TODO: Add coloring to items that have G subdue the rest if they are shown. Or perhaps if 10+ exists or 100+ then gradient across less than 10, greater than 10, less than 100, greater than 100. Convert tool to Go.
tree / -lah | grep 'G]'
