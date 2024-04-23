<#
    .TITLE
        Install packages
    .AUTHOR
        Ivo Beerens
        www.ivobeerens.nl
    .DESCRIPTION
        PowerShell script that enables
    .NOTES
        Run as Administrator
        Find WinGet packages: https://winget.run/
    .LINK
  
    .VERSIONS
        1.0 19-04-2024 Creation
#>

# Variables
$downloadfolder = "c:\temp\apps\"

$ProgressPreference = 'SilentlyContinue'
# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Create Folder
Write-Host "Create Temp folder: $downloadfolder"
$checkdir = Test-Path -Path $downloadfolder
if ($checkdir -eq $false){
    Write-Host "Creating '$downloadfolder' folder"
    New-Item -Path $downloadfolder -ItemType Directory | Out-Null
}

# Install the latest Windows Package Manager (WinGet) version
$winget = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if(!$winget) {
    Write-Host "Install WinGet"
    Invoke-WebRequest -Uri https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6 -OutFile $downloadfolder"microsoft.ui.xaml.2.8.6.nupkg"
    Rename-Item -Path $downloadfolder"microsoft.ui.xaml.2.8.6.nupkg" -NewName $downloadfolder"microsoft.ui.xaml.2.8.6.zip" -Force
    Expand-Archive -path $downloadfolder"microsoft.ui.xaml.2.8.6.zip" -DestinationPath $downloadfolder
    Add-AppxPackage -Path $downloadfolder"tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx"
    Add-AppxPackage -Path $downloadfolder"tools\AppX\x86\Release\Microsoft.UI.Xaml.2.8.appx"

    # List the Xaml versions
    # Get-Appxpackage Microsoft.UI.Xaml.2.8 -allusers | Select-Object Name, Architecture

    Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile $downloadfolder"Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
    Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile $downloadfolder"Microsoft.VCLibs.x64.14.00.Desktop.appx"

    Add-AppxPackage $downloadfolder"Microsoft.VCLibs.x64.14.00.Desktop.appx"
    Add-AppxPackage $downloadfolder"Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

    # Get-AppxPackage Microsoft.VCLibs.140.00 -allusers

    Write-Host "Winget Installed"
    winget -v
}
else {
    Write-Host "Winget already installed"
}

# Install Azure CLI
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile $downloadfolder\AzureCLI.msi
Set-Location $downloadfolder
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Install Winget Packages
# Find packages: https://winget.run/
$processlist = @(
    "Docker.DockerDesktop",
    "Microsoft.VisualStudioCode",
    "Microsoft.PowerShell",
    "Microsoft.WindowsTerminal",
    "Git.Git",
    "Microsoft.Bicep",
    "Hashicorp.Packer",
    "Hashicorp.Terraform",
    "GitHub.cli",
    "GitHub.GitHubDesktop",
    "JGraph.Draw",
    "Notepad++.Notepad++"
    "Microsoft.Azure.AztfExport"
)

foreach ($item in $processlist) {
    Winget install -e --id $item --accept-source-agreements --accept-package-agreements
}

# Upgrade all the other packages
Winget upgrade --all --accept-source-agreements --accept-package-agreements

# AZ Powershell modules
# PowerShell 5
Install-PackageProvider -Name "NuGet" -RequiredVersion "2.8.5.208" -Confirm:$false -Force 
Install-Module -Name PowerShellGet -Force
Install-Module -Name Az -Repository PSGallery -Force

# Install VMware PowerCLI
Install-Module VMware.PowerCLI -AllowClobber -Force

# Install the Microsoft Graph PowerShell SDK
Install-Module Microsoft.Graph -Scope AllUsers -Force

# Get an overview of all installed PowerShell modules
# Get-InstallModule

# Remove downloadfolder
Remove-Item $downloadfolder -Recurse -Force