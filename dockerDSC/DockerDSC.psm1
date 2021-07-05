enum Ensure
{ 
    Absent
    Present
}

[DscResource()]
class DockerDSC
{
    [DscProperty(Key)]
    [String]$DockerVersion

    [DscProperty(NotConfigurable)]
    [String]$InstallState

    [DscProperty(Mandatory = $false)]
    [String]$Ensure = 'Present'

    [DscProperty(NotConfigurable)]
    [String]$DockerName

    # Gets the resource's current state.
    [DockerDSC] Get()
    {
        try
        {
            $docker = docker version -f '{{json .}}' | ConvertFrom-Json

            if ($docker)
            {
                $this.InstallState = 'Present'
                $this.DockerVersion = $docker.Server.Version
                $this.DockerName = $docker.Server.Platform.Name
            }
        }
        catch [System.Management.Automation.CommandNotFoundException]
        {
            $this.InstallState = 'Absent'
        }
        return $this
    }
    
    # Sets the desired state of the resource.
    [void] Set()
    {
        Write-Verbose "Desired State is: $($this.Ensure)"
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

        switch ($this.Ensure)
        {
            "Absent"
            {
                Uninstall-Package -Name docker -ProviderName DockerMsftProvider -Force -ForceBootstrap

            }
            "Present"
            {
                Install-Package -Name docker -ProviderName DockerMsftProvider -Force -RequiredVersion $this.DockerVersion -ForceBootstrap
            }
        }
    }
    
    # Tests if the resource is in the desired state.
    [bool] Test()
    {
        foreach ($level in "Machine", "User")
        {
            [Environment]::GetEnvironmentVariables($level)
        }
        $dockerInfo = $this.Get()
        if ($dockerInfo.InstallState -eq $this.Ensure)
        {
            return $true
        }
        else
        {
            return $false
        }
    }
}