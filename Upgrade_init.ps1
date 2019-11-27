param (
    [string]$environment = $( Read-Host "Input environment (Example-Integration)" ),
    [string]$hostname = $( Read-Host "Input hostname (Example-AWSINTMIRTH01)" ),
    [string]$currentversion = $( Read-Host "Input current version (Example-Mirth-342)" ),
    [string]$newversion = $( Read-Host "Input new version (Example-Mirth-361)" ),
    [string]$date = $( Read-Host "Input date (Format-YYYYMMDD)" ),
    [string]$attempt = $( Read-Host "Input attempt (Example-01)" )
 ) 

$UPGRADE_ROOT = -Join("HHH_Mirth_Upgrade_",${environment},"_",${hostname},"_",${currentversion},"_",${newversion},"_",${date},"_",${attempt})
$ROOT = Join-Path 'C:\' -ChildPath $UPGRADE_ROOT | Join-Path -ChildPath "Backup"
$UPGRADE = Join-Path 'C:\' -ChildPath $UPGRADE_ROOT | Join-Path -ChildPath "Upgrade"

@('Alerts', 'App_Files', 'Channels', 'DB', 'Extensions', 'Logs', 'Server_Ports', 'Settings', 'Installer', 'Users') |
    ForEach-Object {
        New-Item (Join-Path $ROOT -ChildPath $_) -ItemType Directory -force
    }

#Channels sub-dir
$CHANNELS = Join-Path $ROOT -ChildPath "Channels"

@('Dashboard', 'Export', 'Code_Templates', 'Global_Scripts', 'Groups') |
    ForEach-Object {
        New-Item (Join-Path $CHANNELS -ChildPath $_) -ItemType Directory -force
    }

#DB sub-dir
New-Item (Join-Path $ROOT -ChildPath "DB" | Join-Path -ChildPath "Mirth_DB") -ItemType Directory -Force

#Settings sub-dir
$SETTINGS = Join-Path $ROOT -ChildPath "Settings"

@('Administrator', 'Configuration_Map', 'Data_Pruner', 'Resources', 'Server_Config') |
    ForEach-Object {
        New-Item (Join-Path $SETTINGS -ChildPath $_) -ItemType Directory -force
    }

#Extensions\ sub-dirs 
New-Item (Join-Path $ROOT -ChildPath "Extensions" | Join-Path -ChildPath "Connectors") -ItemType Directory -Force
New-Item (Join-Path $ROOT -ChildPath "Extensions" | Join-Path -ChildPath "Plugins") -ItemType Directory -Force

#Upgrade Dir
New-Item (Join-Path $UPGRADE -ChildPath "Installer") -ItemType Directory -Force
New-Item (Join-Path $UPGRADE -ChildPath "Extensions") -ItemType Directory -Force

#Copy contents of Mirth Program files to Backup
$sourceRoot = "C:\Program Files\Mirth Connect"
$parentRoot = (Join-Path $ROOT -ChildPath "App_Files" | Join-Path -ChildPath "Mirth Connect")

#Copy-Item -Path (Join-Path $sourceRoot -ChildPath "conf\") -Recurse -Destination (Join-Path $parentRoot -ChildPath "conf\") -Container
#Copy-Item -Path (Join-Path $sourceRoot -ChildPath "mcserver.vmoptions") -Recurse -Destination (Join-Path $parentRoot -ChildPath "mcserver.vmoptions") -Container
#Copy-Item -Path (Join-Path $sourceRoot -ChildPath "mcservice.vmoptions") -Recurse -Destination (Join-Path $parentRoot -ChildPath "mcservice.vmoptions") -Container
#Copy-Item -Path (Join-Path $sourceRoot -ChildPath "custom-lib\") -Recurse -Destination (Join-Path $parentRoot -ChildPath "custom-lib\") -Container
#Copy-Item -Path (Join-Path $sourceRoot -ChildPath "appdata\*" ) -Destination (Join-Path $parentRoot -ChildPath "appdata\" ) -Container

Compress-Archive -Path "C:\Program Files\Mirth Connect" -DestinationPath $parentroot