$count=0
$listsid = (wmic useraccount get SID | select -Skip 1 | Where-Object { $_ -NotMatch "-5[0-9][1-9] "} | where{$_ -ne ""} | Foreach {$_.TrimEnd()})
foreach($sid in $listsid)
{
$path = "Software\Policies\Microsoft\Windows\Control Panel\Desktop"
$valuetoget = "ScreenSaveTimeOut"
#check whether the user hive is loaded
if (Test-Path "Registry::HKEY_USERS\$sid" -PathType Container) {
    #it is loaded, check the key
    if (Test-Path "Registry::HKEY_USERS\$sid\$path") {
        $value = Get-ItemProperty "Registry::HKEY_USERS\$sid\$path" -Name $valuetoget -ErrorAction SilentlyContinue
		$regkeyval = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'ScreenSaveTimeOut' 2> $null |  Measure-Object | %{$_.Count} )
		if ( $regkeyval -eq '1'){			
			if (( $value.ScreenSaveTimeOut -le '900' )){
				if (( $value.ScreenSaveTimeOut -ne '0' )){
					$count=($count+0)
					$query = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'ScreenSaveTimeOut' 2> $null).ToString().Split('')[12].Trim()
					$pass = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
					Add-Content -Path C:\facts\scrsavepass.txt  -Value $pass-$query
				} else {
					$count=($count+1)
					$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
					$query = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'ScreenSaveTimeOut' 2> $null).ToString().Split('')[12].Trim()
					Add-Content -Path C:\facts\scrsavefail.txt  -Value $fail-$query				
				}
			} else {
				$count=($count+1)
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
				$query = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'ScreenSaveTimeOut' 2> $null).ToString().Split('')[12].Trim()
				Add-Content -Path C:\facts\scrsavefail.txt  -Value $fail-$query				
			}
		} else {
				$count=($count+1)
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
				Add-Content -Path C:\facts\scrsavefail.txt  -Value $fail-DELETE				
			}
    }
    else {
        $count=($count+1)
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
				Add-Content -Path C:\facts\scrsavefail.txt  -Value $fail-DELETE
    }
}else {
		$accname = [wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName} >> C:\facts\scrsave.txt
}
}

if ($count -ne '0') {
	if (Test-Path -Path "C:\facts\scrsave.txt") {
		$output = ( Get-Content -Path C:\facts\scrsave.txt | Sort-Object | Get-Unique ) -join ','
	    $outputfail = ( Get-Content -Path C:\facts\scrsavefail.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputfail and SKIPPING $output"
		Remove-Item C:\facts\scrsave.txt
		Remove-Item C:\facts\scrsavefail.txt
	} else {
	    $outputfail = ( Get-Content -Path C:\facts\scrsavefail.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputfail"
		Remove-Item C:\facts\scrsavefail.txt		
	} 
} else {
	if (Test-Path -Path "C:\facts\scrsave.txt") {
		$output = ( Get-Content -Path C:\facts\scrsave.txt | Sort-Object | Get-Unique ) -join ','
	    $outputpass = ( Get-Content -Path C:\facts\scrsavepass.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputpass and SKIPPING $output"
		Remove-Item C:\facts\scrsave.txt
		Remove-Item C:\facts\scrsavepass.txt
	} else {
	    $outputpass = ( Get-Content -Path C:\facts\scrsavepass.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputpass"
		Remove-Item C:\facts\scrsavepass.txt	
	}
}
