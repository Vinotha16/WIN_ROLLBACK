#  19.7.45.2.1 (L2) Ensure 'Prevent Codec Download' is set to 'Enabled'


function Fail_fn
{
  
Write-Output "FAILED"
  
exit 0
}


$user=$(wmic useraccount get SID | select -Skip 1 | Where-Object { $_ -NotMatch "501"} |  where{$_ -ne ""})

foreach ( $Name in $user )

{
$username = $($Name -replace '\s','')

sleep 1

$Path_check=((REG QUERY "HKEY_USERS\$username\Software\Policies\Microsoft\WindowsMediaPlayer" 2> $null | select-string 'PreventCodecDownload' 2> $null))

if ($Path_check)

{
$data=$($Path_check.ToString().Split('')[12].Trim())


  
Write-Output $data
if ($data -ne "0x1")
  
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