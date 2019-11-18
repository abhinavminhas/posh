﻿<#

.Synopsis
This function starts the Powershell IDE in 64-bit mode.

.Description
This function checks if Powershell is running the 32-bit version on a 64-bit machine and forces Powershell to run in 64-bit mode.

.Example
Switch-ProcessorArchitecture64
This command checks the 32-bit version Powershell on a 64-bit machine and switches Powershell to 64-bit mode.

#>

Function Switch-ProcessorArchitecture64
{
    Begin
    {
        Function Write-Log([string]$logMessage)
        {
            $print = $logMessage.length + 6
            Write-Output $("-" * ($print))
            Write-Output "[[ $logMessage ]]"
            write-output $("-" * ($print))
        }
    }

    Process
    {
        if ($env:PROCESSOR_ARCHITEW6432 -eq "AMD64")
        {
            Write-Log "....Off To 64-bit....."
            if ($myInvocation.Line)
            {
                &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile $myInvocation.Line
            }
            else
            {
                &"$env:WINDIR\sysnative\windowspowershell\v1.0\powershell.exe" -NonInteractive -NoProfile -file "$($myInvocation.InvocationName)" $args
            }
            exit $lastexitcode
        }
    }
}

#Switch-ProcessorArchitecture64