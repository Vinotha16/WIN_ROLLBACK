#  	18.9.30.2 (L1) - Ensure 'Turn off Data Execution Prevention for Explorer' is set to 'Disabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" 2> $null | select-string 'NoDataExecutionPrevention' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
	foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" | select-string 'NoDataExecutionPrevention').ToString().Split('')[12].Trim() ) {
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