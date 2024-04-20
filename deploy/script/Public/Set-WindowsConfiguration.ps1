Function Set-WindowsConfiguration
{
    $IsWindows11 = (Get-ComputerInfo | Select-Object -expand OsName) -match 11
    if ($IsWindows11) 
    {
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force
#move taskbar to left, disable copilot and widgets
    }
}