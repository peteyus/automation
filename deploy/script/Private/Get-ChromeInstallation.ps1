function Get-ChromeInstallation {
    $paths = @(
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Google Chrome"
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $paths) {
        $items = Get-ItemProperty $path -ErrorAction SilentlyContinue
        foreach ($item in $items) {
            if ($item.DisplayName -like "*Google Chrome*") {
                return $item.InstallLocation;
            }
        }
    }

    return $null;
}