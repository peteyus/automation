Function Set-Browsers
{
    $chromePath = "$(Get-ChromeInstallation)\\chrome.exe"
    if ($chromePath -eq "\\chrome.exe")
    {
        Install-Chrome;
        $chromePath = "$(Get-ChromeInstallation)\\chrome.exe"
    }

    Set-ChromeConfiguration -chromePath $chromePath;
    #Pin Microsoft Edge to Task Bar and create a Favorites Bar shortcut to http://fes-ajer21/ajera

    $edgePath = Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe' "(default)" -ErrorAction SilentlyContinue
    if ($edgePath) 
    {
        Set-EdgeConfiguration -edgePath $edgePath
    }
}