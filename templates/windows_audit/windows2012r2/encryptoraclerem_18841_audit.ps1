#   18.8.4.1 (L1) Ensure 'Encryption Oracle Remediation' is set to 'Enabled: Force Updated Clients'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters' -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
        $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters")
        $unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" 2> $null | select-string 'AllowEncryptionOracle' 2> $null |  Measure-Object | %{$_.Count})
        if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
                foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\CredSSP\Parameters" | select-string 'AllowEncryptionOracle').ToString().Split('')[12].Trim() ) {
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
