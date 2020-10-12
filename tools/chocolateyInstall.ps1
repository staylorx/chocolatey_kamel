$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/v1.2.0/camel-k-client-1.2.0-windows-64bit.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/v1.2.0/camel-k-client-1.2.0-windows-64bit.tar.gz'
$checksum32  = '4C2A22486ADE834E940512289FE7D5921136D9302DCCF9A9366E1681AE971758'
$checksum64  = '4C2A22486ADE834E940512289FE7D5921136D9302DCCF9A9366E1681AE971758'

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