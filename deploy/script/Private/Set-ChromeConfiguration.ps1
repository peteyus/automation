Function Set-ChromeConfiguration
{
    Param(
        [Parameter(Mandatory=$false,HelpMessage="The path to chrome.exe. If not provided, the option is skipped.")]
        [string] $chromePath
    )

    $prefpath = "$env:LocalAppData\\Google\\Chrome\\User Data\\Default\\Preferences"
    $cprefs = Get-Content $prefpath | ConvertFrom-Json
    $cprefs.bookmark_bar.show_on_all_tabs = $true
    ConvertTo-Json $cprefs | Out-File $prefpath

    if (Test-Path $chromePath) {
        Add-TaskbarPin -Target $chromePath
    }
}