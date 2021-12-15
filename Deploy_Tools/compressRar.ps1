param (
    $SourcePathFile
)
$PathSource = $SourcePathFile
$DirectorySource = [System.IO.Path]::GetDirectoryName($SourcePathFile)
$DirectorySource_0 = [System.IO.Path]::GetDirectoryName($DirectorySource)

$DestNameFile = [System.IO.Path]::GetFileNameWithoutExtension($SourcePathFile)
$DestPathFile = $DirectorySource + "\" + $DestNameFile

$rarExe = $DirectorySource_0 + "\Rar.exe"

$argList = @("a -agYYYYMMDD -r -m5 -rr8 -ep", ('"' + $DestPathFile + '"'), ('"' + $PathSource + '"'))
Start-Process -FilePath $rarExe -ArgumentList $argList -NoNewWindow -Wait