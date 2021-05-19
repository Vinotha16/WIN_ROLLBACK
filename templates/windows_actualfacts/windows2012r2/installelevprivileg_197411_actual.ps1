$count=0
$listsid = (wmic useraccount get SID | select -Skip 1 | Where-Object { $_ -NotMatch "-5[0-9][1-9] "} | where{$_ -ne ""} | Foreach {$_.TrimEnd()})
foreach($sid in $listsid)
{
$path = "Software\Policies\Microsoft\Windows\Installer"
$valuetoget = "AlwaysInstallElevated"

#check whether the user hive is loaded
if (Test-Path "Registry::HKEY_USERS\$sid" -PathType Container) {
    #it is loaded, check the key
	$test = (Test-Path "Registry::HKEY_USERS\$sid\$path")
    if ($test -eq 'True') {
        $value = Get-ItemProperty "Registry::HKEY_USERS\$sid\$path" -Name $valuetoget -ErrorAction SilentlyContinue
        if ($value.AlwaysInstallElevated -eq 0) {
			$count=($count+0)
        } else {
			$count=($count+1)
			$regkeyval = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'AlwaysInstallElevated' 2> $null |  Measure-Object | %{$_.Count} )
			if ( $regkeyval -eq 1) {
				$query = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'AlwaysInstallElevated' 2> $null).ToString().Split('')[12].Trim()
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
			    Add-Content -Path C:\facts\instfail.txt  -Value $fail-$query
			} else{
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
				Add-Content -Path C:\facts\instfail.txt  -Value $fail-DELETE
			}
        }
    }
    else {
        $count=($count+1)
		$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
		Add-Content -Path C:\facts\instfail.txt  -Value $fail-DELETE
		
    }
}else {
		$accname = [wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName} >> C:\facts\inst.txt        
}
}

if ($count -ne '0') {
	if (Test-Path -Path "C:\facts\inst.txt") {
		$output = ( Get-Content -Path C:\facts\inst.txt | Sort-Object | Get-Unique ) -join ','
	    $outputfail = ( Get-Content -Path C:\facts\instfail.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputfail and SKIPPING $output"
		Remove-Item C:\facts\inst.txt 
		Remove-Item C:\facts\instfail.txt
	} else {
	    $outputfail = ( Get-Content -Path C:\facts\instfail.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputfail"
		Remove-Item C:\facts\instfail.txt
	}
} else {
	if (Test-Path -Path "C:\facts\inst.txt") {
		Write-Output "1 and SKIPPING $output"
		Remove-Item C:\facts\inst.txt
	} else {
		Write-Output "1"		
	}
}
