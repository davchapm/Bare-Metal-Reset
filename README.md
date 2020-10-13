# Bare-Metal-Reset
Reset scripts for VM's Using VMware DirectPath I/O
This script was developed to solve a pretty simple problem.  When you hand-off a physical Ethernet interface to a VM, you have to enable VMware DirectPath I/O.  DirectPath I/O is useful for things like validating 802.1X or to connect a VM as a “physical” endpoint to an ACI Leaf as a "Bare-Metal" host (that was my use-case).  The trouble is, when you configure a VM for DirectPath I/O, you lose the ability to take snapshots (many other caveats).  

My VM's only required a single "start state", so I chose to configure the VM hard drive as Independent - Non-persistent.  That is, I configured that mode AFTER I installed and configured the OS.  The beauty of Independent - Non-Persistent is that any changes you make survive a restart.  But when you need to return to baseline, just perform a Shudown on the VM and it reverts to the original state.

But what do you do if you need to make changes to your "Gold" VMs?  Well, you have to shut them down and change the disk mode to Independent - Persistent.  After making your edits, you shut down the VM and change the mode back to Independent - Non-Persistent.  After doing that once with 16 VM's, I reached to VMware PowerCLI.  One script to change to Persistent, and another to change them back to Non-Persistent.
