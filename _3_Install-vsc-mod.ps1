<#
    .TITLE
        Install Visual Studio Code Modules
    .AUTHOR
        Ivo Beerens
        www.ivobeerens.nl
    .DESCRIPTION
        Install Visual Studio Code Modules
    .NOTES
        Install VS Code extensions
        List existing extensions: code --list-extensions
        Extensions are saved in:  %USERPROFILE%\.vscode\extensions
    .LINK

    .VERSIONS
        1.0 19-04-2024 Creation
#>

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
    "davidanson.vscode-markdownlint"
)

foreach ($item in $processlist) {
    code --install-extension $item 
}

# Configure Git credentials
git config --global user.name "Ivo Beerens"
git config --global user.email info@ivobeerens.nl