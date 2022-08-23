﻿add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$src = "C:\Users\8928\Desktop\domainlist.txt"
$dst = "C:\Users\8928\Desktop\domains.csv"

Remove-Item -Path $dst -Force
ForEach ($domain in Get-Content $src){
    $uri = 'https://' + $domain
    Write-Output $uri
    try {
        $response = Invoke-WebRequest -Uri $uri
        $statuscode = $response.StatusCode
        $statusdescription = $response.StatusDescription
        $length = $response.ContentLength
        $header = $response.Headers
    } catch {
        $StatusCode = $_.Exception.Response.StatusCode.value__
        $statusdescription = $_.Exception.Response.StatusDescription
        $length = $_.Exception.Response.ContentLength
        $header = $_.Exception.Response.Headers
    }
        
    $file = New-Object PSObject -Property @{'Domain' = $domain ;
        'IP Address' = (Out-String -InputObject (Resolve-DnsName -Name $domain).IPAddress).Trim() ;
        'HTTP Status' = $statuscode ;
        'HTTP Status Description' = $statusdescription ;
        'Headers' = (Out-String -InputObject $header).Trim()
        'Content Length' = $length
    }
    $file | Export-Csv -path $dst -Append -NoTypeInformation
}