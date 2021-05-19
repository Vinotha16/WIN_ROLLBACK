
#  	18.9.52.2 (L1) Ensure 'Prevent the usage of OneDrive for file storage on Windows 8.1' is set to 'Enabled' (Scored)


$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{	
	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive")

$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" 2> $null | select-string 'DisableFileSync ' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | select-string 'DisableFileSync ').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x1' ) {
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
