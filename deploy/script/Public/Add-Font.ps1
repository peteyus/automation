Function Add-Font
{
    Param(
        [Parameter(Mandatory=$false)]
        [string] $path = $null
    )
    
    if (-not (Get-IsAdmin)) {
        Write-Error "This command must be executed as administrator."
        Return
    }

    if (-not ($path))
    {
        $path = "\\\\fes-server21\\IT(Private)\\Fonts\\Trajan Pro"
    }

    $FontItem = Get-Item -Path $path

    #go through all folders in source and list all fon, otf, ttc and ttf files
    $FontList = Get-ChildItem -Path "$FontItem\*" -Include ('*.fon','*.otf','*.ttc','*.ttf') -Recurse

    foreach ($Font in $FontList) 
    {
        Write-Host 'Installing font -' $Font.BaseName
        Copy-Item $Font "C:\Windows\Fonts"
        #register font for all users
        New-ItemProperty -Name $Font.BaseName -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Fonts" -PropertyType string -Value $Font.name
    }
}