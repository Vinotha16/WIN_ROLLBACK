#  19.7.41.1 (L1) Ensure 'Always install with elevated privileges' is set to 'Disabled' 


function Fail_fn
{
  
Write-Output "DELETE"
  
exit 0
}


$user=$(wmic useraccount get SID | select -Skip 1 | Where-Object { $_ -NotMatch "501"} |  where{$_ -ne ""})

foreach ( $Name in $user )

{
$username = $($Name -replace '\s','')

sleep 1

$Path_check=((REG QUERY "HKEY_USERS\$username\Software\Policies\Microsoft\Windows\Installer
" 2> $null | select-string 'AlwaysInstallElevated' 2> $null))

if ($Path_check)

{
$data=$($Path_check.ToString().Split('')[12].Trim())


  
Write-Output $data
if ($data -ne "0x0")
  
{
   
 Fail_fn
 
 }
}
else 
{

  Fail_fn

}
}



Write-Output "PASSED"