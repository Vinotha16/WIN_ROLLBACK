
#  	18.9.60.3 (L2) Ensure 'Set what information is shared in Search' is set to 'Enabled: Anonymous info' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{	
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search")

$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" 2> $null | select-string 'ConnectedSearchPrivacy' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" | select-string 'ConnectedSearchPrivacy').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x3' ) {
				Write-Output $unique1
			} else {
                               $unique1 = $unique1 -replace '0x',''
				Write-Output $unique1
				}
							}
	}else {
		Write-Output "DELETE"
	}


}
Catch [System.Management.Automation.ItemNotFoundException]
{
 
 Write-Output "DELETE"
 }
Finally { $ErrorActionPreference = "Continue" }
