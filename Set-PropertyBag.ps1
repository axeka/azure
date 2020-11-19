param (
    [String]$OWNER,
    [String]$HOSTNAME
)

function Set-RegistryValue64([string] $keyPath, [string] $valueName, [string] $data) {
    # Description: insert in 64Bit registry a registrykey with powershell x86
    $hklm64 = [Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, [Microsoft.Win32.RegistryView]::Registry64);
    $key = $hklm64.OpenSubKey($keyPath, $true);

    Write-Host "hklm64: $hklm64"
    write-host "keyPath: $keyPath, valueName: $valueName"
    write-host "key: $key"

    $key.SetValue($valueName, $data)

    return $key.GetValue($valueName)
}

# Set connection specific DNS Suffix
$index = (Get-DnsClient | where-object { $_.InterfaceAlias -eq 'Ethernet 2' }).InterfaceIndex
Set-DnsClient -InterfaceIndex $index -ConnectionSpecificSuffix "global.corp.sap" 

$itTemplateRegPath = 'SOFTWARE\SAP\IT Template\Images'

# Set SAP IT Template Registry Information
Set-RegistryValue64 $itTemplateRegPath "Owner" $OWNER
Set-RegistryValue64 $itTemplateRegPath "hostname" $HOSTNAME
Set-RegistryValue64 $itTemplateRegPath "installed" (Get-Date -Format "yyyy-MM-dd hh:mm:ss")
Set-RegistryValue64 $itTemplateRegPath "country" "United States"
Set-RegistryValue64 $itTemplateRegPath "homeloc" "PHL"
Set-RegistryValue64 $itTemplateRegPath "location" "VDI - AMER"
Set-RegistryValue64 $itTemplateRegPath "region" "AMER"

       