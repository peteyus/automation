# This script assumes you have imported the module, and you've joined to the domain and are ready to set the user's profile up.
Add-Font
Set-Browsers
Set-Office
Set-Printers #TODO PRJ: this one
Set-WindowsConfiguration # Remove W11 custom right click

# Download and Install Microsoft Teams
Write-Output "Installing MS Teams"
Start-Process ".\teamsbootstrapper.exe" -Wait

# Install BlueBeam PDF Software from \\fes-server21\IT(Private)\BlueBeam\BbRevu20.2.60.exe 
Write-Output "Installing BlueBeam PDF Software"
Write-Output "Serial Number: 1711890"
Write-Output "Product Key: UYCX9-3EI06WA"
Start-Process -FilePath "\\fes-server21\IT(Private)\BlueBeam\BbRevu20.2.60.exe" -RunAs -Wait

# If user has a phone extension, Install TUSK Presence from W:\Tusk\1.4 Setup March 2019\TUSKPresenceSetup.msi 192.168.10.10

# For Field Team load Adobe Acrobat Reader
# Install Google Earth Pro on any AutoCAD computer

# Sophos Anti-Virus installed \\fes-server21\IT(Private)\Sophos\EPandIntXSophosSetup.exe
# Huntress Agent Installed
# ThreatLocker Installed

# AutoCAD Installed - o	W:\Civil 3D Shared\Installation 
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
#   W:\ FortiClientVPNSetup_7.0.3.0193_x64.exe
#   Once installed, run it and configure the VPN as follows:
#   Connection Name:  FOCUS SSL VPN
#   Remote Gateway:  fesvpn.focusutah.com
#   Check box for Customize Port and put in 10443
#   Select Save Login and put username in Username field.
