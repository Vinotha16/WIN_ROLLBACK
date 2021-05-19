#   2.3.7.5 (L2) - Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is not available)' is set to '4 or fewer logon(s)' (MS only) (Scored)

	$output=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount -ge '4'} | Measure-Object | %{$_.Count})
	if ($output -ne 1) {
	      $failed=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount} | Foreach { $_.CachedLogonsCount })
	write-output "failed $failed"
	} else {
                $output1=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount -ge '4'} | Foreach { $_.CachedLogonsCount })
		write-output "$output1"
	}