$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/v1.9.1/camel-k-client-1.9.1-windows-64bit.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/v1.9.1/camel-k-client-1.9.1-windows-64bit.tar.gz'
$checksum32  = '47f28328eed56b84fba71fb5993a215c34efd3870fbfac058ed0e692c6be0088'
$checksum64  = '47f28328eed56b84fba71fb5993a215c34efd3870fbfac058ed0e692c6be0088'

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