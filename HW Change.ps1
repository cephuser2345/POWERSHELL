$AllMyVMs = "VMNAME"
#Read-Host  
ForEach ($VM in $AllMyVMs) {
	$Tags= $VM | Select Version


	If ($Tags.Version -Contains “v18“){

   Write-Host "%%%%%%%%%%%%%%%% updating to v14%%%%%%%%%"
      Stop-VMGuest –VM $VM
	   	do {

	        Start-Sleep -s 5
			$VM = Get-VM $VM
   		}until($VM.PowerState -eq "PoweredOff")
        Write-Host "%%%%%%%Creating Snapshot%%%%%%%" 
		New-Snapshot -VM $VM -Name "HW Change“ -Confirm $false
		Set-VM -VM $VM -Version v14
		Start-VM $VM 
		Wait-Tools –VM $VM
       


    }
      else {
    write-Host "Hw version is lower then 18 "
    }


}
