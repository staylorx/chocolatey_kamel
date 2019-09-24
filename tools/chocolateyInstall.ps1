$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/0.3.4/camel-k-client-0.3.4-windows-64bit.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/0.3.4/camel-k-client-0.3.4-windows-64bit.tar.gz'
$checksum32  = '84A0499D9098ACBEA517F5467B2CAAD11407A071250D1B5275EABF8F872EFB57'
$checksum64  = '84A0499D9098ACBEA517F5467B2CAAD11407A071250D1B5275EABF8F872EFB57'

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