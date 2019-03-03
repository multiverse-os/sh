#!/bin/sh

length(){
	echo ${#1}
}
## ======================================
##
##  Multiverse OS: Shell Framework
##  Module: 'vfio' PCI Passthrough
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

bind_device_with_sysfs(){
  echo $( echo "$1" | sed 's/:/ /') > /sys/bus/pci/drivers/vfio-pci/new_id
}

# TODO: unbind device from host machine kernel

assign_device_qemu_bridge_permissions(){
  # After QEMU is updated, these permissions will need to be updated
  chown -R root:kvm /usr/lib/qemu/
  chmod 4750 /usr/lib/qemu/qemu-bridge-helper
}

assign_device_config_space_permissions(){
  # Debian Buster introduced an error with config space permissions
  # that is no present in Debian Stretch. Below is a hack solution
  # to correct the permissions to allow forward movement on
  # Multiverse OS development.
  chown root:kvm $1
  chmod 0660 $1
}

blacklist_kernel_module(){
  touch /etc/modprobe.d/multiverse.conf
  echo "blacklist $1" >> /etc/modprobe.d/multiverse.conf
}


## ==========================================================
##
##   Bind Device with DEVICE_ID to vfio-pci for passthrough
## ----------------------------------------------------------
CURRENT_USER=$(whoami)
if [ $CURRENT_USER = "user" ]; then
  echo $fail"[Error] Must be logged in as root. Run 'su' and try again."$reset
  exit 0
fi

##
##  Device List Index File Example
## ===============================
## One may find device list indexes indicating what PCI devices are
## associated with a spcific piece of hardware. Concating the created
## device lists for all matching hardware, will be initialized by
## running the below function on each line.
##
## usb 8086:13fb 
## usb 8085:1928

## TODO: The idea is to make only the function that will run on 
## each line be improted and then the device list itself be
## executed. But it may be nice to also have a version that 
## takes a file path, parses each line, then uses passes contents
## of each line to function below.

bind_device_id_to_vfio(){
  #1=device_type, options include: ['usb', 'gpu', 'net', 'other'] 
  #2=device_id, in format 'xxxx:xxxx'

  # TODO: Input Validation, validate format
  DEVICE_ID=$2
  echo $header"Multiverse OS: PCI Device 'vfio-pci' Bind Tool"$reset
  echo $accent"=============================================="$reset
  ## PCI Device Details
  PCI_ADDRESS=$(pci_address_lookup $DEVICE_ID)
  KERNEL_MODULE=$(kernel_module_lookup $DEVICE_ID)
  KERNEL_DRIVER=$(kernel_driver_lookup $DEVICE_ID)
  FULL_PCI_ADDRESS="0000:$PCI_ADDRESS"
  DEVICE_SYSFS_PATH="/sys/bus/pci/devices/$FULL_PCI_ADDRESS"
  UNBIND_FD_PATH="$DEVICE_SYSFS_PATH/driver/unbind"
  DEVICE_CONFIG_SPACE="$DEVICE_SYSFS_PATH/config"
  echo $subheader"Attempting to configure PCI Device"$reset
  echo $text"    Device ID:        "$reset $DEVICE_ID
  echo $text"    PCI Address:      "$reset $PCI_ADDRESS
  echo $text"    Full PCI Address: "$reset $FULL_PCI_ADDRESS
  echo $text"    SysFS Path:       "$reset $DEVICE_SYSFS_PATH
  echo $text"    Unbind FD Path:   "$reset $UNBIND_FD_PATH
  echo $text"    Config Space Path:"$reset $DEVICE_CONFIG_SPACE
  echo $text"    Kernel Module:    "$reset $KERNEL_MODULE
  echo $text"    Kernel Driver:    "$reset $KERNEL_DRIVER
  echo $text""$reset

  if [ "$KERNEL_DRIVER" = "vfio-pci" ]; then 
    echo $success"[Sucess] The specified device was already assignable directly to virtual machines."$reset
  fi

  ## Device Categories
  ## =================
  ## [usb, gpu, and other] will be assigned to any available Controller VMs
  ## [net] will be assigned to Universe Router VMs

  ## TODO: Need to change VM XML based on the category of device.
  ## IF the device category is "usb", "gpu" or "other" it should
  ## be bound to EVERY controller VM 
  ## 


  ## PCI Device Unbinding
  echo $text"Checking if the specified PCI device is already bound..."$reset
  if [ ! -z $UNBIND_FD_PATH ] ; then
    echo $(echo "$FULL_PCI_ADDRESS" > $UNBIND_FD_PATH)
  else 
    echo $text"Device is already unbound, binding to 'vfio-pci' to enable PCI passthrough."$reset
  fi
  bind_device_with_sysfs $DEVICE_ID
  assign_device_config_space_permissions $DEVICE_CONFIG_SPACE
  echo $success"[Success]$reset PCI Device can now be directly assigned to a virtual machine."$reset

  ## Device Categories
  ## =================
  ## [usb, gpu, and other] will be assigned to any available Controller VMs
  ## [net] will be assigned to Universe Router VMs

}

passthrough(){
  if [ ! -z "$3" ]; then
    echo "A specific VM to bind this device has been specified: $3"
    echo $text"WARNING: THIS FEATURE IS NOT YET SUPPORTED."$reset
  fi
  if [ -z "$1" ]; then
    echo $fail"[Error]$reset$text No$strong Device Id$reset$text or$strong PCI Address$reset$text of device to be passed through."$reset
    echo $text"Usage:$reset$header passthrough 8086:15b8$reset$text or$reset$header vfio-bind 02:00.0"$reset
    exit 0
  else
    length_result=$(length "$2")
    if [ $length_result = "9" ]; then
      bind_device_id_to_vfio $1 $2
    fi
    if [ $length_result = "7" ]; then
      echo "Looking for device with PCI Address $1..."
      dev_id=$(device_id_lookup $1 $2)
      echo "Found device with ID [$dev_id] at address $2."
      bind_device_id_to_vfio $dev_id
    fi
    if [ $length_result = "12" ]; then
      lookup_id=$(echo $2 | cut -c 6-)
      echo "Looking for device with PCI Address $lookup_id..."
      dev_id=$(device_id_lookup $1 $lookup_id)
      echo "Found device with ID [$dev_id] at address $lookup_id."
      bind_device_id_to_vfio $dev_id
    fi
    # TODO: Use category to bind device to all Multiverse OS VMs of the
    # type the device belongs to.
  fi
}

pass(){
  passthrough $1 $2
}

