Function Get-PrinterConfigurationXml
{
    Param(
        [Paramter(Mandatory=$true)]
        [string] $PrinterName,
        [Parameter(Mandatory=$true)]
        [string] $OutputPath
    )
    $gpc = get-printconfiguration -PrinterName $PrinterName
    $gpc.PrintTicketXML | out-file $OutputPath
}