<#
    .TITLE
        Install Visual Studio Code Modules
        Set the Git username and email address
    .AUTHOR
        Ivo Beerens
        www.ivobeerens.nl
    .DESCRIPTION
        Install Visual Studio Code Modules
    .NOTES
        Install VS Code extensions
        List existing extensions: code --list-extensions
        Extensions are stored in:  %USERPROFILE%\.vscode\extensions
    .LINK

    .VERSIONS
        1.0 19-04-2024 Creation
#>

# Variables
$git_usernane = "Ivo Beerens"
$git_password = "info@ivobeerens.nl"

$processlist = @(
    "github.vscode-github-actions",
    "hashicorp.hcl",
    "hashicorp.terraform",
    "ms-azuretools.vscode-azureterraform",
    "ms-vscode.azure-account",
    "ms-vscode.azurecli",
    "ms-vscode.azurecli",
    "ms-vscode.powershell",
    "codezombiech.gitignore",
    "davidanson.vscode-markdownlint",
    "eamodio.gitlens",
    "ms-vscode-remote.remote-containers",
    "ms-vscode-remote.remote-wsl"
)

foreach ($item in $processlist) {
    code --install-extension $item 
}

# Configure Git credentials
git config --global user.name $git_usernane
git config --global user.email $git_password