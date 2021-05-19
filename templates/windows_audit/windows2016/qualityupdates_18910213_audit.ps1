# 18.9.102.1.3 (L1) - Ensure 'Select when Quality Updates are received' is set to 'Enabled 0 days' 	

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name version
Get-ItemProperty -Path 'HKLM:\Software\Policies\Microsoft\Windows\WindowsUpdate' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
        $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate")
	$path1 = (Test-Path "Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'DeferQualityUpdates ' 2> $null |  Measure-Object | %{$_.Count})
	$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate" 2> $null | select-string 'DeferQualityUpdatesPeriodInDays' 2> $null |  Measure-Object | %{$_.Count})

	if (( $path -eq 'True' ) -And ( $path1 -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' )) {
		foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'DeferQualityUpdates ').ToString().Split('')[12].Trim() ) {
			foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate" | select-string 'DeferQualityUpdatesPeriodInDays').ToString().Split('')[12].Trim() ) {
				if ( ( [int]$unique2 -eq [int]'0x1' ) -And ( [int]$unique3 -eq [int]'0x0' ) ) {
					Write-Output "PASSED"
				} else {
					Write-Output "FAILED"
					}
			}
		}
	}else {
		Write-Output "FAILED"
	}



}
Catch [System.Management.Automation.ItemNotFoundException]
{
Write-Output "FAILED"
}
Finally { $ErrorActionPreference = "Continue" }

