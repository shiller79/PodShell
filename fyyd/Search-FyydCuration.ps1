<#
.Synopsis
    This request tries to find a curation inside fyyd's database, matching any or some of a set of given criteria.
.DESCRIPTION
    This request tries to find a curation inside fyyd's database, matching any or some of a set of given criteria.
.Parameter category_id
    the id of a podcast category that this curation belongs to.
.Parameter term
    a search term to find inside the curation.

.EXAMPLE
    Search-FyydCuration -term "34c3"
#>
function Search-FyydCuration {
    [CmdletBinding()]
	param (
        [Parameter(Mandatory=$false)]
        [int] $category_id,
    
        [Parameter(Mandatory=$false)]
        [string] $term,

        [Parameter(Mandatory=$false)]
        [int] $count = 10
    )
    
    [string[]] $parameter = @()     # init parameter array
    if ($category_id) { $parameter += "category_id=$category_id" }
    if ($term) { $parameter += "term=$term" }
    $parameter += "count=$count"
    
    $jsondata = Invoke-FyydApi -parameter $parameter -endpoint "/search/curation" -method "Get"

    return $jsondata.data
}

Export-ModuleMember Search-FyydCuration