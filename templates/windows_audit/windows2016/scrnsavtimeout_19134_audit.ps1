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
			if ( $value.ScreenSaveTimeOut -ne '0' ) {
				if ( $value.ScreenSaveTimeOut -le '900' ){
						$count=($count+0)
				} else {
					$count=($count+1)
				}	
			} else {
				$count=($count+1)			
				}
		} else {
				$count=($count+1)
			}
    }
    else {
        $count=($count+1)
    }
}else {
		$accname = [wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName} >> C:\facts\scrsave.txt
}
}

if ($count -ne '0') {
	if (Test-Path -Path "C:\facts\scrsave.txt") {
		$output = ( Get-Content -Path C:\facts\scrsave.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "FAILED and SKIPPING $output"
		Remove-Item C:\facts\scrsave.txt
	} else {
		Write-Output "FAILED"
	}
} else {
	if (Test-Path -Path "C:\facts\scrsave.txt") {
		$output = ( Get-Content -Path C:\facts\scrsave.txt | Sort-Object | Get-Unique ) -join ','		
		Write-Output "PASSED and SKIPPING $output"
		Remove-Item C:\facts\scrsave.txt
	} else {
		Write-Output "PASSED"
	}
}
