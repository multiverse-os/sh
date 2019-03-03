#!/bin/sh

## ======================================
##
##  Multiverse OS: Shell Framework
##  Module: Linux Management
## ======================================
pci_address_lookup(){
  echo $(lspci -nn | grep $1 | cut -c -7)
}

kernel_module_lookup(){
  echo $(lspci -knn | grep $1 -A 3 | grep modules | cut -c 18-)
}

kernel_driver_lookup(){
  echo $(lspci -knn | grep $1 -A 2 | grep driver | cut -c 24-)
}

