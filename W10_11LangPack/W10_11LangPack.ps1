#Requires -Version 5.1

# Cumulative Update for Windows 11 Insider Preview (10.0.26100.1)
# Windows 11, version 22H2 (22621.1)
# Windows 11 Insider Preview 10.0.22000.1 (co_release)
# Cumulative Update for Windows 10 Version 2004 (19041.84) (2)
# Cumulative Update for Windows 10 Version 1903 (18362.30)
# Feature update to Windows 10, version 1809 (17763.1)

$UUP_Table = ConvertFrom-Csv @'
    UpdateID,                              Version, Arch
    082a33fb-8cb5-4cc6-abb3-611c3f7ecd35,  "W11 26H1", x64
    950545af-8cd0-49ce-bc8c-789258edc8ba,  "W11 26H1", arm64
    82bfaf56-2ef9-49ce-89fa-daa9c9eaff11,  "W11 24H2 & 25H2", x64
    294aa40d-f466-4071-8654-d952a9a68ac1,  "W11 24H2 & 25H2", arm64
    356c1621-04e7-4e66-8928-03a687c3db73,  "W11 22H2 & 23H2", x64
    8c9cea2a-b4d5-49dd-82c4-f79bfac1108e,  "W11 22H2 & 23H2", arm64
    6cc7ea68-b7fb-4de1-bf9b-1f43c6218f6f,  "W11 21H2", x64
    a1b78728-530f-443f-b672-d742e7c14bcb,  "W11 21H2", arm64
    3ead9b43-aa9d-4973-8195-24be0b0ce1e1,  "W10 2004, 20H2, 21H1, 21H2 & 22H2", x64
    70f4293c-6eaa-4db5-b059-9755ab5628d8,  "W10 2004, 20H2, 21H1, 21H2 & 22H2", x86
    bb720c43-af68-4dc6-a397-42f278183314,  "W10 2004, 20H2, 21H1, 21H2 & 22H2", arm64
    71cd47f8-e9b2-422b-b289-103a76016851,  "W10 1903 & 1909", x64
    fe1f4dc3-a596-495d-ad9a-810da62d7ddc,  "W10 1903 & 1909", x86
    3d401b52-605e-4f68-9f85-9b2e5b0169cd,  "W10 1903 & 1909", arm64
    6ce50996-86a2-48fd-9080-4169135a1f51,  "W10 1809", x64
    c5619e9f-a040-472a-a9b7-f7c13e1b935e,  "W10 1809", x86
    298d5b36-db90-4e68-81dc-523a337480a9,  "W10 1809", arm64
'@

$RegionTable = ConvertFrom-Csv @'
    Region,      Language
    ar-sa,       ar-SA Arabic
    bg-bg,       bg-BG Bulgarian
    cs-cz,       cs-CZ Czech
    da-dk,       da-DK Danish
    de-de,       de-DE German
    el-gr,       el-GR Greek
    en-gb,       en-GB English (United Kingdom)
    en-us,       en-US English (United States)
    es-es,       es-ES Spanish
    es-mx,       es-MX Spanish (Mexico)
    et-ee,       et-EE Estonian
    fi-fi,       fi-FI Finnish
    fr-ca,       fr-CA French (Canada)
    fr-fr,       fr-FR French
    he-il,       he-IL Hebrew
    hr-hr,       hr-HR Croatian
    hu-hu,       hu-HU Hungarian
    it-it,       it-IT Italian
    ja-jp,       ja-JP Japanese
    ko-kr,       ko-KR Korean
    lt-lt,       lt-LT Lithuanian
    lv-lv,       lv-LV Latvian
    nb-no,       nb-NO Norwegian
    nl-nl,       nl-NL Dutch
    pl-pl,       pl-PL Polish
    pt-br,       pt-BR Portuguese (Brazil)
    pt-pt,       pt-PT Portuguese
    ro-ro,       ro-RO Romanian
    ru-ru,       ru-RU Russian
    sk-sk,       sk-SK Slovak
    sl-si,       sl-SI Slovenian
    sr-latn-rs,  sr-latn-rs Serbian (Latin)
    sv-se,       sv-SE Swedish
    th-th,       th-TH Thai
    tr-tr,       tr-TR Turkish
    uk-ua,       uk-UA Ukrainian
    zh-cn,       zh-CN Chinese (Simplified)
    zh-tw,       zh-TW Chinese (Traditional)
