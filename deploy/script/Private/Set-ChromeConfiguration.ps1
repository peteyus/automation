Function Set-ChromeConfiguration
{
    Param(
        [Parameter(Mandatory=$false,HelpMessage="The path to chrome.exe. If not provided, the option is skipped.")]
        [string] $chromePath
    )

    $prefpath = "$env:LocalAppData\\Google\\Chrome\\User Data\\Default\\Preferences"
    $cprefs = Get-Content $prefpath | ConvertFrom-Json
    if ($null -eq $cprefs.bookmark_bar)
    {
        $cprefs | Add-Member -MemberType NoteProperty -Name bookmark_bar -Value @{ show_on_all_tabs = $true }
    }
    if ($null -eq $cprefs.bookmark_bar.show_on_all_tabs) {
        $cprefs.bookmark_bar | Add-Member -MemberType NoteProperty -Name show_on_all_tabs -Value $true
    }
    $cprefs.bookmark_bar.show_on_all_tabs = $true
    ConvertTo-Json $cprefs | Out-File $prefpath

    Write-Output "Launching Default Apps window for setting default browser"
    Set-DefaultBrowser

    if (Test-Path $chromePath) 
    {
        Write-Output "Launching Chrome window for easy pinning to taskbar"
        Start-Process -FilePath $chromePath
    }
}