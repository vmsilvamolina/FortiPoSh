﻿function Get-FortigateConfig {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$UserName
    )
 
$Command = @"
show full-configuration
"@
 
try {
    [System.Collections.ArrayList]$resultRaw = ssh $HostAddress -p $HostPort -l $UserName $Command
    $result = $resultRaw | Where-Object {$_ -notmatch '--More--' -and $_.trim() -ne ""}
    $result | more
} catch {
    Write-Warning -Message $error[0].exception.message
}
}

function Get-FortigatePerformance {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$UserName
    )
 
$Command = @"
get system performance status
"@
 
try {
    [System.Collections.ArrayList]$resultRaw = ssh $HostAddress -p $HostPort -l $UserName $Command
    $result = $resultRaw | Where-Object {$_ -notmatch '--More--' -and $_.trim() -ne ""}
    $result | more
} catch {
    Write-Warning -Message $error[0].exception.message
}
}

function Get-FortigateBackup {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$FilePath,
        [Parameter(Mandatory=$true)]
        [String]$UserName
    )

$Command = @"
show full-configuration
"@

try {
    [System.Collections.ArrayList]$resultRaw = ssh $HostAddress -p $HostPort -l $UserName $Command
    $result = $resultRaw | Where-Object {$_ -notmatch '--More--' -and $_.trim() -ne ""}
    $result | Out-File $FilePath
} catch {
    Write-Warning -Message $error[0].exception.message
}

}

function Get-FortigateSystemStatus {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$UserName,
        [Parameter(Mandatory=$false)]
        [String]$Interface,
        [Parameter(Mandatory=$false)]
        [String]$AllowAccessOptions
    )
 
$Command = @"
get system status
"@
 
try {
    ssh $HostAddress -p $HostPort -l $UserName $Command
} catch {
    Write-Warning -Message $error[0].exception.message
}
}

function Set-FortigateHostname {
    [OutputType([String])]
    param
    (
        [Parameter(Mandatory=$true)]
        [String]$HostAddress,
        [Parameter(Mandatory=$false)]
        [Int]$HostPort = 22,
        [Parameter(Mandatory=$true)]
        [String]$UserName,
        [Parameter(Mandatory=$false)]
        [String]$Hostname
    )
 
$Command = @"
config system global
set hostname $Hostname
end
"@
 
try {
    ssh $HostAddress -p $HostPort -l $UserName $Command | Out-Null
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
        [String]$UserName,
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
    ssh $HostAddress -p $HostPort -l $UserName $Command | Out-Null
} catch {
    Write-Warning -Message $error[0].exception.message
}
}