 <#
.SYNOPSIS
    Test the volume specified 
.DESCRIPTION
    Can be specified to target a specific volume for testing
.PARAMETER Target
<<<<<<< HEAD
    Specifies the Drive Letter of the volume to test
=======
    Specifies the drive letter or file system label of the volume to test
>>>>>>> upstream/master
.PARAMETER Property
    Specifies an optional property to test for on the volume
.PARAMETER Should 
    A Script Block defining a Pester Assertion.
.EXAMPLE
 Volume C HealthStatus { Should be 'Healthy' }
.EXAMPLE
 Volume C FileSystem { Should be 'NTFS' }
<<<<<<< HEAD

.NOTES
    Assertions: Be
#> 
  
function Volume {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position=1)]
        [Alias('Name')]
        [string]$Target,
        
        [Parameter(Position=2)]
        [ValidateSet("FileSystem","DriveType","HealthStatus","SizeRemaining","size")]
        [string]$Property,

        [Parameter(Mandatory, Position=3)]
        [scriptblock]$Should
    )
     
    $expression = {Get-Volume -DriveLetter '$Target' -ErrorAction SilentlyContinue}
    
    $params = Get-PoshspecParam -TestName Volume -TestExpression $expression @PSBoundParameters
    
    Invoke-PoshspecExpression @params
}
=======
 .EXAMPLE
 Volume D AllocationUnitSize { Should be 64K }
.EXAMPLE
 Volume MyFileSystemLabel SizeRemaining { Should BeGreaterThan 1GB }
.NOTES
    Assertions: Be
#>  
  
function Volume {
    [CmdletBinding(DefaultParameterSetName="Default")]
    param(
        [Parameter(Mandatory, Position=1,ParameterSetName="Default")]
        [Parameter(Mandatory, Position=1,ParameterSetName="Property")]
        [Alias('Name')]
        [string]$Target,
        
        [Parameter(Position=2,ParameterSetName="Property")]
        [ValidateSet('AllocationUnitSize', 'DedupMode', 'DriveLetter', 'DriveType', 'FileSystem', 'FileSystemLabel',
                     'FileSystemType', 'HealthStatus', 'ObjectId', 'OperationalStatus', 'Path', 'Size', 'SizeRemaining')]
        [string]$Property,

        [Parameter(Mandatory, Position=2,ParameterSetName="Default")]
        [Parameter(Mandatory, Position=3,ParameterSetName="Property")]
        [scriptblock]$Should
    )

    function GetVolume([string]$Name) {
        if ($Name.Length -eq 1) {
            $v = Get-Volume -DriveLetter $Name -ErrorAction SilentlyContinue
            if (-not $v) {
                $v = Get-Volume -FileSystemLabel $Name  -ErrorAction SilentlyContinue    
            }
        } else {
            $v = Get-Volume -FileSystemLabel $Name  -ErrorAction SilentlyContinue
        }
        $v
    }
    
    $expression = { GetVolume -Name '$Target' }
                 
    $params = Get-PoshspecParam -TestName Volume -TestExpression $expression @PSBoundParameters
    
    Invoke-PoshspecExpression @params
}
>>>>>>> upstream/master
