$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


#  	18.8.22.1.13 (L2) - Ensure 'Turn off Windows Error Reporting' is set to 'Enabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting")
	$path1 = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" 2> $null | select-string 'Disabled' 2> $null |  Measure-Object | %{$_.Count})
	$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" 2> $null | select-string 'DoReport' 2> $null |  Measure-Object | %{$_.Count})

	if (( $path -eq 'True' ) -And ( $path1 -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' )) {
		foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" | select-string 'Disabled').ToString().Split('')[12].Trim() ) {
			foreach ( $unique3 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting" | select-string 'DoReport').ToString().Split('')[12].Trim() ) {
				if ( ( [int]$unique2 -eq [int]'0x1' ) -And ( [int]$unique3 -eq [int]'0x0' ) ) {
					Write-Output $unique2,$unique3
				} else {
					$unique1 = $unique1 -replace '0x',''
		Write-Output $unique1
					}
			}
		}
	}else {
		Write-Output ""
	}
}

Catch [System.Management.Automation.ItemNotFoundException]
{
 
  Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }


