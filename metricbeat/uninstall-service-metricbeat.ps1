# Delete and stop the service if it already exists.
if (Get-Service XDataServerMetric -ErrorAction SilentlyContinue) {
  $service = Get-WmiObject -Class Win32_Service -Filter "name='XDataServerMetric'"
  $service.StopService()
  Start-Sleep -s 1
  $service.delete()
}
