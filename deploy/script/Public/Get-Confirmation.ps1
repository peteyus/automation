Function Get-Confirmation
{
    param(
        [Parameter(Mandatory=$false)]
        [string] $prompt = "Ready? [y/n]"
    )
    $confirmation = Read-Host $prompt
    while($confirmation -ne "y")
    {
        if ($confirmation -eq 'n') { return $false }
        $confirmation = Read-Host $prompt
    }
    return $true
}