Import-Module ".\Focus-Deploy.psm1"
Write-Output "Commands available in this module:"
Get-Command -Module Focus-Deploy | Foreach-Object { Write-Output $_.Name }