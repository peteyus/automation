# TODO: this config method doesn't work with canon: https://www.reddit.com/r/PowerShell/comments/n9vy04/comment/gxraj3j/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
# Instlal instructions from https://www.pdq.com/blog/using-powershell-to-install-printers/
Function Set-Printers {
    # HP PageWide
    pnputil.exe /add-driver "\\fes-server21\IT(Public)\\Plotters and Printers\HP Pagewide\win_x64_hpgl2_drv\hpi17nix.inf"
    Add-PrinterDriver -Name "HP PageWide XL 5100PS MFP HPGL2"
    Add-PrinterPort -Name "IP_10.245" -PrinterHostAddress 192.168.10.245
    Add-Printer -Name "FESPageWide" -DriverName "HP PageWide XL 5100PS MFP HPGL2" -PortName "IP_10.245"

    # Canon
    pnputil.exe /add-driver "\\fes-server21\IT(Public)\Plotters and Printers\Canon Printers\Generic_Plus_UFRII_v2.80_Set-up_x64\Driver\CNLB0MA64.INF" 
    Add-PrinterDriver -Name "Canon Generic Plus UFR II"

    # TODO: Get IP Addresses
    Add-PrinterPort -Name "IP_10.243" -PrinterHostAddress 192.168.10.243                                                      
    Add-PrinterPort -Name "IP_10.242" -PrinterHostAddress 192.168.10.242                                                       
    Add-PrinterPort -Name "IP_10.247" -PrinterHostAddress 192.168.10.247

    Add-Printer -Name "FESProduction" -DriverName "Canon Generic Plus UFR II" -PortName "IP_10.243"
    Add-Printer -Name "Front Printer" -DriverName "Canon Generic Plus UFR II" -PortName "IP_10.242"
    Add-Printer -Name "Rear Printer" -DriverName "Canon Generic Plus UFR II" -PortName "IP_10.247"
}