'@

$ESD2CAB_URL = 'https://gitlab.com/-/project/11037551/uploads/5b69afdf73b2ae6a874c46255d677f85/ESD2CAB-CAB2ESD-3.zip'

function Run_ESD2CAB {
    if ($env:PROCESSOR_ARCHITECTURE -eq 'x86') { $imagex = 'imagex86.exe' }
        else { $imagex = 'imagex64.exe' }

    try {
        $ZIPfile = "$env:TEMP\ESD2CAB.zip"
        Invoke-WebRequest -UseBasicParsing -Uri $ESD2CAB_URL -OutFile $ZIPfile

        $Working_Folder = $PWD.Path

        $objShell = New-Object -ComObject 'Shell.Application'
        $objFolder = $objShell.NameSpace($Working_Folder)

        $objFolder.CopyHere("$ZIPfile\esd2cab_CLI.cmd", 0x14)

        $null = New-Item -Path $Working_Folder -Name 'bin' -ItemType Directory -Force

        $objShell = New-Object -ComObject 'Shell.Application'
        $objFolder = $objShell.NameSpace("$Working_Folder\bin")

        $objFolder.CopyHere("$ZIPfile\bin\cabarc.exe", 0x14)
        $objFolder.CopyHere("$ZIPfile\bin\$imagex", 0x14)
        $objFolder.CopyHere("$ZIPfile\bin\SxSExpand.exe", 0x14)

        Remove-Item $ZIPfile -Force
    }
    catch {
        $_.Exception.Message
        exit 1
    }

    try {
        Write-Host "`nRunning ESD2CAB script."
        $Process = Start-Process 'cmd' -WorkingDirectory $Working_Folder -ArgumentList '/c .\esd2cab_CLI.cmd /q' -PassThru -Wait
    }
    catch {
        $_.Exception.Message
        exit 1
    }
    Write-Host 'Script exited.'

    Remove-Item "$Working_Folder\esd2cab_CLI.cmd" -Force
    Remove-Item "$Working_Folder\bin" -Recurse -Force
    Remove-Item "$Working_Folder\temp[1-9]*" -Recurse -Force

    return $Process.ExitCode
}

$ListBoxCheck = {
    if ($Version_ListBox.SelectedItem -match 'W11' -and $Arch_ListBox.SelectedItem -eq 'x86') {
        $Arch_ListBox.SelectedItems.Clear()
        $OKButton.Enabled = $false
    }
    if ($Version_ListBox.SelectedIndex -gt -1 -and $Arch_ListBox.SelectedIndex -gt -1 -and $Language_ListBox.SelectedIndex -gt -1) {
        $OKButton.Enabled = $true
    }
}

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

[System.Windows.Forms.Application]::EnableVisualStyles()

$objForm = New-Object System.Windows.Forms.Form
$objForm.Size = New-Object System.Drawing.Size(750,420)
$objForm.StartPosition = 'CenterScreen'
$objForm.MaximizeBox = $false
$objForm.Text = 'W10-11 Language Packs v2.10'

if ($PSVersionTable.PSVersion.Major -le 5) {
    $objForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("$PSHOME\powershell.exe")
}
else {
    $objForm.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("$PSHOME\pwsh.exe")
}

if (([System.Environment]::OSVersion.Version).Major -gt 6) {
    $FontSize = 12
}
else {
    $FontSize = 8
}

$Version_Label = New-Object System.Windows.Forms.Label
$Version_Label.Location = New-Object System.Drawing.Point(25,15)
$Version_Label.AutoSize = $true
$Version_Label.Font = [System.Drawing.Font]::new($Version_Label.Font.Name, $FontSize, [System.Drawing.FontStyle]::Bold)
$Version_Label.Text = 'Version'

$objForm.Controls.Add($Version_Label)

$Version_ListBox = New-Object System.Windows.Forms.ListBox
$Version_ListBox.Location = New-Object System.Drawing.Point(25,40)
$Version_ListBox.Size = New-Object System.Drawing.Size(290,20)
$Version_ListBox.Height = 125
$Version_ListBox.Font = [System.Drawing.Font]::new($Version_ListBox.Font.Name, $FontSize)
$Version_ListBox.add_SelectedIndexChanged($ListBoxCheck)

