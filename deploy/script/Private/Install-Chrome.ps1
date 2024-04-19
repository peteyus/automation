Function Install-Chrome
{
    $Path = $env:TEMP; 
    $Installer = "chrome_installer.exe"; 
    Invoke-WebRequest "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path$Installer; 
    Write-Output "Installing Chrome, please wait..."
    Start-Process -FilePath $Path$Installer -Args "/silent /install" -Verb RunAs -Wait; 
    Remove-Item $Path$Installer
}