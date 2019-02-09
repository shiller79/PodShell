function Import-Opml {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $Path
    )
        
    Begin {

    }
    Process {
        [Podcast[]]$ReturnObject = $null
        [xml]$OPML = Get-Content $Path -Encoding UTF8
        foreach ($Node in  (Select-Xml -Xml $OPML -XPath "//outline[@xmlUrl]").Node) {
            $NodeObject = [Podcast]::new()
            $NodeObject.Title = $Node.text
            $NodeObject.XmlUrl = $Node.xmlUrl
            $NodeObject.HtmlUrl = $Node.htmlUrl
            $ReturnObject += $NodeObject
        }
        return $ReturnObject
    }
    End {

    }
}
Export-ModuleMember Import-Opml