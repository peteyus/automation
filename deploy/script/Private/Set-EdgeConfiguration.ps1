Function Set-EdgeConfiguration
{
    Param(
        [Parameter(Mandatory=$false,HelpMessage="The path to msedge.exe. If not provided, the option is skipped.")]
        [string] $edgePath
    )

    if (Test-Path $edgePath)
    {
        Add-TaskbarPin -Target $edgePath
    }
    
    $bmpath="$env:LocalAppData\Microsoft\Edge\User Data\Default\Bookmarks"
    $newbk = [pscustomobject][ordered]@{guid=New-Guid; name="Ajera"; show_icon=$true;
                        source="user_copy"; type="url";
                        url="http://fes-ajera21/ajera"}

    if(Test-Path $bmPath) 
    {
        $bookmarks=Get-Content $bmpath | ConvertFrom-Json

        $bookmarks.roots.bookmark_bar.children += $newbk
        $bookmarks.psobject.Properties.Remove('checksum')

        $bookmarks | ConvertTo-Json -Depth 4 | Set-Content $bmpath
    }
    else
    {
        $bookmarks = [PSCustomObject][ordered]@{
            roots = @{
                bookmark_bar = @{
                    children = @(
                        $newbk
                    )
                }
            }
        }
            
        $bookmarks | ConvertTo-Json | Set-Content $bmpath
    }
}