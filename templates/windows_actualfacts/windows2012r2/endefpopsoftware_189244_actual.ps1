$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
#   18.9.24.4 (L1) Ensure 'Default Protections for Popular Software' is set to 'Enabled' (Scored)



        $path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EMET\Defaults")
        $unique = ((get-itemproperty -literalpath HKLM:\SOFTWARE\Policies\Microsoft\EMET\Defaults) | select-string '7-Zip' 2> $null | Measure-Object | %{$_.Count})
        if ( $path -eq 'True' ) {
                                if ( [int]$unique -eq [int]'1' ) {
                                Write-Output $unique
                                } else {
                                Write-Output ""
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
