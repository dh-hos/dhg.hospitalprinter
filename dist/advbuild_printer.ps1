$ErrorActionPreference = 'Stop'
$PathConfig = $PSCommandPath + '.action.config.json'
$Config = Get-Content -Path $PathConfig | ConvertFrom-Json
$Config.PathExecuteVersion = (Join-Path -Path $PSScriptRoot -ChildPath $Config.PathExecuteVersion -Resolve)
$Config.PathRcloneZip = (Join-Path -Path $PSScriptRoot -ChildPath $Config.PathRcloneZip -Resolve)
$Config.PathAdvancedInstallerAPPDIR = (Join-Path -Path $PSScriptRoot -ChildPath $Config.PathAdvancedInstallerAPPDIR -Resolve)
$Config.AdvancedInstallerShortcut.PathIcon = (Join-Path -Path $PSScriptRoot -ChildPath $Config.AdvancedInstallerShortcut.PathIcon -Resolve)
$Config.IconInControlPanel.PathIcon = (Join-Path -Path $PSScriptRoot -ChildPath $Config.IconInControlPanel.PathIcon -Resolve)
#Resolve Path file in Config
try {
    $Config.PathAdvancedInstallerCommandFile = (Join-Path -Path $PSScriptRoot -ChildPath $Config.PathAdvancedInstallerCommandFile -Resolve)
}
catch {
    Write-Host ('File not found Advanced Installer CommandFile: {0}' -f $_.TargetObject)
    $Config.PathAdvancedInstallerCommandFile = $_.TargetObject
}
try {
    $Config.PathAdvancedInstallerProjectFile = (Join-Path -Path $PSScriptRoot -ChildPath $Config.PathAdvancedInstallerProjectFile -Resolve)
}
catch {
    Write-Host ('File not found Advanced Installer Project (.aip): {0}' -f $_.TargetObject)
    Write-Host ('Config Option [PathAdvancedInstallerProjectFile]: {0}' -f $Config.PathAdvancedInstallerProjectFile)
    return
}
try {
    $Config.PathAdvancedInstallerOutputFolder = (Join-Path -Path $PSScriptRoot -ChildPath $Config.PathAdvancedInstallerOutputFolder -Resolve) 
}
catch {
    Write-Host ('Directory not found Advanced Installer Output: {0}' -f $_.TargetObject)
    Write-Host ('Create auto Advanced Installer Output: {0}....' -f $_.TargetObject)
    [System.IO.Directory]::CreateDirectory($_.TargetObject)
    $Config.PathAdvancedInstallerOutputFolder = $_.TargetObject
}
#Find version Execute Application in Config
$fileVersion = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($Config.PathExecuteVersion)
$advVersion = '{0}.{1}.{2}{3}.{3}' -f $fileVersion.FileMajorPart, $fileVersion.FileMinorPart, $fileVersion.FileBuildPart.toString().PadLeft(4, '0'), $fileVersion.FilePrivatePart
$Config | Add-Member -NotePropertyName Version -NotePropertyValue $advVersion
$Config | Add-Member -NotePropertyName PathAdvancedInstallerOutputFile -NotePropertyValue (join-Path -Path $Config.PathAdvancedInstallerOutputFolder -ChildPath $Config.OutputPackageName)
$Config | Add-Member -NotePropertyName PathAdvancedInstallerOutputFileZip -NotePropertyValue ((join-Path -Path $Config.PathAdvancedInstallerOutputFolder -ChildPath $Config.OutputPackageName.Replace('.exe', '')) + '.v{0}.zip' -f $fileVersion.FileVersion)
$Config | Add-Member -NotePropertyName GITHUBREPOSITORYSECRETSDEFAULTRTDB -NotePropertyValue ($env:GITHUBREPOSITORYSECRETSDEFAULTRTDB)
$Config | Add-Member -NotePropertyName URL_RCLONE_BASE64 -NotePropertyValue ($env:URL_RCLONE_BASE64)
$Config | Add-Member -NotePropertyName PathRcloneConfig -NotePropertyValue ($PSScriptRoot + '\rclone.conf')
$Config | Add-Member -NotePropertyName PathRclone -NotePropertyValue ($PSScriptRoot + '\rclone.exe')
$Config | Add-Member -NotePropertyName PathRcloneFolder -NotePropertyValue ($PSScriptRoot + '\')
$Config | Add-Member -NotePropertyName OutputPackageNameRemoveSpecialChar -NotePropertyValue ($Config.OutputPackageName -replace '[^a-zA-Z0-9]', '')

if ([string]::IsNullOrEmpty($Config.URL_RCLONE_BASE64) -and
    [System.IO.File]::Exists($PSScriptRoot + '\URL_RCLONE_BASE64.githubignore')) {
    $Config.URL_RCLONE_BASE64 = (Get-Content -Path ($PSScriptRoot + '\URL_RCLONE_BASE64.githubignore'))    
}
if ([string]::IsNullOrEmpty($Config.URL_RCLONE_BASE64) -eq $False) {
    $Response = Invoke-WebRequest -URI $Config.URL_RCLONE_BASE64 -UseBasicParsing 
    $Config.GITHUBREPOSITORYSECRETSDEFAULTRTDB = $Response.Content.Replace('"', '')
}
if ([string]::IsNullOrEmpty($Config.GITHUBREPOSITORYSECRETSDEFAULTRTDB) -and
    [System.IO.File]::Exists($PSScriptRoot + '\GITHUBREPOSITORYSECRETSDEFAULTRTDB.githubignore')) {
    $Config.GITHUBREPOSITORYSECRETSDEFAULTRTDB = (Get-Content -Path ($PSScriptRoot + '\GITHUBREPOSITORYSECRETSDEFAULTRTDB.githubignore'))
}
$Config | Add-Member -NotePropertyName GITHUBREPOSITORYSECRETSDEFAULTRTDB_DECODE -NotePropertyValue ([System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Config.GITHUBREPOSITORYSECRETSDEFAULTRTDB)))
[System.IO.File]::WriteAllLines($Config.PathRcloneConfig, $Config.GITHUBREPOSITORYSECRETSDEFAULTRTDB_DECODE, (New-Object System.Text.UTF8Encoding $False))

