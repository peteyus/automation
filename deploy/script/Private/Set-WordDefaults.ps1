[Reflection.Assembly]::LoadFrom("$PSScriptRoot\..\Microsoft.Office.Interop.Word.dll")

Function Set-WordDefaults
{
    $word = New-Object Microsoft.Office.Interop.Word.ApplicationClass
    $word.Visible = $false

    $template = $word.NormalTemplate
    $templateDoc = $template.OpenAsDocument()
        
    $paragraphs = $templateDoc.Paragraphs
    $paragraphs.LineSpacingRule = 0 #WdLineSpacing.wdLineSpaceSingle
    $paragraphs.SpaceAfter = 0
    $paragraphs.SpaceBefore = 0

    $defaultFont = $templateDoc.Styles[-1].Font # -1 is WdBuiltinStyle.wdStyleNormal
    $defaultFont.Name = "Century Gothic"
    $defaultFont.Size = 11

    $templateDoc.SaveAs($template.Path, 14) # 14 is WdSaveFormat.wdFormatXMLTemplate
    $templateDoc.Close($false)

    If (Test-Path "\\fes-server21\IT(Public)\FOCUS Templates") {
        $word.Options.DefaultFilePath.InvokeSet("\\fes-server21\IT(Public)\FOCUS Templates", @( 3 )) # 3 is WdDefaultFilePath.wdWorkgroupTemplatesPath
    }
    
    Write-Output "Opening Word window to pin to the taskbar"
    $word.Visible = $true
}