#   2.3.11.5 (L1) - Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher (Scored)

$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\LDAP -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
   $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LDAP")
   $unique = (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LDAP" 2> $null | select-string 'LDAPClientIntegrity' 2> $null |  Measure-Object | %{$_.Count})

if (( $path -eq 'True' ) -And ( $unique -eq '1' )) {
        foreach ( $unique1 in (REG QUERY "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\LDAP" | select-string 'LDAPClientIntegrity').ToString().Split('')[12].Trim() ) {
        if ( [int]$unique1 -eq [int]'0x1' )  {
                Write-Output $unique1
        } else {
                Write-Output ""
                }
        }
}else {
        Write-Output ""
}

}
Catch [System.Management.Automation.ItemNotFoundException]
{
  Write-Output ""
 }
Finally { $ErrorActionPreference = "Continue" }

