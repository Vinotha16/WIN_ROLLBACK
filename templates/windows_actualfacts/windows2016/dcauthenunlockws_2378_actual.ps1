#   2.3.7.8 (L1) - Ensure 'Interactive logon: Require Domain Controller Authentication to unlock workstation' is set to 'Enabled' (MS only) (Scored)

$output=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount -ge '4'} | Measure-Object | %{$_.Count})
	if ($output -ne 1) {
	      $failed=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount} | Foreach { $_.CachedLogonsCount })
	write-output "failed $failed"
	} else {
                $output1=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount -ge '4'} | Foreach { $_.CachedLogonsCount })
		write-output "$output1"
	}
