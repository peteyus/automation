#May be unnecessary? 
Function Set-PrinterConfiguration{
    Param(
        [Parameter(Mandatory=$true)]
        [string] $portName
        [Parameter(Mandatory=$true)]
        [string] $portAddress
        [Parameter(Mandatory=$true)]
        [string] $printerName
        [Parameter(Mandatory=$true)]
        [string] $printerDriverName
        [Parameter(Mandatory=$true)]
        [string] $printerDriverPath
    )

    $printer = Get-Printer -Name $printerName -ErrorAction SilentlyContinue
    if ($printer) {
        Write-Output "Printer $printerName is already installed."
    }

    $port = Get-PrinterPort -Name $portName -ErrorAction SilentlyContinue
    if (-not ($port))
    {
        $port = Add-PrinterPort -Name $portName -PrinterHostAddress $portAddress
    }

    $printerDriver = Get-PrinterDriver -Name $printerDriverName -ErrorAction SilentlyContinue
    if (-not ($printerDriver))
    {
        $printerDriver = Add-PrinterDriver -Name $printerDriverName -InfPath $printerDriverPath
    }
    $printer = Add-Printer -PortName $portName -DriverName $printerDriverName
}