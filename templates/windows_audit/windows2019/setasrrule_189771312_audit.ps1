#       18.9.76.13.1.2 (L1) - Ensure 'Configure Attack Surface Reduction rules: Set the state for each ASR rule' is 'configured'
$ErrorActionPreference = "stop"
Try {
 Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules'  -Name version
}
Catch [System.Management.Automation.PSArgumentException]
{
$path = (Test-Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules")
$unique = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string  '26190899-1602-49e8-8b27-eb1d0a1ce869' 2> $null |  Measure-Object | %{$_.Count})
$unique1 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '3b576869-a4ec-4529-8536-b80a7769e899' 2> $null |  Measure-Object | %{$_.Count})
$unique2 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '5beb7efe-fd9a-4556-801d-275e5ffc04cc' 2> $null |  Measure-Object | %{$_.Count})
$unique3 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84' 2> $null |  Measure-Object | %{$_.Count})
$unique4 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c' 2> $null |  Measure-Object | %{$_.Count})
$unique5 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b' 2> $null |  Measure-Object | %{$_.Count})
$unique6 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2' 2> $null |  Measure-Object | %{$_.Count})
$unique7 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string  'b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4' 2> $null |  Measure-Object | %{$_.Count})
$unique8 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'be9ba2d9-53ea-4cdc-84e5-9b1eeee46550' 2> $null |  Measure-Object | %{$_.Count})
$unique9 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'd3e037e1-3eb8-44c8-a917-57927947596d' 2> $null |  Measure-Object | %{$_.Count})
$unique10 = (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'd4f940ab-401b-4efc-aadc-ad5f3c50688' 2> $null |  Measure-Object | %{$_.Count})
if (( $path -eq 'True' ) -And ( $unique -eq '1' ) -And ( $unique1 -eq '1' ) -And ( $unique2 -eq '1' ) -And ( $unique3 -eq '1' ) -And ( $unique4 -eq '1' ) -And ( $unique5 -eq '1' ) -And ( $unique6 -eq '1' ) -And ( $unique7 -eq '1' ) -And ( $unique8 -eq '1' ) -And ( $unique9 -eq '1' ) -And ( $unique10 -eq '1' )) {
        foreach ( $unique11 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string  '26190899-1602-49e8-8b27-eb1d0a1ce869').ToString().Split('')[12].Trim() ) {
                foreach ( $unique12 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '3b576869-a4ec-4529-8536-b80a7769e899').ToString().Split('')[12].Trim() ) {
                        foreach ( $unique13 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '5beb7efe-fd9a-4556-801d-275e5ffc04cc').ToString().Split('')[12].Trim() ) {
                                foreach ( $unique14 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '75668c1f-73b5-4cf0-bb93-3ecf5cb7cc84').ToString().Split('')[12].Trim() ) {
                                        foreach ( $unique15 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '7674ba52-37eb-4a4f-a9a1-f0f9a1619a2c').ToString().Split('')[12].Trim() ) {
                                                foreach ( $unique16 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '92e97fa1-2edf-4476-bdd6-9dd0b4dddc7b').ToString().Split('')[12].Trim() ) {
                                                        foreach ( $unique17 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string '9e6c4e1f-7d60-472f-ba1a-a39ef669e4b2').ToString().Split('')[12].Trim() ) {
															foreach ( $unique18 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'b2b3f03d-6a65-4f7b-a9c7-1c7ef74a9ba4').ToString().Split('')[12].Trim() ) {
																foreach ( $unique19 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'be9ba2d9-53ea-4cdc-84e5-9b1eeee46550').ToString().Split('')[12].Trim() ) {
																	foreach ( $unique20 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'd3e037e1-3eb8-44c8-a917-57927947596d').ToString().Split('')[12].Trim() ) {
																		foreach ( $unique21 in (REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\ASR\Rules" 2> $null | select-string 'd4f940ab-401b-4efc-aadc-ad5f3c50688').ToString().Split('')[12].Trim() ) {
                                                                            if ( ( [int]$unique11 -eq [int]'0x1' ) -And ( [int]$unique12 -eq [int]'0x1' ) -And ( [int]$unique13 -eq [int]'0x1' ) -And ( [int]$unique14 -eq [int]'0x1' ) -And ( [int]$unique15 -eq [int]'0x1' ) -And  ( [int]$unique16 -eq [int]'0x1' ) -And ([int]$unique17 -eq [int]'0x1') -And ( [int]$unique18 -eq [int]'0x1' ) -And  ( [int]$unique19 -eq [int]'0x1' ) -And ([int]$unique20 -eq [int]'0x1') -And ([int]$unique21 -eq [int]'0x1')) {
                                                                               Write-Output "PASSED"
                                                                            } else {
                                                                                Write-Output "FAILED"
                                                                            }
																		}
																	}
																}
															}
														}
												}
										}
								}
						}
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

