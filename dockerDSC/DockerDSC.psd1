@{
    RootModule           = 'DockerDSC.psm1'
    DscResourcesToExport = @('DockerDSC')

    # Version number of this module.
    ModuleVersion        = '0.0.1'

    # ID used to uniquely identify this module
    GUID                 = '83D2B6B2-8855-4C1F-A6B1-725D60E3E7E8'

    # Author of this module
    Author               = 'Yang Xinyun'

    # Company or vendor of this module
    CompanyName          = 'Yang Xinyun'

    # Copyright statement for this module
    Copyright            = '(c) 2021 Yang Xinyun. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'Powershell DSC Resource to install Docker for Windows on Windows Server'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.1'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''
}