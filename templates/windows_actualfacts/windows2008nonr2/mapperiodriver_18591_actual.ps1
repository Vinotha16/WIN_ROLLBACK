#  	18.5.9.1 (L2) Ensure 'Turn on Mapper I/O (LLTDIO) driver' is set to 'Disabled' 
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\LLTD' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD")	
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'AllowLLTDIOOnDomain' 2> $null | Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'AllowLLTDIOOnPublicNet' 2> $null | Measure-Object | %{$_.Count})
$unique2 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'EnableLLTDIO' 2> $null | Measure-Object | %{$_.Count})
$unique3 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" 2> $null | select-string 'ProhibitLLTDIOOnPrivateNet' 2> $null |  Measure-Object | %{$_.Count})
	
if (( $path -eq 'True' ) -And ( [int]$unique -eq '1' ) -And ( [int]$unique1 -eq '1' ) -And ( [int]$unique2 -eq '1' ) -And ( [int]$unique3 -eq '1' )) {
   foreach ( $unique4 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'AllowLLTDIOOnDomain').ToString().Split('')[12].Trim() ) {
       foreach ( $unique5 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'AllowLLTDIOOnPublicNet').ToString().Split('')[12].Trim() ) {
           foreach ( $unique6 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'EnableLLTDIO').ToString().Split('')[12].Trim() ) {
               foreach ( $unique7 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LLTD" | select-string 'ProhibitLLTDIOOnPrivateNet').ToString().Split('')[12].Trim() ) {
	       if (( [int]$unique4 -eq [int]'0x0' ) -And ( [int]$unique5 -eq [int]'0x0' ) -And ( [int]$unique6 -eq [int]'0x0' ) -And ( [int]$unique7 -eq [int]'0x0' )) {
			Write-Output $unique4,$unique5,$unique6,$unique7
		} else {
			   $unique8 = $unique4,$unique5,$unique6,$unique7 -replace '0x',''
			Write-Output $unique8
			}
		}
	       }
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

