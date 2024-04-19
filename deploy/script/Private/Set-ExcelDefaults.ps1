[Reflection.Assembly]::LoadFrom("$PSScriptRoot\..\Microsoft.Office.Interop.Excel.dll")

Function Set-ExcelDefaults
{
    $excel = New-Object Microsoft.Office.Interop.Excel.ApplicationClass;
    $excel.Visible = $false;

    $excel.StandardFont = "Century Gothic";
    $excel.StandardFontSize = 11;

    $excel.Quit();
}