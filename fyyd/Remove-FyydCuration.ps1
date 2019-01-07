<#
.Synopsis
    Deletes a curation.
.DESCRIPTION
    Deletes a curation. Please note: there's no coming back, no questions, no backup. It's deleted!
    Please note also: You cannot delete your very own personal curation, it's tied to your account.
.EXAMPLE
    Remove-FyydCuration -id 3133
#>
function Remove-FyydCuration {
	[CmdletBinding()]
	param (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$false, Position=0)]
        [Alias("id")]
        [int] $curation_id
    )
    
    Begin {}
    Process {
        [string[]] $parameter = @()     # init parameter array

        $parameter += "curation_id=$curation_id"

        $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/curation/delete" -method "Post" 

        return $jsondata.data
    }
    End{}
}

Export-ModuleMember Remove-FyydCuration