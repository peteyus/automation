Function Set-EdgeConfiguration
{
    Param(
        [Parameter(Mandatory=$false,HelpMessage="The path to msedge.exe. If not provided, the option is skipped.")]
        [string] $edgePath
    )    
    $bmpath="$env:LocalAppData\Microsoft\Edge\User Data\Default\Bookmarks"
    $newbk = [pscustomobject][ordered]@{guid=New-Guid; id="99999"; name="Ajera"; type="url"; 
                        url="http://fes-ajera21/ajera"}

    if(Test-Path $bmPath) 
    {
        $bookmarks=Get-Content $bmpath | ConvertFrom-Json
        $hasAjera = $false;
        foreach ($bookmark in $bookmarks.roots.bookmark_bar.children)
        {
            if ($bookmark.name -eq $newbk.name) 
            {
                $hasAjera = $true;
                Break
            }
        }

        if (-not $hasAjera)
        {
            $bookmarks.roots.bookmark_bar.children += $newbk
            $bookmarks.psobject.Properties.Remove('checksum')
            $bookmarks | ConvertTo-Json -Depth 4 | Set-Content $bmpath
        }
    }
    else
    {
        $bookmarks = [PSCustomObject][ordered]@{
            roots = @{
                bookmark_bar = @{
                    children = @(
                        $newbk
                    )
                    guid = New-Guid
                    id = "1"
                    name = "Bookmarks bar"
                    type = "folder"
                }
                other = @{
                    children = @()
                    guid = New-Guid
                    id = "2"
                    name = "Other bookmarks"
                    type = "folder"
                }
                synced = @{
                    children = @()
                    guid = New-Guid
                    id = "3"
                    name = "Mobile bookmarks"
                    type = "folder"
                }
            }
            version = 1
        }
            
        $bookmarks | ConvertTo-Json -Depth 4 | Set-Content $bmpath
    }
}