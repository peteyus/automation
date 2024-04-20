# TODO: this config method doesn't work with canon: https://www.reddit.com/r/PowerShell/comments/n9vy04/comment/gxraj3j/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
# Instlal instructions from https://www.pdq.com/blog/using-powershell-to-install-printers/
Function Set-Printers {
    # HP PageWide
    #Set-PrinterConfiguration -portName "IP_192.168.10.245" -portAddress "192.168.10.245" -printerName "FESPagwide" -printerDriverName "HP PageWide XL 5100PS MFP HPGL2" -printerDriverPath "W:\\Plotters and Printers\\HP Pagewide\\win_x64_hpgl2_drv\\driver.inf"
   # Canon
   pnputil.exe /add-driver "W:\Plotters and Printers\Canon C5560i II\UFRII_V30.00_Set-up_x64\Driver\CNLB0MA64.INF" 
   Add-PrinterDriver -Name "Canon Generic Plus UFR II" #TODO: Is it the same name there?
   
   # TODO: Get IP Addresses
   # Add-PrinterPort -Name "IP_50.25" -PrinterHostAddress 192.168.50.25                                                       
   # Add-PrinterPort -Name "IP_50.25" -PrinterHostAddress 192.168.50.25                                                       
   # Add-PrinterPort -Name "IP_50.25" -PrinterHostAddress 192.168.50.25
   
   # Add-Printer -Name "FESProduction" -DriverName "Canon Generic Plus UFR II" -PortName "ThatOnePort"
   # Add-Printer -Name "Front Printer" -DriverName "Canon Generic Plus UFR II" -PortName "ThatOnePort"
   # Add-Printer -Name "Rear Printer" -DriverName "Canon Generic Plus UFR II" -PortName "ThatOnePort"
}