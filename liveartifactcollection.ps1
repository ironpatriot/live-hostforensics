#Requires -RunAsAdministrator

# This is a basic live forensics capture of volatile data written in Powershell

# Written by Cortell Shaw

# Prompting for execution before starting script

Read-Host -Prompt "Press any key to continue or CTRL+C to quit" 


$breaksection = "------------------------------------------------------------`r`n`r`n"


# Record date and time to run script from start to finish
$dtn = Get-Date
# Check Powershell Version
Write-Host "Checking Powershell Version /////////////////////////////`r`n"

$PSversion = Write-Output $PSVersionTable
if ($PSVersion.PSVersion.Major -lt '5'){
    Write-Host "Incompatible Version of Powershell Detected" -BackgroundColor Red
    Write-Error "Quitting!" -ErrorAction Stop
    
} else {
    Write-Host "Continuing Script, Starting Artifact Capture //////////////" -BackgroundColor Green
    Write-Host "Starting Evidence Collection on: " $dtn
}
$breaksection 

    $l = "Gathering Operating System Details "
    $l

$breaksection 


# Operating System Info
$os = Get-WmiObject win32_operatingsystem
$osversion = $os.Name.split("|")
$maker = $os.Manufacturer
$arch = $os.OSArchitecture
Write-Host "Computername : "  $os.PSComputerName
Write-Host "OS Version: " $osversion[0]
Write-Host "OS Manufactor: " $maker
Write-Host "OS Architecture: " $arch`r`n

$breaksection

    $z = "Recorded Time Zone `r`n"
    $z

$breaksection 




$TZ = Get-TimeZone
Write-Host "Time Zone: " $TZ.Id

$breaksection

    $y = "Gathering Partition and Disk Information `r`n"
    $y


$breaksection 



$vols = Get-wmiobject Win32_Volume
foreach ($vol in $vols){
     Write-Host "Label: " $vol.Label`r`n, 
     Write-Host "Volume: " $vol.FileSystem`r`n , 
     Write-Host "Is Boot Volume?: " $vol.BootVolume`r`n
    }

$breaksection

    Write-Host "Currently not collecting memory artifacts`r`n"

$breaksection 




$breaksection

    $h  = "Gathering list of User Accounts`r`n"
    $h

$breaksection 

# Users

$users = Get-WmiObject -class Win32_UserAccount
foreach ($user in $users){
    Write-Host "Account Name: " $user.Name`r`n,
    Write-Host "Account Type: " $user.AccountType`r`n
    # enabled/disabled/logged on?
}

$breaksection

    $p = "Gathering Network Adapters with MAC Addresses`r`n"
    $p

$breaksection 

# Network devices

$netdevices = Get-WmiObject -Class Win32_NetworkAdapter
$i = @($netdevices.Name)
$j = @($netdevices.MACAddress)
$k = @($netdevices.AdapterType)

for ($a = 0; $a -lt $netdevices.Count; $a++) {
    Write-Host "Name: " $i[$a]
    Write-Host "MAC: " $j[$a]
    Write-Host "Adapter Type: " $k[$a]`r`n
}

$breaksection

    $e = "Retrieving Network Share Information`r`n"
    $e

$breaksection 

# Network Shares
Get-SmbShare 

$breaksection 

    $o = "Collecting all Established Network Connections`r`n"
    $o

$breaksection 

# Network Connections
Get-NetTCPConnection -State "Established"

$breaksection

    $f = "Checking For Startup Processes`r`n"
    $f

$breaksection 


Get-WmiObject Win32_Service -Filter "StartMode ='Auto'"
    

$breaksection

    $d = "Collecting Last Written File Time and Application`r`n"
    $d  

$breaksection

Try{
    Get-ChildItem -Recurse C:\ | Where-Object {$_.lastwritetime -gt (Get-Date).AddDays(1)} 
    # Adding progess bar | Write-Progress -Activity "Gathering Last Written Files" -Status "Bruh"
} Catch {
    Write-Error -ErrorAction SilentlyContinue | Out-File -FilePath '/errlog.txt'
}
#Write-Progress -Activity "Complete! Moving On" -Status "Dope"

$breaksection

    $q = "Processes running with a Graphical User Interface"
    $q

$breaksection

Get-Process | Where-Object {$_.mainWindowTitle} | Format-Table Id, getName, mainWindowtitle -AutoSize


$breaksection

    $g =  "Gathering Processes similar to PS -ef in Linux  | Who ran the file`r`n"
    $g

$breaksection

# Processes attached to who ran them 
Get-Process -IncludeUserName 


$breaksection

    $b = "Retreiving Metadata from Jump Lists`r`n"
    $b

$breaksection

$jmplist_path1 = "$env:APPDATA\Microsoft\Windows\Recent\CustomDestinations"
$jmplist_path1 | Get-ChildItem

$jmplist_path2 = "$env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations"
$jmplist_path2 | Get-ChildItem


$breaksection
    
    $i = Get-Date
    $j = 'Finished Artifact collection on: '
    $j + $i

$breaksection