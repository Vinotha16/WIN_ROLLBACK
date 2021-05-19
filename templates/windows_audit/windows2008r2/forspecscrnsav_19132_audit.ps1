$count=0
$listsid = (wmic useraccount get SID | select -Skip 1 | Where-Object { $_ -NotMatch "-5[0-9][1-9] "} | where{$_ -ne ""} | Foreach {$_.TrimEnd()})
foreach($sid in $listsid)
{
$path = "Software\Policies\Microsoft\Windows\Control Panel\Desktop"
$valuetoget = "SCRNSAVE.EXE"

#check whether the user hive is loaded
if (Test-Path "Registry::HKEY_USERS\$sid" -PathType Container) {
    #it is loaded, check the key
    if (Test-Path "Registry::HKEY_USERS\$sid\$path") {
        $value = Get-ItemProperty "Registry::HKEY_USERS\$sid\$path" -Name $valuetoget -ErrorAction SilentlyContinue > C:\facts\temp.txt
		$Item = (Select-String -Path C:\facts\temp.txt -Pattern 'SCRNSAVE.EXE' | Foreach {"$(($_ -split ':',5)[4])"})
        if ($Item -eq ' scrnsave.scr') {
			$count=($count+0)
			Remove-Item C:\facts\temp.txt
        } else {
			$count=($count+1)
			Remove-Item C:\facts\temp.txt
        }
    }
    else {
        $count=($count+1)
    }
}else {
		$accname = [wmi]"Win32_SID.SID='$sid'" | Select-Object AccountName | where-object -filter {$_.AccountName} | Foreach {$_.AccountName} >> C:\facts\forspc.txt        
}
}
$output = ( Get-Content -Path C:\facts\forspc.txt | Sort-Object | Get-Unique ) -join ','
if ($count -ne '0') {
		Write-Output "FAILED and SKIPPING $output"
		Remove-Item C:\facts\forspc.txt
} else {
		Write-Output "PASSED and SKIPPING $output"
		Remove-Item C:\facts\forspc.txt
}
