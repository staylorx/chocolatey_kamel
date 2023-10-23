$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/v2.1.0/camel-k-client-2.1.0-windows-amd64.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/v2.1.0/camel-k-client-2.1.0-windows-amd64.tar.gz'
$checksum32  = 'e8fb01c6172f3c8d3a8f58ffd72c5022feba239a7e7f7f410ececedbf140688d'
$checksum64  = 'e8fb01c6172f3c8d3a8f58ffd72c5022feba239a7e7f7f410ececedbf140688d'

$packageArgs = @{
  packageName    = $packageName
  url            = $url32
  url64Bit       = $url64
  checksum       = $checksum32
  checksum64     = $checksum64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  unzipLocation  = Split-Path $MyInvocation.MyCommand.Definition
}
Install-ChocolateyZipPackage @packageArgs
# Run unzip again to open the tar file
$File = Get-ChildItem -File -Path $env:ChocolateyInstall\lib\$packageName\tools\ -Filter *.tar
Get-ChocolateyUnzip -fileFullPath $File.FullName -destination $env:ChocolateyInstall\lib\$packageName\tools\
# Cleanup and remove the tar file now
Remove-Item $File.FullName

# Add the tools folder to PATH.
Install-ChocolateyPath -PathToInstall $env:ChocolateyInstall\lib\$packageName\tools -PathType 'Machine'