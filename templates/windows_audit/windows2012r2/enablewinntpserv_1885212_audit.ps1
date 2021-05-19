#  	18.8.52.1.2 (L2) - Ensure 'Enable Windows NTP Server' is set to 'Disabled' (MS only) (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

	$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer")
	$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer" 2> $null | select-string 'Enabled' 2> $null |  Measure-Object | %{$_.Count})
	if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
		foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\W32Time\TimeProviders\NtpServer" | select-string 'Enabled').ToString().Split('')[12].Trim() ) {
			if ( [int]$unique1 -eq [int]'0x0' ) {
				Write-Output "PASSED"
			} else {
    Write-Output "FAILED"
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
