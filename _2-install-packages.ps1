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
        Find Winget packages: https://winget.run/

    .LINK

    .VERSIONS
        1.0 19-04-2024 Creation
#>

$ProgressPreference = 'SilentlyContinue'
# Enable TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$downloadfolder = "c:\temp\apps\"
$git_usernane = "Ivo Beerens"
$git_password = "info@ivobeerens.nl"
$winget_accept_terms = "--accept-source-agreements --accept-package-agreements"

# Create Folder
$checkdir = Test-Path -Path $downloadfolder
if ($checkdir -eq $false){
    Write-Verbose "Creating '$downloadfolder' folder"
    New-Item -Path $downloadfolder -ItemType Directory | Out-Null
}
else {
    Write-Verbose "Folder '$downloadfolder' already exists."
}

# Install the latest Windows Package Manager (WinGet) version
Write-Host "Install WinGet"

Invoke-WebRequest -Uri https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.8.6 -OutFile $downloadfolder"microsoft.ui.xaml.2.8.6.nupkg"
Rename-Item -Path $downloadfolder"microsoft.ui.xaml.2.8.6.nupkg" -NewName $downloadfolder"microsoft.ui.xaml.2.8.6.zip" -Force
Expand-Archive -path $downloadfolder"microsoft.ui.xaml.2.8.6.zip" -DestinationPath $downloadfolder
Add-AppxPackage -Path $downloadfolder"tools\AppX\x64\Release\Microsoft.UI.Xaml.2.8.appx"
Add-AppxPackage -Path $downloadfolder"tools\AppX\x86\Release\Microsoft.UI.Xaml.2.8.appx"

Get-Appxpackage Microsoft.UI.Xaml.2.8 -allusers | Select-Object Name, Architecture

Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile $downloadfolder"Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile $downloadfolder"Microsoft.VCLibs.x64.14.00.Desktop.appx"

Add-AppxPackage $downloadfolder"Microsoft.VCLibs.x64.14.00.Desktop.appx"
Add-AppxPackage $downloadfolder"Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Remove downloadfolder
Remove-Item $downloadfolder -Recurse -Force

# Install Azure CLI
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile $downloadfolder\AzureCLI.msi
Set-Location $downloadfolder
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Install Winget Packages
# Find packages: https://winget.run/
$processlist = @(
    "Git.Git",
    "Microsoft.VisualStudioCode",
    "Microsoft.WindowsTerminal",
    "Hashicorp.Packer",
    "Hashicorp.Terraform",
    "Microsoft.Azure.AztfExport",
    "Microsoft.PowerShell"
)

foreach ($item in $processlist) {
    Winget install -e --id $item --accept-source-agreements --accept-package-agreements
}

# AZ Powershell modules
# PowerShell 5
Install-PackageProvider -Name "NuGet" -RequiredVersion "2.8.5.208" -Confirm:$false -Force 
Install-Module -Name PowerShellGet -Force
Install-Module -Name Az -Repository PSGallery -Force