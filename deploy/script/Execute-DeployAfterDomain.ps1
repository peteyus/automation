# This script assumes you have imported the module, and you've joined to the domain and are ready to set the user's profile up.
if (Get-Confirmation -Prompt "Install Trajan font? [y/n]")
{
    Add-Font
}

if (Get-Confirmation -Prompt "Install and configure web browsers? [y/n]")
{
    Set-Browsers
}

if (Get-Confirmation -Prompt "Configure MS Office Products? [y/n]")
{
    Set-Office
}

if (Get-Confirmation -Prompt "Install Printers? [y/n]")
{
    Set-Printers
}

if (Get-Confirmation -Prompt "Remove Windows 11 Right-click? [y/n]")
{
    Set-WindowsConfiguration # Remove W11 custom right click
}

# Download and Install Microsoft Teams
if (Get-Confirmation -Prompt "Install MS Teams? [y/n]")
{
    Start-Process ".\teamsbootstrapper.exe" -Wait
}

# Install BlueBeam PDF Software from \\fes-server21\IT(Private)\BlueBeam\BbRevu20.2.60.exe 
if (Get-Confirmation -Prompt "Install BlueBeam PDF? [y/n]")
{
    Write-Output "  #   Serial Number: 1711890"
    Write-Output "  #   Product Key: UYCX9-3EI06WA"
    
    $path = $env:TEMP
    $executable = "BbRevu20.2.90.exe"
    $installer = "\\fes-server21\IT(Private)\BlueBeam\$executable"
    Copy-Item $installer -Destination $path$executable
    Start-Process -FilePath $path$executable -Wait
    Remove-Item $path$executable
}

# If user has a phone extension, Install TUSK Presence from \\fes-server21\IT(Public)\Tusk\1.4 Setup March 2019\TUSKPresenceSetup.msi 192.168.10.10
if (Get-Confirmation -Prompt "Install TUSK Presence? [y/n]")
{
    Write-Output "After install, launch TUSK and set the IP address to 192.168.10.10, and configure extension"
    Start-Process -FilePath "\\fes-server21\IT(Public)\Tusk\2023 Update\TUSKPresenceSetup.msi" -Wait
}

# Install Google Earth Pro on any AutoCAD computer
if (Get-Confirmation -Prompt "Install Google Earth Pro? [y/n]")
{
    Start-Process -FilePath "$PSScriptRoot\GoogleEarthProSetup.exe" -Wait
}

# Huntress Agent Installed
# ThreatLocker Installed
if (Get-Confirmation -Prompt "Install Threatlocker? [y/n]")
{
    Start-Process -FilePath "\\fes-server21\IT(Public)\ThreatLocker\07-05-2023\ThreatlockerStubX64_mi7a11d5asvh6vjwq8nlfoz7_B.exe" -Wait
}

# AutoCAD Installed - o	\\fes-server21\IT(Public)\Civil 3D Shared\Installation 
#   Everyone except for Structural get Civil 3D
#   Structural Gets AutoCAD and Revit
#   CAD Services also gets Revit

# IF Structural
#   EnerCalc
#   RISA 3D

# If the computer is for the Traffic Division
#   Bently Connection Client
#   Open Roads
#   ProjectWise Explorer Client

# Install and configure forticlient:  
if (Get-Confirmation -Prompt "Install Forticlient VPN? [y/n]")
{
    Write-Host(@"
    #   Once installed, run it and configure the VPN as follows:
    #   Connection Name:  FOCUS SSL VPN
    #   Remote Gateway:  fesvpn.focusutah.com
    #   Check box for Customize Port and put in 10443
    #   Select Save Login and put username in Username field.
"@)
    Start-Process -FilePath "\\fes-server21\IT(Public)\FortiClientVPNSetup_7.0.3.0193_x64.exe" -Wait
}

# Sophos Anti-Virus installed \\fes-server21\IT(Private)\Sophos\EPandIntXSophosSetup.exe
if (Get-Confirmation -Prompt "Install Sophos? [y/n]")
{
    Start-Process -FilePath "\\fes-server21\IT(Private)\Sophos\EPandIntXSophosSetup.exe" -Wait
}

Write-Output "The following steps of the installation were not run:"
Write-Output "# Outlook Profile setup"
Write-Output "# AutoCAD"
Write-Output "# Structural and Traffic specific applications"