$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/v1.9.2/camel-k-client-1.9.2-windows-64bit.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/v1.9.2/camel-k-client-1.9.2-windows-64bit.tar.gz'
$checksum32  = '5ba638f300b40ededfc642f42c732f43ee43e3aa58b57970a88c3cf23ea1f83e'
$checksum64  = '5ba638f300b40ededfc642f42c732f43ee43e3aa58b57970a88c3cf23ea1f83e'

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