$Version_ListBox.UseTabStops = $true
$Version_ListBox.UseCustomTabOffsets = $true
$Version_ListBox.CustomTabOffsets.AddRange(@(6))

$pattern = [regex]' '

foreach ($item in (($UUP_Table).Version | select -Unique)) {
    [void] $Version_ListBox.Items.Add($pattern.Replace($item,"`t",1))
}
$objForm.Controls.Add($Version_ListBox)

$Arch_Label = New-Object System.Windows.Forms.Label
$Arch_Label.Location = New-Object System.Drawing.Point(335,15)
$Arch_Label.AutoSize = $true
$Arch_Label.Font = [System.Drawing.Font]::new($Arch_Label.Font.Name, $FontSize, [System.Drawing.FontStyle]::Bold)
$Arch_Label.Text = 'Arch'

$objForm.Controls.Add($Arch_Label)

$Arch_ListBox = New-Object System.Windows.Forms.ListBox
$Arch_ListBox.Location = New-Object System.Drawing.Point(335,40)
$Arch_ListBox.Size = New-Object System.Drawing.Size(65,20)
$Arch_ListBox.Height = 70
$Arch_ListBox.Font = [System.Drawing.Font]::new($Arch_ListBox.Font.Name, $FontSize)
$Arch_ListBox.add_SelectedIndexChanged($ListBoxCheck)

[void] $Arch_ListBox.Items.AddRange(@('x64','x86','arm64'))
$objForm.Controls.Add($Arch_ListBox)

$Language_Label = New-Object System.Windows.Forms.Label
$Language_Label.Location = New-Object System.Drawing.Point(430,15)
$Language_Label.AutoSize = $true
$Language_Label.Font = [System.Drawing.Font]::new($Language_Label.Font.Name, $FontSize, [System.Drawing.FontStyle]::Bold)
$Language_Label.Text = 'Language'

$objForm.Controls.Add($Language_Label)

$Language_ListBox = New-Object System.Windows.Forms.ListBox
$Language_ListBox.Location = New-Object System.Drawing.Point(430,40)
$Language_ListBox.Size = New-Object System.Drawing.Size(285,20)
$Language_ListBox.Height = 265
$Language_ListBox.Font = [System.Drawing.Font]::new($Language_ListBox.Font.Name, $FontSize)
$Language_ListBox.add_SelectedIndexChanged($ListBoxCheck)

$Language_ListBox.SelectionMode = 'MultiSimple'
$Language_ListBox.UseTabStops = $true
$Language_ListBox.UseCustomTabOffsets = $true

$pattern = [regex]' '

foreach ($item in $RegionTable.Language) {
    [void] $Language_ListBox.Items.Add($pattern.Replace($item,"`t",1))
}
$objForm.Controls.Add($Language_ListBox)

$ESD2CAB_Link = New-Object System.Windows.Forms.LinkLabel
$ESD2CAB_Link.Location = New-Object System.Drawing.Point(25,283)
$ESD2CAB_Link.AutoSize = $true
$ESD2CAB_Link.Font = [System.Drawing.Font]::new($ESD2CAB_Link.Font.Name, $FontSize)
$ESD2CAB_Link.Text = 'ESD2CAB by abbodi1406'
$ESD2CAB_Link.add_Click({ [System.Diagnostics.Process]::Start($ESD2CAB_URL) })

$objForm.Controls.Add($ESD2CAB_Link)

$Center = $objForm.Size.Width / 2
$Height = $objForm.Size.Height

$FormGraphics = $objForm.CreateGraphics()
$Pen = New-Object Drawing.Pen Black
#$objForm.Add_Paint({$FormGraphics.DrawLine($Pen,$Center,0,$Center,$Height)})
#$objForm.Add_Paint({$FormGraphics.DrawLine($Pen,($Center + 1),0,($Center + 1),$Height)})

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(($Center - 78),($Height - 90))
$OKButton.Size = New-Object System.Drawing.Size(75,30)
$OKButton.Font = [System.Drawing.Font]::new($OKButton.Font.Name, $FontSize)
$OKButton.Text = 'OK'
$OKButton.FlatStyle = 'Standard'
$OKButton.Add_Click({ $OKButton.Enabled = $false })
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK

