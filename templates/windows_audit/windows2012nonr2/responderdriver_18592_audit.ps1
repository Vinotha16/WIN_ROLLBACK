#  	18.5.9.2 (L2) Ensure 'Turn on Responder (RSPNDR) driver' is set to 'Disabled'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\LLTD' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'AllowRspndrOnDomain' 2> $null | Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'AllowRspndrOnPublicNet' 2> $null | Measure-Object | %{$_.Count})
$unique2 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'EnableRspndr' 2> $null | Measure-Object | %{$_.Count})
$unique3 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'ProhibitRspndrOnPrivateNet' 2> $null |  Measure-Object | %{$_.Count})
	
if (( $path -eq 'True' ) -And ( [int]$unique -eq '1' ) -And ( [int]$unique1 -eq '1' ) -And ( [int]$unique2 -eq '1' ) -And ( [int]$unique3 -eq '1' )) {
	foreach ( $unique4 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'AllowRspndrOnDomain').ToString().Split('')[12].Trim() ) {
		foreach ( $unique5 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'AllowRspndrOnPublicNet').ToString().Split('')[12].Trim() ) {
			foreach ( $unique6 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'EnableRspndr').ToString().Split('')[12].Trim() ) {
				foreach ( $unique7 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'ProhibitRspndrOnPrivateNet').ToString().Split('')[12].Trim() ) {
				if (( [int]$unique4 -eq [int]'0x0' ) -And ( [int]$unique5 -eq [int]'0x0' ) -And ( [int]$unique6 -eq [int]'0x0' ) -And ( [int]$unique7 -eq [int]'0x0' )) {
					Write-Output "PASSED"
				} else {
					Write-Output "FAILED"
					}
				}
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


