#   2.3.7.8 (L1) - Ensure 'Interactive logon: Smart card removal behavior' is set to 'Lock Workstation' or higher (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{

$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" 2> $null | select-string 'ScRemoveOption' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
     foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon" | select-string 'ScRemoveOption').ToString().Split('')[12].Trim() ) {
        if ( [int]$unique1 -eq [int]'0x1' )  {
                Write-Output $unique1
        } else {
                write-output ""
            }
        }
}else {
         write-output ""
}
}
Catch [System.Management.Automation.ItemNotFoundException]
{
  write-output ""
}
Finally { $ErrorActionPreference = "Continue" }

