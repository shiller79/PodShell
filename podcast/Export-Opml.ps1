function Export-Opml {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true, Position = 0)]
        [Object[]]$Podcast,

        [Parameter(Mandatory = $true, Position = 1)]
        [string] $Path
    )
        
    Begin {
        [System.Xml.XmlDocument]$OutOpml = ""
        $root = $OutOpml.CreateElement('opml')
        $root.SetAttribute('version', '1.0')
        $null = $OutOpml.AppendChild($root)
    
        $head = $OutOpml.CreateElement('head')
        $null = $root.AppendChild($head)
        #Generate RFC 822 Date
        [string]$datestring = '{0:R}' -f (Get-Date)
        $dateCreated = $OutOpml.CreateElement('dateCreated')
        $dateCreated.InnerText = $datestring
        $null = $head.AppendChild($dateCreated)
        $body = $OutOpml.CreateElement('body')
        $null = $root.AppendChild($body)
    }
    Process {

        $outline = $OutOpml.CreateElement('outline')
        $outline.SetAttribute('title', $Podcast.Title)
        $outline.SetAttribute('text', $Podcast.Title)
        $outline.SetAttribute('type', 'rss')
        $outline.SetAttribute('xmlUrl', $Podcast.XmlUrl)
        $outline.SetAttribute('htmlUrl', $Podcast.htmlUrl)
        $null = $body.AppendChild($outline)


    }
    End {
        
        $xmlWriterSettings = new-object System.Xml.XmlWriterSettings
        $xmlWriterSettings.CloseOutput = $true
        # 4 space indent
        $xmlWriterSettings.IndentChars = '    '
        $xmlWriterSettings.Indent = $true
        # $xmlWriterSettings.ConformanceLevel = 2
        write-verbose  $('xml formatting - writing to ' + $Path)
        $xmlWriter = [System.Xml.XmlWriter]::Create($Path, $xmlWriterSettings)
        $OutOpml.Save($xmlWriter)
        $xmlWriter.Close()
    }
}

Export-ModuleMember Export-Opml