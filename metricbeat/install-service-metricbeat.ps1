# Delete and stop the service if it already exists.
if (Get-Service XDataServerMetric -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='XDataServerMetric'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}

$workdir = Split-Path $MyInvocation.MyCommand.Path

# Create the new service.
New-Service -name XDataServerMetric `
  -displayName XDataServerMetric `
  -binaryPathName "`"$workdir\metricbeat.exe`" -c `"$workdir\metricbeat.yml`" -path.home `"$workdir`" -path.data `"E:\SXI\XData\data`" -path.logs `"E:\SXI\XData\logs`""
