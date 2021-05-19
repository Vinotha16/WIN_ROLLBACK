#   2.3.10.11 (L1) - Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None' (Scored)

$ErrorActionPreference = "stop"
Try {
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" 2> $null | select-string 'NullSessionShares' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" | select-string 'NullSessionShares' | Foreach {"$(($_ -split '\s+',4)[3])"} | select-string -pattern "[0-9]" | Measure-Object | %{$_.Count} ) ) {
	foreach ( $unique2 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LanManServer\Parameters" | select-string 'NullSessionShares' | Foreach {"$(($_ -split '\s+',4)[3])"} | select-string -pattern "[A-Z][a-z]" | Measure-Object | %{$_.Count}) ) {
		if ( ( $unique1 -ne '1' ) -And ($unique2 -ne '1' ) )  {
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
