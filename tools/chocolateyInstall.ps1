$ErrorActionPreference = 'Stop'

$PackageName = 'kamel'
$url32       = 'https://github.com/apache/camel-k/releases/download/v1.1.0/camel-k-client-1.1.0-windows-64bit.tar.gz'
$url64       = 'https://github.com/apache/camel-k/releases/download/v1.1.0/camel-k-client-1.1.0-windows-64bit.tar.gz'
$checksum32  = '4FD9F43DC668BCA1A9C662CB0DEB7AA1FEDAB89690509AE3C4A408ADA3CBD5A5'
$checksum64  = '4FD9F43DC668BCA1A9C662CB0DEB7AA1FEDAB89690509AE3C4A408ADA3CBD5A5'

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