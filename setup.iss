[Setup]
AppName=Flixstar
AppVersion=1.0
DefaultDirName={autopf}\Flixstar
DefaultGroupName=Flixstar
OutputDir=output
OutputBaseFilename=FlixstarInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "build\windows\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Flixstar"; Filename: "{app}\Flixstar.exe"

[Run]
Filename: "{app}\Flixstar.exe"; Description: "{cm:LaunchProgram,Flixstar}"; Flags: nowait postinstall skipifsilent
