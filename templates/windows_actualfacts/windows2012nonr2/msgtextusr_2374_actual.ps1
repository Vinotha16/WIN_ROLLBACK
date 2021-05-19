#   2.3.7.4 (L1) - Configure 'Interactive logon: Message text for users attempting to log on' (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
                 
                 $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" 2> $null | select-string 'LegalNoticeText' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ($unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'LegalNoticeText' | Foreach {"$(($_ -split '\s+',4)[3])"} | select-string -pattern "[A-z][a-z]" | Measure-Object | %{$_.Count})) {
			if (  ( $unique1 -eq '1' ) ) {
                                $unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'LegalNoticeText' | Foreach {"$(($_ -split '\s+',4)[3])"} | select-string -pattern "[A-z][a-z]")
				Write-Output "$unique1"
			} else {
				Write-Output ""
				}
			}
	} else {
		Write-Output ""
	}

}
Catch [System.Management.Automation.ItemNotFoundException]
{
  Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }