using Microsoft.Win32;
using System.Drawing.Text;
using System.Runtime.InteropServices;
using Excel = Microsoft.Office.Interop.Excel;
using Word = Microsoft.Office.Interop.Word; // todo: configurable? Modules? Easy path for now.

public class Program
{
    public static void Main()
    {
        RegisterFont("TrajanPro.ttf", "\\\\fes-server21\\IT(Private)\\Fonts\\Trajan Pro");
        Console.Out.WriteLine("Configuring MS Word properties...");
        WordSetup();
        Console.Out.WriteLine("Configuring MS Excel properties...");
        ExcelSetup();
    }

    private static void WordSetup()
    {
        var word = new Word.Application();
        word.Visible = false;

        var template = word.NormalTemplate;
        var templateDoc = template.OpenAsDocument();
        
        var paragraphs = templateDoc.Paragraphs;
        paragraphs.LineSpacingRule = Word.WdLineSpacing.wdLineSpaceSingle;
        paragraphs.SpaceAfter = 0;
        paragraphs.SpaceBefore = 0;

        var defaultFont = templateDoc.Styles[Word.WdBuiltinStyle.wdStyleNormal].Font;
        defaultFont.Name = "Century Gothic";
        defaultFont.Size = 11;

        templateDoc.SaveAs(template.Path, Word.WdSaveFormat.wdFormatXMLTemplate);
        templateDoc.Close(false);

        word.Options.DefaultFilePath[Word.WdDefaultFilePath.wdWorkgroupTemplatesPath] = "W:\\FOCUS Templates";
        word.Quit();
    }

    private static void ExcelSetup()
    {
        var excel = new Excel.Application();
        excel.Visible = false;

        excel.StandardFont = "Century Gothic";
        excel.StandardFontSize = 11;

        excel.Quit();
    }

    [DllImport("gdi32", EntryPoint = "AddFontResource")]
    private static extern int AddFontResourceA(string lpFileName);
    [System.Runtime.InteropServices.DllImport("gdi32.dll")]
    private static extern int AddFontResource(string lpszFilename);
    [System.Runtime.InteropServices.DllImport("gdi32.dll")]
    private static extern int CreateScalableFontResource(uint fdwHidden, string
        lpszFontRes, string lpszFontFile, string lpszCurrentPath);

    /// <summary>
    /// Installs font on the user's system and adds it to the registry so it's available on the next session
    /// Your font must be included in your project with its build path set to 'Content' and its Copy property
    /// set to 'Copy Always'
    /// </summary>
    /// <param name="contentFontName">Your font to be passed as a resource (i.e. "myfont.tff")</param>
    private static void RegisterFont(string contentFontName, string fontSourceDirectory)
    {
        // Creates the full path where your font will be installed
        var fontDestination = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.Fonts), contentFontName);

        if (!File.Exists(fontDestination))
        {
            // Copies font to destination
            File.Copy(Path.Combine(fontSourceDirectory, contentFontName), fontDestination);

            // Retrieves font name
            // Makes sure you reference System.Drawing
            PrivateFontCollection fontCol = new PrivateFontCollection();
            fontCol.AddFontFile(fontDestination);
            var actualFontName = fontCol.Families[0].Name;

            //Add font
            AddFontResource(fontDestination);
            //Add registry entry   
            Registry.SetValue(@"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", actualFontName, contentFontName, RegistryValueKind.String);
        }
    }
}