
; ----------------------------------------------------------------------
; A P P I D
; To successfully run this installation and the program it installs,
; you must have a "x64" edition of Windows.
;
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
; ----------------------------------------------------------------------
; WHY IS THERE TWO LEADING BRACKETS?
; Compiler Error!  Use two consecutive "{" characters if you are trying to 
; embed a single "{" and not a constant.

#define MyAppId "{{72B7C44E-B05E-4D94-B166-D7613E3E7AA9}"
#define MyAppName "SCM MoreReports"
#define MyAppExeName "SCM_MoreReports.exe"
#define MyInnoOutputDir "C:\Users\Ben\Documents\GitHub\SCM_MoreReports\DEPLOY\INNO\OUTPUT\"
#define MyAppIconFileName "SCM_MoreReports.ico"
#define MyAppVersion "1.0"
#define MyAppVersionL "1.0.0.0"
#define MyAppPublisher "Artanemus"
#define MyAppURL "https://artanemus.github.io"

; Embarcadero compile directory 
; SPECIAL NOTE : 'Link with RunTime Packages' = UNCHECKED
;   (SINGLE EXE FILE - TYPICALLY FOR PASCAL PROJECTS USED HERE IN RAD STUDIO C++)
#define MyReleaseBuildDir "C:\Users\Ben\Documents\GitHub\SCM_MoreReports\Win32\Release\"

; DEPLOY (INNO project folder, ChangeLog.txt, License.rtf,  ReadMe.txt, QuickStartReadMe.txt)
#define MyDeployDir "C:\Users\Ben\Documents\GitHub\SCM_MoreReports\DEPLOY\"

; ASSETS (icons, image, wav, powershell scripts for ImageMagick)
#define MyAssetDir "C:\Users\Ben\Documents\GitHub\SCM_MoreReports\ASSETS\"

; Adobe ROBOHELP for MoreReports COMPILED WinHelp files - OUTPUT DIR
; RoboHelp PROJECT LOCATED AT C:\Users\Ben\Documents\GitHub\SCM_RoboHelp
; #define MyHelpDir "C:\Users\Ben\Documents\GitHub\artanemus.github.io\manual\"

; Adobe Robohelp WebHelp build ... TBA
;#define MyHTMLHelpDir "C:\Users\Ben\Documents\GitHub\SCM_RoboHelp\source\repos\...\WebHelp\"

; common app directory + subpath SCM, OBS, etc...
#define MySubPath "\Artanemus\SCM\";


[Setup]
;By default, the compiler expects to find files referenced in the script's [Files] section Source parameters, and files 
;referenced in the [Setup] section, under the same directory the script file is located if they do not contain fully 
;qualified pathnames. To specify a different source directory, create a SourceDir directive in the script's [Setup] section.
;Specifies the name(s) of the bitmap file(s) to display in the upper right corner of the wizard. Wildcards are supported and 
;the file(s) must be located in your installation's source directory when running the compiler, unless a fully qualified 
;pathname is specified or the pathname is prefixed by "compiler:", in which case it looks for the file in the compiler directory.

;WizardImageFile - the left side of the wizard
;100% 164x314 
;125% 192x386 
;150% 246x459 
;175% 273x556 
;200% 328x604 
;225% 355x700 
;250% 410x797 

;WizardSmallImageFile - upper right corner of the wizard
;100% 55x55 
;125% 64x68 
;150% 83x80 
;175% 92x97 
;200% 110x106 
;225% 119x123 
;250% 138x140 


