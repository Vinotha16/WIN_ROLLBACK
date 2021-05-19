#   2.3.11.1 (L1) - Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to 'Enabled' (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" 2> $null | select-string 'UseMachineId' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa" | select-string 'UseMachineId').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x1' )  {
		Write-Output "PASSED"
	} else {
   Write-Output "FAILED"
		}
	}
}else {
   Write-Output "FAILED"
}

