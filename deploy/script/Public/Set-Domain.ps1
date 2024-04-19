Function Set-Domain
{
    if (-not (Get-IsAdmin)) {
        Write-Error "This command must be executed as administrator."
        Return
    }

    Add-Computer -domainname "FES" 
    Add-LocalGroupMember -Group "Administrators" -Member "FES\\Domain Users"
}