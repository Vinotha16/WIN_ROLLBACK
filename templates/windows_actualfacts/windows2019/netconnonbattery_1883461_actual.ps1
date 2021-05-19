$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9 -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

#  	18.8.34.6.1 (L2) - Ensure 'Allow network connectivity during connectedstandby (on battery)' is set to 'Disabled' (Scored)

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9" 2> $null | select-string 'DCSettingIndex' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Power\PowerSettings\f15576e8-98b7-4186-b944-eafa664402d9" | select-string 'DCSettingIndex').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x0' ) {
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
