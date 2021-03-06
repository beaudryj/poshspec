﻿#Requires -Module Poshspec

Describe 'Services' {    
    Service w32time Status { Should Be Running }
    Service bits Status { Should Be Stopped }
}

Describe 'Files' {
    File C:\inetpub\wwwroot\iisstart.htm { Should Exist }
    File C:\inetpub\wwwroot\iisstart.htm { Should Contain 'text-align:center' }
}

Describe 'Registry' {
    Registry HKLM:\SOFTWARE\Microsoft\Rpc\ClientProtocols { Should Exist }
    Registry HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ "SyncDomainWithMembership" { Should Be 1  }
    Registry 'HKLM:\SOFTWARE\Callahan Auto\' { Should Not Exist }
}

Describe 'Http' {
    TcpPort localhost 80 PingSucceeded { Should Be $true }
    TcpPort localhost 80 TcpTestSucceeded { Should Be $true }
    Http http://localhost StatusCode { Should Be 200 }
    Http http://localhost RawContent { Should Match 'X-Powered-By: ASP.NET' }
    Http http://localhost RawContent { Should Not Match 'X-Powered-By: Cobal' }
}
Describe 'Hotfix' {
    Hotfix KB3116900 { Should Not BeNullOrEmpty}
    Hotfix KB1112233 { Should BeNullOrEmpty}
}
Describe 'CimObject' {
    CimObject Win32_OperatingSystem SystemDirectory { Should Be C:\WINDOWS\system32 }
    CimObject root/StandardCimv2/MSFT_NetOffloadGlobalSetting ReceiveSideScaling { Should Be Enabled }
}

<<<<<<< HEAD
Describe 'WebSite' {
   WebSiteBinding TestSite http protocol { Should be "http" }
   WebSiteBinding TestSite http bindingInformation { Should match '80' }
   WebSiteBinding TestSite http sslFlags { Should be 0 }
   WebSite TestSite state { Should be 'Started' }
   WebSite TestSite Name { Should be 'TestSite'} 
   WebSite TestSite physicalPath { Should be 'C:\IIS\Files\TestSite' } 
   CheckAppPool TestSite { Should be $True }
   AppPoolState TestSite { Should be Started } 
   WebSiteState TestSite { Should be Started }
}

Describe 'Firewall' {
   Firewall putty.exe Enabled { Should be "$True" }
   Firewall putty.exe Action { Should be 'Allow' }
   Firewall putty.exe Profile { Should be 'Private' }
}

Describe 'Volume' {
   Volume C FileSystem { Should be 'NTFS' }
   Volume C HealthStatus { Should be 'Healthy' }
}

Describe 'PhysicalDisk' {
   PhysicalDisk physicalDisk0 HealthStatus { Should be 'Healthy' }
   PhysicalDisk physicalDisk0 OperationalStatus { Should be 'OK' }
   PhysicalDisk physicalDisk0 Size { begreaterthan 1073741824 }
=======

Describe 'Firewall' {
   Firewall putty.exe Enabled { Should be "$True" }
   Firewall putty.exe Action { Should be 'Allow' }
   Firewall putty.exe Profile { Should be 'Private' }
}

Describe 'Volume' {
    Volume C DriveType { should be 'fixed' }
    Volume C FileSystem { should be 'NTFS' }
    Volume 'ShouldNotExist' { should BeNullOrEmpty}
>>>>>>> upstream/master
}

