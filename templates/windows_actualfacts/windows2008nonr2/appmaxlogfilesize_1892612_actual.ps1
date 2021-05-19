$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
#  	18.9.26.1.2 (L1) - Ensure 'Application: Specify the maximum log file size (KB)' is set to 'Enabled: 32,768 or greater' (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application" 2> $null | select-string 'MaxSize' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application" | select-string 'MaxSize').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -ge [int]'0x8000') {
        $unique1 = $unique1 -replace '0x',''
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
