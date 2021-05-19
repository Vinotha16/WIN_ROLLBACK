#   18.9.24.1 (L1) Ensure 'EMET 5.52' or higher is installed (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{


	$output=(Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName,InstallDate |  where-object -filter {$_.DisplayName -eq 'EMET 5.52'} | Measure-Object | %{$_.Count})
	if ($output -ne 1) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}
	
}	
Catch [System.Management.Automation.ItemNotFoundException]
{
 
    Write-Output "FAILED"
 }
Finally { $ErrorActionPreference = "Continue" }	