WizardStyle=modern
WindowResizable=yes
WizardSizePercent=120,120
; if no SoureDir is specified - uses same directory the script file is located. Must be BMP. WildCards allowed?
WizardSmallImageFile=WizardSmall_SCM_*.bmp
WizardImageFile=WizardImage_SCM_*.bmp
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;The path to the current user's Program Files directory. Only Windows 7 and later supports {userpf}
;if used on previous Windows versions, it will translate to the same directory as {localappdata}\Programs.
DefaultDirName={autopf}\{#MyAppPublisher}\MoreReports
DefaultGroupName={#MyAppPublisher}\MoreReports
;This lets you specify a particular icon file (either an executable or an .ico file) to display for the 
;Uninstall entry in the Add/Remove Programs Control Panel applet. The filename will normally begin with 
;a directory constant.
UninstallDisplayIcon={uninstallexe}
Compression=lzma2
SolidCompression=yes
OutputDir={#MyInnoOutputDir}
OutputBaseFilename={#MyAppName}_32bit_v{#MyAppVersionL}
;Specifies a custom program icon to use for Setup/Uninstall. The file must be located in your installation's 
;source directory when running the compiler, unless a fully qualified pathname is specified or the pathname 
;is prefixed by "compiler:", in which case it looks for the file in the compiler directory.
;It is recommended to include at least the following sizes IN your icon: 16x16, 32x32, 48x48, 64x64, and 256x256.
SetupIconFile={#MyAppIconFileName}

; STUFF STILL TO CHECK
; ----------------------------------------------------------------------
AppPublisher={#MyAppPublisher}
AppCopyright=Copyright (c) 2019-2022 {#MyAppPublisher}.
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/Support
AppUpdatesURL={#MyAppURL}/Updates
LicenseFile={#MyDeployDir}LICENSE.txt
VersionInfoVersion={#MyAppVersionL}
VersionInfoCompany={#MyAppPublisher}
VersionInfoDescription=SwimClubMeet (SCM) MoreReports 
VersionInfoCopyright=Copyright (c) 2019-2022 {#MyAppPublisher}.
VersionInfoProductName={#MyAppName}
VersionInfoProductVersion={#MyAppVersion}
VersionInfoProductTextVersion= {#MyAppVersion}
PrivilegesRequired=none
DisableStartupPrompt=False
DisableWelcomePage=False
InfoBeforeFile={#MyDeployDir}ReadMe.txt
ShowTasksTreeLines=True
AlwaysShowGroupOnReadyPage=True
AlwaysShowDirOnReadyPage=True
AppContact={#MyAppURL}/Contact
AppReadmeFile={#MyDeployDir}ReadMe.txt
AppComments=Additional reporting for the SwimClubMeet meet manger.
;AppSupportPhone={#MyAppURL}/Support
RestartApplications=True
UninstallDisplayName=SwimClubMeet (SCM) MoreReports

; "ArchitecturesAllowed=x64" specifies that Setup cannot run on
; anything but x64.
;ArchitecturesAllowed=x64
; "ArchitecturesInstallIn64BitMode=x64" requests that the install be
; done in "64-bit mode" on x64, meaning it should use the native
; 64-bit Program Files directory and the 64-bit view of the registry.
;ArchitecturesInstallIn64BitMode=x64

; ----------------------------------------------------------------------
; A P P I D
; ----------------------------------------------------------------------
AppId={#MyAppId}

; ----------------------------------------------------------------------
; P A S S W O R D   P R O T E C T I O N
; change with each iteration
; ----------------------------------------------------------------------
;Encryption=yes
;Password=69984414-4897-4184-B311-CE64F2DC579F

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create desktop icon"; GroupDescription: "Additional Icons"; Components: SCMcore 
Name: "desktopicon\common"; Description: "For all users"; GroupDescription: "Additional icons"; Flags: exclusive; Components: SCMcore 
Name: "desktopicon\user"; Description: "For the current user only"; GroupDescription: "Additional icons:"; Flags: exclusive unchecked; Components: SCMcore 

[Files]
; Main application file
Source: "{#MyReleaseBuildDir}{#MyAppExeName}"; DestDir: "{app}\"; DestName: "{#MyAppExeName}"; Flags: ignoreversion; Components: SCMcore

; ----------------------------------------------------------------------
; H E L P   F I L E S
; ----------------------------------------------------------------------
; MoreReports Web based help files GENERATED (compiled) by Adobe RoboHelp
; NOTE: Installation destination will be PUBLIC (read ... write) at "c:\ProgramData\Artanemus\SCM\SCMHelp\"
;Source: "{#MyHelpDir}\*"; DestDir: "{commonappdata}{#MySubPath}SCM_Help\"; Flags: ignoreversion recursesubdirs createallsubdirs; Permissions: authusers-modify; Components: SCMhelp

; Other files.
Source: "{#MyDeployDir}ChangeLog.txt"; DestDir: "{app}\"; Flags: ignoreversion; Components: SCMcore
Source: "{#MyDeployDir}License.txt"; DestDir: "{app}\"; Flags: ignoreversion; Components: SCMcore
Source: "{#MyDeployDir}QuickStartReadMe.txt"; DestDir: "{app}\"; Flags: ignoreversion; Components: SCMcore
Source: "{#MyDeployDir}ReadMe.txt"; DestDir: "{app}\"; Flags: ignoreversion; Components: SCMcore
; needed by section icons to set icon for shortcut to help.
;Source: "{#MyDeployDir}INNO\SCM_Help.ico"; DestDir: "{app}\"; Flags: ignoreversion; Components: SCMhelp


[Icons]
Name: "{group}\MoreReports"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}\"; Components: SCMcore
;Name: "{group}\MoreReports Help"; Filename: "{commonappdata}{#MySubPath}SCM_Help\index.htm"; WorkingDir: "{app}\"; IconFilename: "{app}\SCM_Help.ico"; Components: SCMhelp
Name: "{commondesktop}\SCM MoreReports"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}\"; Tasks: desktopicon; Components: SCMcore
;Name: "{commondesktop}\Help for MoreReports"; Filename: "{commonappdata}{#MySubPath}SCM_Help\index.htm"; WorkingDir: "{app}\"; Tasks: desktopicon; IconFilename: "{app}\SCM_Help.ico"; Components: SCMhelp
Name: "{group}\Uninstall MoreReports"; Filename: "{uninstallexe}"; IconFilename: "{app}\{#MyAppExeName}"

[Dirs]
Name: "{app}\"; Flags: uninsalwaysuninstall
; ROOT-DIRECTORIES
Name: "{userappdata}\Artanemus"
Name: "{userappdata}\Artanemus\SCM"; Flags: uninsalwaysuninstall

[Registry]
; Register program name ... a helpful key for other applications
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\{#MyAppExeName}"; ValueType: string; ValueName: "Path"; ValueData: "{app}\{#MyAppExeName}"; Flags: createvalueifdoesntexist uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\{#MyAppExeName}"; ValueType: string; ValueData: "{app}\{#MyAppExeName}"; Flags: createvalueifdoesntexist uninsdeletekey

[Components]
Name: "SCMcore"; Description: "SwimClubMeet (SCM) MoreReports"; Types: full; Flags: fixed
;Name: "SCMhelp"; Description: "Help for MoreReports"; Types: full

[Types]
Name: "full"; Description: "Core application and help files."; Flags: iscustom

[UninstallDelete]
Type: files; Name: "{userappdata}\Artanemus\SCM\SCM_MoreReportsPref.ini"
Type:dirifempty; Name: "{userappdata}\Artanemus\SCM\"
Type:dirifempty; Name: "{userappdata}\Artanemus\"

