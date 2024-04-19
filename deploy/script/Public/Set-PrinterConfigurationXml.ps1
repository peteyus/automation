# TODO - Does this install the printer? Driver? Doesn't look like it would
Function Set-PrinterConfigurationXml
{
    Param(
        [Paramter(Mandatory=$true)]
        [string] $PrinterName,
        [Paramter(Mandatory=$true)]
        [string] $InputPath
    )

    $printer = Get-Printer -Name $printerName -ErrorAction SilentlyContinue
    if (-not ($printer)) {
        Write-Error "Printer $printerName is not installed."
        Return
    }

    $TXml = Get-Content $InputPath | Out-String  
    Set-PrintConfiguration -PrinterName $PrinterName -PrintTicketXml $TXml
}