# PodShell

PodShell is a PowerShell module that provides cmdlts for managing podcasts.
In the first version it's mainly scripts for querying the fyyd.de API
Further modules are planned

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

PowerShell 3.0+

### Installing

Downlaod and unzip https://github.com/shiller79/PodShell/archive/master.zip

Allow Execution of unsigned PowerShell scripts as Administrator if not already enabled.
```
Set-ExecutionPolicy Bypass
```

Load the Module
```
Import-Module .\PodShell.psd1
```

Test a cmdlet
```
Get-FyydCategories
```

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details