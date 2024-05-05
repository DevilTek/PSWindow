$Code = 'using System; using System.Windows.Forms; using System.Drawing; namespace AT { public class Code { [STAThread] public static void Main() { Application.EnableVisualStyles(); Application.SetCompatibleTextRenderingDefault(false); Application.Run(new Form()); }}}'

$text = (Invoke-webrequest -URI "http://www.kernel.org").Content

Add-Type -AssemblyName Microsoft.CSharp
Add-Type -AssemblyName System.Reflection

$CompilerParameters = [System.CodeDom.Compiler.CompilerParameters]
$Parameters = New-Object $CompilerParameters
$Parameters.ReferencedAssemblies.AddRange(@('System.dll', 'System.Windows.Forms.dll', 'System.Drawing.dll'))
$Parameters.CompilerOptions = '/optimize'
$Parameters.GenerateExecutable = $true
$Parameters.OutputAssembly = "NewWindow.exe";

$CSharpCodeProvider = [Microsoft.CSharp.CSharpCodeProvider]
$CSharp = New-Object $CSharpCodeProvider
$Result = $CSharp.CompileAssemblyFromSource($Parameters, $Code); 

if ($Result.Errors.HasErrors) {
    foreach ($err in $Result.Errors) {
        Write-Host $err 
    }
    Break;
}

Start-Process -NoNewWindow -FilePath NewWindow.exe 

