Write-Host Connecting to DCAC9K p9-vcenter.dc.local
sleep 2
Write-Host
Write-Host
Write-Host This script will Power Down all Bare-Metal VMs, convert the disk mode to Non-Persistent and Power-up the VMs
sleep 2
# Connect to vCenter and enter user/pass into pop-up dialog.

Connect-ViServer -server p9-vcenter.dc.local -Protocol https -user root -Password NXos12345 -Force

# Stop all VMs

$strVMs=@("BM1A","BM2A","BM3A","BM4A","BM5A","BM6A","BM7A","BM8A","BM1B","BM2B","BM3B","BM4B","BM5B","BM6B","BM7B","BM8B")
foreach ($objitem in $strVMs) {
Stop-VM -VM $objitem -Confirm:$false -RunAsync
}

# Sleep loop to allow enough time for all VMs to Stop
$i=20
do {
Write-Host Waiting $i more seconds for VMs to Stop
sleep 1
$i--
}
while ($i -gt 0)

# Set all bare-metal servers to Non-Persistent

$strVMs=@("BM1A","BM2A","BM3A","BM4A","BM5A","BM6A","BM7A","BM8A","BM1B","BM2B","BM3B","BM4B","BM5B","BM6B","BM7B","BM8B")
foreach ($objitem in $strVMs) {
Get-HardDisk -VM $objitem | Set-HardDisk -Persistence "IndependentNonPersistent" -Confirm:$false
}

# Start all VMs

$strVMs=@("BM1A","BM2A","BM3A","BM4A","BM5A","BM6A","BM7A","BM8A","BM1B","BM2B","BM3B","BM4B","BM5B","BM6B","BM7B","BM8B")
foreach ($objitem in $strVMs) {
Start-VM -VM $objitem -Confirm:$false -RunAsync
}

# Sleep loop to allow enough time for all VMs to Start

$i=20
do {
Write-Host Waiting $i more seconds for VMs to Start
sleep 1
$i--
}
while ($i -gt 0)

# Display the current HD mode

$strVMs=@("BM1A","BM2A","BM3A","BM4A","BM5A","BM6A","BM7A","BM8A","BM1B","BM2B","BM3B","BM4B","BM5B","BM6B","BM7B","BM8B")
foreach ($objitem in $strVMs) {
Get-HardDisk -VM $objitem
}

# Disconnect from p9-vcenter.dc.local to release connection resources

Disconnect-VIServer -Server p9-vcenter.dc.local -Force -Confirm:$false
Write-Host
Write-Host Disconnected from p9-vcenter.dc.local