$objForm.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(($Center + 5),($Height - 90))
$CancelButton.Size = New-Object System.Drawing.Size(75,30)
$CancelButton.Font = [System.Drawing.Font]::new($CancelButton.Font.Name, $FontSize)
$CancelButton.Text = 'Cancel'
$CancelButton.FlatStyle = 'Standard'
$CancelButton.Add_Click({ $objForm.Close() })

$objForm.Controls.Add($CancelButton)

$objForm.Topmost = $True
$objForm.Add_Shown({ $objForm.Activate() })

$OKButton.Enabled = $false
$Result = $objForm.ShowDialog()

if ($Result -ne [System.Windows.Forms.DialogResult]::OK) {
    Exit
}

$Version = $Version_ListBox.SelectedItem -replace "`t"," "
$Arch = $Arch_ListBox.SelectedItem
$Selected_Langs = @($Language_ListBox.SelectedItems | foreach { $_ -replace "`t"," " })

[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$HashList = New-Object System.Collections.ArrayList

foreach ($Language in $Selected_Langs) {
    $UpdateID = ($UUP_Table | Where { $_.Version -eq $Version -and $_.Arch -eq $Arch }).UpdateID
    $Region = ($RegionTable | Where { $_.Language -eq $Language }).Region

    try {
<#  FALLBACK URL METHOD
        $Links = (Invoke-WebRequest -UseBasicParsing -Method Get -Uri "https://uupdump.net/get.php?id=$UpdateID&pack=$Region&edition=core" `
            -ContentType 'application/x-www-form-urlencoded').Links
#>
        $JSON = Invoke-RestMethod -UseBasicParsing -Method Get -Uri "https://api.uupdump.net/get.php?id=$UpdateID&lang=$Region&edition=core"
    }
    catch {
        $_.Exception.Message
        Exit 1
    }

    $Lang = $Region.Split('-')[0]
    $File_List = ((ConvertTo-Csv -InputObject $JSON.response.files)[1] -split ',' | Where { $_ -like "*Language*$Lang-*" }) -replace '"'

<#  FALLBACK URL METHOD
    foreach ($link in ($Links.outerHTML -like "*Language*-$Lang-*")) {
        $URL = $link.Split('"')[1]
        $Filename = $link.Split('>')[1].Split('<')[0] -replace '\s',''
#>
    foreach ($File in $File_List) {
        $URL = $JSON.response.files.$File.url
        $Filename = $File

        $PackageName = ($Filename -split ('[_-]' + $Lang))[0]

        $Filename = $Filename -replace '^cabs_' -replace $PackageName, [cultureinfo]::GetCultureInfo('en-US').TextInfo.ToTitleCase($PackageName)
        $Filename = $Filename -replace 'Amd64','amd64' -replace 'Arm64','arm64' -replace 'Ocr','OCR'
        foreach ($word in ('Feat','Pack','ToSpeech')) {
            $Filename = $Filename -replace $word.ToLower(), $word
        }

        if (-not (Test-Path -Path $Filename -PathType Leaf) -and -not (Test-Path -Path ($Filename -replace '\.esd','.cab') -PathType Leaf)) {
            try {
                'Downloading "{0}"' -f $Filename
                $LastModified = (Invoke-WebRequest -UseBasicParsing -Uri $URL -Method HEAD).Headers.'Last-Modified'
                $Response = Invoke-WebRequest -UseBasicParsing -Uri $URL -OutFile $Filename

                $File = Get-Item -Path $Filename
                $File.CreationTime = $File.LastWriteTime = $LastModified

                $null = $HashList.Add([PSCustomObject]@{
                    'Package' = "$Filename "
                    'SHA-1' =  (Get-FileHash -Algorithm SHA1 -Path $Filename).Hash.ToLower()
                })
            }
            catch {
                $_.Exception.Message
            }
        }
        else {
            'Duplicate file "{0}"' -f $Filename
        }
    }
}

if ($HashList.Count -gt 0) {
    ($HashList | Format-Table -AutoSize | Out-String).TrimEnd("`r`n`r`n")
}

if ((Get-ChildItem *.esd).Count) {
    if ($(Run_ESD2CAB) -eq 0) {
        Remove-Item *.esd -Force
    }
}
