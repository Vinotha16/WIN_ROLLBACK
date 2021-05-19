#       18.9.26.2.1 (L1) - Ensure 'Security: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled' (Scored)
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security" 2> $null | select-string 'Retention' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
        foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EventLog\Security" | select-string 'Retention').ToString().Split('')[12].Trim() ) {
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

