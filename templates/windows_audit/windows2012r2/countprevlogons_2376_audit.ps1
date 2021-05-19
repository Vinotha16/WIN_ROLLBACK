#   2.3.7.6 (L2) - Ensure 'Interactive logon: Number of previous logons to cache (in case domain controller is not available)' is set to '4 or fewer logon(s)' (MS only) (Scored)

$output=(Get-ItemProperty 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon' | Select-Object CachedLogonsCount |  where-object -filter {$_.CachedLogonsCount -ge '4'} | Measure-Object | %{$_.Count})
	if ($output -ne 1) {
		write-output "FAILED"
	} else {
		write-output "PASSED"
	}

