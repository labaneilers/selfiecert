function Get-ExistingCert {
    $existingCert = gci Cert:\LocalMachine\Root | ? { $_.Subject -match "CertgenSelfSigner"}
    if ($existingCert -and ($existingCert.Count -gt 0)) {
        $existingCert[0]
    }
}

$existingCert = Get-ExistingCert
$certPath = resolve-path(join-path $PSScriptRoot ".\certs\caCertificate.pem")
$newCert = Get-PfxCertificate -FilePath $certPath

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    if ($existingCert) {
        if ($newCert.Thumbprint -eq $existingCert.Thumbprint) {
            "Root CA cert already installed to Windows trust store"
            exit
        } else {
            Write-Host -ForegroundColor "yellow" ""
            Write-Host -ForegroundColor "yellow" "----------------------------------------"
            Write-Host -ForegroundColor "yellow" "An existing CertgenSelfSigner cert with was found in the Trusted Root Certification Authority store on this machine,"
            Write-Host -ForegroundColor "yellow" "but it has a different signature: $($existingCert.Thumbprint)."
            Write-Host -ForegroundColor "yellow" "You can delete it by running the following command in powershell (as Administrator):"
            Write-Host -ForegroundColor "yellow" ""
            Write-Host -ForegroundColor "yellow" "Remove-Item `"Cert:\LocalMachine\Root\$($existingCert.Thumbprint)`""
            Write-Host -ForegroundColor "yellow" ""
            Write-Host -ForegroundColor "yellow" "----------------------------------------"
        }
    }

    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    try {
        Start-Process powershell -WindowStyle hidden -Verb runAs -ArgumentList $arguments
    } catch {
        Write-Error $_.Exception.Message
        exit 1
    }
    
    exit 0
}

# if ($existingCert) {
#     "About to remove cert..."
#     $id = $existingCert.PSChildName
#     Remove-Item "Cert:\LocalMachine\Root\$($existingCert.PSChildName)"
#     "Removed cert"
# }

Import-Certificate $certPath -CertStoreLocation Cert:\LocalMachine\Root