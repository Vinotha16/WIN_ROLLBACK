#   2.3.11.2 (L1) - Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled' (Scored)

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" 2> $null | select-string 'AllowNullSessionFallback' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" | select-string 'AllowNullSessionFallback').ToString().Split('')[12].Trim() ) {
	if ( [int]$unique1 -eq [int]'0x0' )  {
		Write-Output "PASSED"
	} else {
		Write-Output "FAILED"
		}
	}
}else {
	Write-Output "FAILED"
}

