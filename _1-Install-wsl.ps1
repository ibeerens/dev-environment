<#
    .TITLE
        Install Windows Linux Subsystem for Linux 2
    .AUTHOR
        Ivo Beerens
        www.ivobeerens.nl
    .DESCRIPTION
        Installs WSL and install the Ubuntu distribution of Linux
    .NOTES
        Run as Administrator
        Device need to be able to run Hyper-V
        wsl --list --online See a list of distrubtions
        wsl --install -d <DistroName>
            NAME                                   FRIENDLY NAME
            * Ubuntu                                 Ubuntu
            Debian                                 Debian GNU/Linux
            kali-linux                             Kali Linux Rolling
            Ubuntu-18.04                           Ubuntu 18.04 LTS
            Ubuntu-20.04                           Ubuntu 20.04 LTS
            Ubuntu-22.04                           Ubuntu 22.04 LTS
            OracleLinux_7_9                        Oracle Linux 7.9
            OracleLinux_8_7                        Oracle Linux 8.7
            OracleLinux_9_1                        Oracle Linux 9.1
            openSUSE-Leap-15.5                     openSUSE Leap 15.5
            SUSE-Linux-Enterprise-Server-15-SP4    SUSE Linux Enterprise Server 15 SP4
            SUSE-Linux-Enterprise-15-SP5           SUSE Linux Enterprise 15 SP5
            openSUSE-Tumbleweed                    openSUSE Tumbleweed
        wsl -l -v Check version
    .LINK
        https://learn.microsoft.com/en-us/windows/wsl/install
        https://learn.microsoft.com/en-us/windows/wsl/basic-commands
    .VERSIONS
        1.0 19-04-2024 Creation
#>

wsl --install
