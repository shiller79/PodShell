#
# Modulmanifest für das Modul "fyyd"
#
# Generiert von: Sascha Hiller
#
# Generiert am: 17.12.2018
#

@{

# Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
# RootModule = ''

# Die Versionsnummer dieses Moduls
ModuleVersion = '1.0'

# Unterstützte PSEditions
# CompatiblePSEditions = @()

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = '3f5a0441-ec4e-4d5e-8fb6-7d6d9d28597e'

# Autor dieses Moduls
Author = 'Sascha Hiller'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'Unbekannt'

# Urheberrechtserklärung für dieses Modul
Copyright = '(c) 2018 hiller. Alle Rechte vorbehalten.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
# Description = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
PowerShellVersion = '3.0'

# Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Die für dieses Modul mindestens erforderliche Microsoft .NET Framework-Version. Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
# DotNetFrameworkVersion = ''

# Die für dieses Modul mindestens erforderliche Version der CLR (Common Language Runtime). Diese erforderliche Komponente ist nur für die PowerShell Desktop-Edition gültig.
# CLRVersion = ''

# Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
NestedModules = @(
    '.\Get-FyydAccountCollections.ps1',
    '.\Get-FyydAccountCurations.ps1',
    '.\Get-FyydAccountInfo.ps1',
    '.\Get-FyydCategories.ps1',
    '.\Get-FyydCategory.ps1',
    '.\Get-FyydCollection.ps1',
    '.\Get-FyydCurate.ps1',
    '.\Get-FyydCuration.ps1',
    '.\Get-FyydCurationEpisodes.ps1',
    '.\Get-FyydEpisode.ps1',
    '.\Get-FyydEpisodeCurations.ps1',
    '.\Get-FyydPodcast.ps1',
    '.\Get-FyydPodcastEpisodes.ps1',
    '.\Get-FyydPodcastSeason.ps1',
    '.\Invoke-FyydApi.ps1',
    '.\Invoke-FyydLogin.ps1',
    '.\New-FyydCuration.ps1',
    '.\Remove-FyydCuration.ps1',
    '.\Search-FyydCuration.ps1',
    '.\Search-FyydEpisode.ps1',
    '.\Search-FyydPodcast.ps1',
    '.\Set-FyydCurate.ps1',
    '.\Set-FyydCuration.ps1'
    )

# Aus diesem Modul zu exportierende Funktionen. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Funktionen vorhanden sind.
FunctionsToExport = @()

# Aus diesem Modul zu exportierende Cmdlets. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Cmdlets vorhanden sind.
CmdletsToExport = @(
    'Get-FyydAccountCollections',
    'Get-FyydAccountCurations',
    'Get-FyydAccountInfo',
    'Get-FyydCategories',
    'Get-FyydCategory',
    'Get-FyydCurate',
    'Get-FyydCuration',
    'Get-FyydCurationEpisodes',
    'Get-FyydEpisode',
    'Get-FyydEpisodeCurations',
    'Get-FyydPodcast',
    'Get-FyydPodcastEpisodes',
    'Get-FyydPodcastSeason',
    'Invoke-FyydApi',
    'Invoke-FyydLogin',
    'New-FyydCuration',
    'Remove-FyydCuration',
    'Search-FyydCuration',
    'Search-FyydEpisode',
    'Search-FyydPodcast',
    'Set-FyydCurate',
    'Set-FyydCuration'
)

# Die aus diesem Modul zu exportierenden Variablen
VariablesToExport = '*'

# Aus diesem Modul zu exportierende Aliase. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Aliase vorhanden sind.
AliasesToExport = @()

# Aus diesem Modul zu exportierende DSC-Ressourcen
# DscResourcesToExport = @()

# Liste aller Module in diesem Modulpaket
# ModuleList = @()

# Liste aller Dateien in diesem Modulpaket
# FileList = @()

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
PrivateData = @{

    PSData = @{

        # 'Tags' wurde auf das Modul angewendet und unterstützt die Modulermittlung in Onlinekatalogen.
        # Tags = @()

        # Eine URL zur Lizenz für dieses Modul.
        # LicenseUri = ''

        # Eine URL zur Hauptwebsite für dieses Projekt.
        # ProjectUri = ''

        # Eine URL zu einem Symbol, das das Modul darstellt.
        # IconUri = ''

        # 'ReleaseNotes' des Moduls
        # ReleaseNotes = ''

    } # Ende der PSData-Hashtabelle

} # Ende der PrivateData-Hashtabelle

# HelpInfo-URI dieses Moduls
# HelpInfoURI = ''

# Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
# DefaultCommandPrefix = ''

}
