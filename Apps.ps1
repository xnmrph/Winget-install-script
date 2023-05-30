#Install New apps
Write-Output "Installing Apps"
$apps = @(
    @{name = "Valve.Steam" }, 
    @{name = "Microsoft.Edge.dev" },
    @{name = "Microsoft.Powertoys" }, 
    @{name = "CodecGuide.K-LiteCodecPack.Standard" }, 
    @{name = "Microsoft.VisualStudioCode" }, 
    @{name = "OBSProject.OBSStudio.Pre-release" }, 
    @{name = "Spotify.Spotify" }, 
    @{name = "Discord.Discord" }, 
    @{name = "7zip.7zip" }, 
    @{name = "ProtonTechnologies.ProtonVPN" },
    @{name = "Elgato.WaveLink"  },
    @{name = "Eugeny.Tabby" },
    @{name = "Bitwarden.Bitwarden" },
    @{name = "Avidemux.Avidemux" },
    @{name = "CPUID.CPU-Z" },
    @{name = "RiotGames.Valorant.EU" }
);
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name --accept-source-agreements 
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing:" $app.name
        if ($app.source -ne $null) {
            winget install --exact --silent $app.name --source $app.source --accept-package-agreements
        }
        else {
            winget install --exact --silent $app.name --accept-package-agreements
        }
    }
    else {
        Write-host "Skipping Install of " $app.name
    }
}
