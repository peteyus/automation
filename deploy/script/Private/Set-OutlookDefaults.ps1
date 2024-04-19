[Reflection.Assembly]::LoadFrom("$PSScriptRoot\..\Microsoft.Office.Interop.Outlook.dll")

Function Set-OutlookDefaults
{
    Write-Output "Launching Outlook for configuration and pinning to taskbar"
    $outlook = New-Object Microsoft.Office.Interop.Outlook.ApplicationClass
    $outlook.Visible = $true
}