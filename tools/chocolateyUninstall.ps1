# Tried maven's version which did not work for me.
# This is found here: https://github.com/DarwinJS/ChocoPackages/blob/master/ec2clitools/tools/chocolateyuninstall.ps1

#Using .NET method prevents expansion (and loss) of environment variables (whether the target of the removal or not)
#To avoid bad situations - does not use substring matching or regular expressions
#Removes duplicates of the target removal path, Cleans up double ";", Handles ending "\"
$pathToRemove = "$env:ChocolateyInstall\lib\$packageName\tools"

foreach ($path in [Environment]::GetEnvironmentVariable("PATH","Machine").split(';')) 
{
  If ($path) 
  {
    If (($path -ine "$PathToRemove") -AND ($path -ine "$PathToRemove\")) 
    {
      [string[]]$Newpath += "$path"
    }
  }
}
$AssembledNewPath = ($newpath -join(';')).trimend(';')

[Environment]::SetEnvironmentVariable("PATH",$AssembledNewPath,"Machine")
