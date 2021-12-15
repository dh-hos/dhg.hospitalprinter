param (
    $SourcePathFile,
    $ExeName
)
$PathSource = $SourcePathFile
$DirectorySource = [System.IO.Path]::GetDirectoryName($SourcePathFile)
$DirectorySource_0 = [System.IO.Path]::GetDirectoryName($DirectorySource)
$PathExe = [System.IO.Path]::GetDirectoryName($DirectorySource_0) + "\Deploy_Libraries\" + $ExeName
$version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($PathExe).FileVersion
$DestNameFile = [System.IO.Path]::GetFileNameWithoutExtension($SourcePathFile) + ".v" + $version
$DestPathFile = $DirectorySource + "\" + $DestNameFile + ".rar"
$rarExe = $DirectorySource_0 + "\Rar.exe"

$argList = @("a -r -m5 -rr8 -ep", ('"' + $DestPathFile + '"'), ('"' + $PathSource + '"'))
Start-Process -FilePath $rarExe -ArgumentList $argList -NoNewWindow -Wait

