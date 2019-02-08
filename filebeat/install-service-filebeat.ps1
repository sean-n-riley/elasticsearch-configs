# Delete and stop the service if it already exists.
if (Get-Service XDataLogConnector -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='XDataLogConnector'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}

$workdir = Split-Path $MyInvocation.MyCommand.Path

# Create the new service.
New-Service -name XDataLogConnector `
  -displayName XDataLogConnector `
  -binaryPathName "`"$workdir\filebeat.exe`" -c `"$workdir\filebeat.yml`" -path.home `"$workdir`" -path.data `"E:\SXI\XData\data`" -path.logs `"E:\SXI\XData\logs`""
