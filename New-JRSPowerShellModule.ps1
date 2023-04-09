function New-PowerShellModule {
        <#
    .SYNOPSIS

    .DESCRIPTION

    .NOTES
        ==============================================================================================
        Name   : New-PowerShellModule.ps1
        Author : James Snyder
        
        Dependencies:


        Credits:
            Thanks to Adam Bertram at ScriptRunner
            https://www.scriptrunner.com/en/blog/building-your-first-powershell-module/

        Comments:

        Pending Enhancements:

        Revision history:
        v1.0.0 - 2022/09/05 - James Snyder - Initial version after testing, debugging and documentation.
        ==============================================================================================

    .PARAMETER Example1
        Details for example 1.

    .PARAMETER Example2
        Details for example 2.

    .EXAMPLE

    .LINK
        Git repository URL (for source code of CMDLET): 

    .LINK
    #>
    
    param (
        [Parameter(Mandatory = $True)]
        [String]
        $ModuleName,
    
        [Parameter()]
        [Array]
        $Commands,
    
        [Parameter(Mandatory = $True)]
        [String]
        $Description
    )

    $newModulePath = "C:\PowerShellModules"
    
    # Check if new module path exists
    if ($null -eq (Test-Path -Path ($newModulePath))) {
        New-Item -Path $newModulePath -ItemType "Directory"
    
    }
    
    New-Item -ItemType "Directory" -Path "$newModulePath\$moduleName"
    # New-Item -ItemType "Directory" -Path "$newModulePath\$moduleName\Public"
    # New-Item -ItemType "Directory" -Path "$newModulePath\$moduleName\Private"
    # New-Item -ItemType "File" -Path "$newModulePath\$moduleName\$ModuleName.psd1"
    
    Copy-Item -Path ".\ModuleTemplate\*" -Destination  "$newModulePath\$moduleName" -Recurse
    Copy-Item -Path ".\rootModule.psm1" -Destination "$newModulePath\$moduleName\$moduleName.psm1"
    
    $Params = @{ 
        "Path"                 = "$newModulePath\$ModuleName\$ModuleName.psd1"
        "Author"               = 'James Snyder' 
        "CompanyName"          = 'jrsnyder.tech' 
        "RootModule"           = "$ModuleName.psm1" 
        "CompatiblePSEditions" = @('Desktop', 'Core') 
        "CmdletsToExport"      = @() 
        "VariablesToExport"    = '' 
        "AliasesToExport"      = @() 
        "Description"          = "$Description" 
    } 
    New-ModuleManifest @Params
    
    Explorer "C:\PowerShellModules\$ModuleName" 
}