function SetLastBuild ([string] $lastBuild) {
    $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
    $headers.Add("Content-Type", "application/json")
    Write-Host $lastBuild
    $body = ("`"{0}`"" -f $lastBuild)
    $url = $Config.URL_RCLONE_BASE64.Replace('GITHUBREPOSITORYSECRETSDEFAULTRTDB', $Config.OutputPackageNameRemoveSpecialChar )
    $response = Invoke-RestMethod -Uri $url -Method 'PUT' -Headers $headers -Body $body
    $response | ConvertTo-Json
} 
function GetLastBuild () {
    $url = $Config.URL_RCLONE_BASE64.Replace('GITHUBREPOSITORYSECRETSDEFAULTRTDB', $Config.OutputPackageNameRemoveSpecialChar )
    $response = Invoke-RestMethod -Uri $url -Method 'GET'
    return $response
} 
$Config | Add-Member -NotePropertyName LastBuild -NotePropertyValue (GetLastBuild)
if ($Config.LastBuild.ToString() -eq $Config.Version) {
    Write-Host ('Exists build: {0}' -f $Config.LastBuild)
    if ($Config.IsShowConfig) { Write-Host $Config }
    return;
}
#Write to AdvancedInstaller commandFile
$arrayLines = New-Object System.Collections.Generic.List[string]
$arrayLines.Add(';aic')
$arrayLines.Add('SetVersion {0}' -f $Config.Version)
$arrayLines.Add('SetProperty ExecuteVersion="{0}"' -f $fileVersion.FileVersion)
$arrayLines.Add('SetOutputLocation -buildname DefaultBuild -path {0}' -f $Config.PathAdvancedInstallerOutputFolder)
$arrayLines.Add('SetPackageName {0} -buildname DefaultBuild' -f $Config.OutputPackageName)
if ($Config.IsAddFileAPPDIR) {
    for ($i = 0; $i -lt $Config.APPDIRFilenames.Count; $i++) {
        $itemName = $Config.APPDIRFilenames[$i]
        $itemName = Join-Path -Path $Config.PathAdvancedInstallerAPPDIR -ChildPath $itemName
        $arrayLines.Add('AddFile APPDIR "{0}" -overwrite always' -f $itemName) 
    }
}
if ($Config.IsNewShortcut) {
    $shortcutName = $Config.AdvancedInstallerShortcut.Name
    $shortcutPathIcon = $Config.AdvancedInstallerShortcut.PathIcon
    $shortcutTarget = $Config.AdvancedInstallerShortcut.Target
    $itemDir = ''
    for ($i = 0; $i -lt $Config.AdvancedInstallerShortcut.InDirectories.Count; $i++) {
        $itemDir = $Config.AdvancedInstallerShortcut.InDirectories[$i]
        $arrayLines.Add(('DelShortcut -name "{0}" -dir "{1}"' -f $shortcutName, $itemDir))
        $arrayLines.Add(('NewShortcut -name "{0}" -dir "{1}" -target "{2}" -icon "{3}"' -f $shortcutName, $itemDir, $shortcutTarget, $shortcutPathIcon))
    }
}
if ($Config.IconInControlPanel.IsSetIcon -and 
    [System.IO.File]::Exists($Config.IconInControlPanel.PathIcon)) {
    $arrayLines.Add(('SetIcon -icon "{0}"' -f $Config.IconInControlPanel.PathIcon))
}
$arrayLines.Add('Save')
$arrayLines.Add('Rebuild')
$arrayLines | Out-File -FilePath $Config.PathAdvancedInstallerCommandFile

&AdvancedInstaller.com /execute $Config.PathAdvancedInstallerProjectFile $Config.PathAdvancedInstallerCommandFile 
Write-Host ('CompressZip {0}=>{1}' -f $Config.PathAdvancedInstallerOutputFile, $Config.PathAdvancedInstallerOutputFileZip)
compress-archive -path $Config.PathAdvancedInstallerOutputFile -destinationpath ($Config.PathAdvancedInstallerOutputFileZip) -Force
if ($Config.IsRunRcUpload) {    
    if ([System.IO.File]::Exists($Config.PathRclone)) { [System.IO.File]::Delete($Config.PathRclone) }
    expand-archive -path $Config.PathRcloneZip -destinationpath $Config.PathRcloneFolder
    if ([System.IO.File]::Exists($Config.PathRclone) -and 
        [System.IO.File]::Exists($Config.PathRcloneConfig)) {
        $Config | Add-Member -NotePropertyName RcloneArgumentList -NotePropertyValue ('')
             
        while ($Config.RcloneCloudPath.StartsWith('\')) { $Config.RcloneCloudPath = $Config.RcloneCloudPath.TrimStart('\') }      
        while ($Config.RcloneCloudPath.EndsWith('\')) { $Config.RcloneCloudPath = $Config.RcloneCloudPath.TrimEnd('\') }    
        Get-Content $Config.PathRcloneConfig | ForEach-Object {
            if ($_.StartsWith('[') -and $_.EndsWith(']')) {
                $uploadName = $_.Replace('[', '').Replace(']', '')
                $Config.RcloneArgumentList = '' 
                $Config.RcloneArgumentList += 'copy "' + $Config.PathAdvancedInstallerOutputFileZip + '" ' + $uploadName + ':"' + $Config.RcloneCloudPath + '"'
                $Config.RcloneArgumentList += ' --config "' + $Config.PathRcloneConfig + '"'
                $Config.RcloneArgumentList += ' --auto-confirm'
                Write-Host ('Rclone upload: {0}=>{1}' -f $Config.PathAdvancedInstallerOutputFileZip, $uploadName)
                Start-Process -WindowStyle Hidden -Wait -FilePath $Config.PathRclone -ArgumentList $Config.RcloneArgumentList
            }
        }  
    }
}
SetLastBuild -lastBuild $Config.Version
if ([System.IO.File]::Exists($Config.PathRclone)) { [System.IO.File]::Delete($Config.PathRclone) }
if ([System.IO.File]::Exists($Config.PathRcloneConfig)) { [System.IO.File]::Delete($Config.PathRcloneConfig) }
if ([System.IO.File]::Exists($Config.PathAdvancedInstallerCommandFile)) { [System.IO.File]::Delete($Config.PathAdvancedInstallerCommandFile) }
if ($Config.IsShowConfig) { Write-Host $Config }
