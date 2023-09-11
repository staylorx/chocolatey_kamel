$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/v2.0.1/camel-k-client-2.0.1-windows-amd64.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/v2.0.1/camel-k-client-2.0.1-windows-amd64.tar.gz'
$checksum32  = '71f1517ba7f1708f7bdcf47a46e34abd5c25b973e54ef52442b514f9541c0fbb'
$checksum64  = '71f1517ba7f1708f7bdcf47a46e34abd5c25b973e54ef52442b514f9541c0fbb'

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