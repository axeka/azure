param (
    [String]$OWNER,
    [String]$HOSTNAME
)

# Set connection specific DNS Suffix
$index = (Get-DnsClient | where-object { $_.InterfaceAlias -eq 'Ethernet 2' }).InterfaceIndex
Set-DnsClient -InterfaceIndex $index -ConnectionSpecificSuffix "global.corp.sap"

# Set SAP IT Template Registry Information
$itTemplateRegPath = 'HKLM:\SOFTWARE\SAP\IT Template\Images'
New-Item -Path $itTemplateRegPath -Force
New-ItemProperty -Path $itTemplateRegPath -Name "Owner" -Value $OWNER
New-ItemProperty -Path $itTemplateRegPath -Name "hostname" -Value $HOSTNAME
New-ItemProperty -Path $itTemplateRegPath -Name "installed" -Value (Get-Date -Format "yyyy-MM-dd hh:mm:ss")
New-ItemProperty -Path $itTemplateRegPath -Name "country" -Value "United States"
New-ItemProperty -Path $itTemplateRegPath -Name "homeloc" -Value "PHL"
New-ItemProperty -Path $itTemplateRegPath -Name "location" -Value "VDI - AMER"
New-ItemProperty -Path $itTemplateRegPath -Name "region" -Value "AMER"
