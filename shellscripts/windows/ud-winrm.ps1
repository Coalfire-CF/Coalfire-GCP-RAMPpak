<powershell>

write-output "Running User Data Script"
write-host "(host) Running User Data Script"

Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force -ErrorAction Ignore

# Don't set this before Set-ExecutionPolicy as it throws an error
$ErrorActionPreference = "stop"

# WinRM
write-output "Setting up WinRM"
write-host "(host) setting up WinRM"

Remove-Item -Path WSMan:\Localhost\listener\listener* -Recurse
$Cert = New-SelfSignedCertificate -CertstoreLocation Cert:\LocalMachine\My -DnsName "${hostname}"

winrm quickconfig -quiet
New-Item -Path WSMan:\LocalHost\Listener -Transport HTTPS -Address * -CertificateThumbPrint $Cert.Thumbprint -Force
cmd.exe /c netsh advfirewall firewall add rule name= "WinRM HTTPS" dir=in action=allow protocol=TCP localport=5986 profile=private,domain
Stop-Service -Name winrm
Set-Service -Name winrm -StartupType Automatic
Start-Service -Name winrm

#Enable network discovery since the default profile is "Public" and restricted so Ansible can't initially connect.
Get-NetConnectionProfile -Verbose | Set-NetConnectionProfile -NetworkCategory "Private" -Verbose
Get-NetFirewallRule -DisplayGroup 'Network Discovery' -Verbose | Set-NetFirewallRule -Profile 'Private, Domain' -Enabled true -Verbose

</powershell>