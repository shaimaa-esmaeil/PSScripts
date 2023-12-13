#Select export option if Wifi profiles are not exported already.
$user_input = Read-Host "What do you want to do today, Please type import to import wifi profiles, or type export to export the wifi profiles"
$Path = "C:\Wifi"
$counter = 0




if($user_input -eq 'import')
{
$WifiProfiles = Get-ChildItem $Path   
foreach ($wifiprofile in $WifiProfiles) 
{
    $extn = [IO.Path]::GetExtension($wifiprofile)
    if ($extn -eq ".xml")
    {
        #Write-Host "Valid XML file extension" -ForegroundColor Magenta
        Write-Host "Adding $wifiprofile to your Wifi Networks ...." -ForegroundColor Green
        netsh wlan add profile filename= "C:\Wifi\$wifiprofile"
        $counter++

    }
       
else {
   
    Write-Host "File $wifiprofile has invalid file extension and can't be added" -ForegroundColor Red
}
}
Write-Host "$counter profiles were imported" -ForegroundColor Yellow 
}

ElseIf($user_input -eq 'export') 
{
    if(Test-Path $Path)
    {
        netsh wlan export profile key=clear folder=C:\Wifi
        Write-Host "$WifiProfilesCount profiles were exported to C:\Wifi folder"
    }

    else{
        mkdir $Path
        netsh wlan export profile key=clear folder=C:\Wifi
        $WifiProfiles = Get-ChildItem "C:\Wifi"
        $WifiProfilesCount = $WifiProfiles.Count
        Write-Host "$WifiProfilesCount profiles were exported to C:\Wifi folder"
    }
}

else {
        Write-Host "Incorrect input, please enter import or export to proceed...."
        $user_input = Read-Host "What do you want to do today, Please type import to import wifi profiles, or type export to export the wifi profiles"

}
