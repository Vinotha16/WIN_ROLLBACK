#   2.3.1.2 (L1) - Ensure 'Accounts: Block Microsoft accounts' is set to 'Users can't add or log on with Microsoft accounts' (Scored)

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$output1= '0x3'
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'NoConnectedUser' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
   foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | select-string 'NoConnectedUser').ToString().Split('')[12].Trim() ) {
	if ( $unique1 -eq $output1 ) {
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
