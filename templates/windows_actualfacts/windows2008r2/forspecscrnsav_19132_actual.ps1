$count=0
$listsid = (wmic useraccount get SID | select -Skip 1 | Where-Object { $_ -NotMatch "-5[0-9][1-9] "} | where{$_ -ne ""} | Foreach {$_.TrimEnd()})
foreach($sid in $listsid)
{
$path = "Software\Policies\Microsoft\Windows\Control Panel\Desktop"
$valuetoget = "SCRNSAVE.EXE"

#check whether the user hive is loaded
if (Test-Path "Registry::HKEY_USERS\$sid" -PathType Container) {
    #it is loaded, check the key
	$test = (Test-Path "Registry::HKEY_USERS\$sid\$path")
    if ($test -eq 'True') {
        $value = Get-ItemProperty "Registry::HKEY_USERS\$sid\$path" -Name $valuetoget -ErrorAction SilentlyContinue > C:\facts\temp.txt
		$Item = (Select-String -Path C:\facts\temp.txt -Pattern 'SCRNSAVE.EXE' | Foreach {"$(($_ -split ':',5)[4])"})
        if ($Item -eq ' scrnsave.scr') {
			$count=($count+0)
			Remove-Item C:\facts\temp.txt
        } else {
			$count=($count+1)
			$regkeyval = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'SCRNSAVE.EXE' 2> $null |  Measure-Object | %{$_.Count} )
			if ( $regkeyval -eq 1) {
				$query = (REG QUERY "HKEY_USERS\$sid\$path" | select-string 'SCRNSAVE.EXE' 2> $null).ToString().Split('')[12].Trim()
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
			    Add-Content -Path C:\facts\forspfail.txt  -Value $fail-$query
				Remove-Item C:\facts\temp.txt
			} else{
				$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
				Add-Content -Path C:\facts\forspfail.txt  -Value $fail-DELETE
				Remove-Item C:\facts\temp.txt
			}
        }
    }
    else {
        $count=($count+1)
		$fail = ([wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName})
		Add-Content -Path C:\facts\forspfail.txt  -Value $fail-DELETE
		
    }
}else {
		$accname = [wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName} >> C:\facts\forsp.txt        
}
}
$output = ( Get-Content -Path C:\facts\forsp.txt | Sort-Object | Get-Unique ) -join ','
if ($count -ne '0') {
	    $outputfail = ( Get-Content -Path C:\facts\forspfail.txt | Sort-Object | Get-Unique ) -join ','
		Write-Output "$outputfail and SKIPPING $output"
		Remove-Item C:\facts\forsp.txt 
		Remove-Item C:\facts\forspfail.txt
} else {
		Write-Output "2 and SKIPPING $output"
		Remove-Item C:\facts\forsp.txt
}
