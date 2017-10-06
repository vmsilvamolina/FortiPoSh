function Get-FortigateConfig {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$Credential
    )
 
$Command = @"
show full-configuration
"@
 
try {
    ssh $HostAddress -p $HostPort -l $Credential $Command | Out-Null
} catch {
    Write-Warning -Message $error[0].exception.message
}
}

function Set-FortigateAllowAccess {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$Credential,
        [Parameter(Mandatory=$false)]
        [String]$Interface,
        [Parameter(Mandatory=$false)]
        [String]$AllowAccessOptions
    )
 
$Command = @"
config system interface
edit $Interface
set allowaccess $AllowAccessOptions
end
"@
 
try {
    ssh $HostAddress -p $HostPort -l $Credential $Command | Out-Null
} catch {
    Write-Warning -Message $error[0].exception.message
}
}