#Requires -Version 5.1

$KB_List = ConvertFrom-CSV @'
    Filename
    c/kb3012997-x64-cs-cz-client_a1be48cd0dd10065225c522d09114e1f03cd44e9.cab
    c/kb3012997-x64-de-de-client_dee84541b4de632ce0bdea196effa848b08ec585.cab
    c/kb3012997-x64-el-gr-client_b64a8be5f7284260b7725b1c10114be557b6563d.cab
    c/kb3012997-x64-en-gb-client_4e73cb1a127bfaf20a27c09c58456f5715fd7a39.cab
    c/kb3012997-x64-fr-fr-client_134770b2c1e1abaab223d584d0de5f3b4d683697.cab
    c/kb3012997-x64-he-il-client_7964df925ac57882b016f4dfbb17f748c38dabd6.cab
    c/kb3012997-x64-hu-hu-client_63ddae5a417f51cea18c2a82138eba84428e7428.cab
    c/kb3012997-x64-it-it-client_2aada2ee902555c73e3c80f06d8f688ff3f427bc.cab
    c/kb3012997-x64-ja-jp-client_015f05b5222e363add36e0588fc491d99b047b01.cab
    c/kb3012997-x64-ko-kr-client_b3762fb18545927d20f34c0751c01ba2b786ca0f.cab
    c/kb3012997-x64-lv-lv-client_92d44fc2a8c54e44c9265a4f7c3d4d486ec8b4cc.cab
    c/kb3012997-x64-nb-no-client_93f76ff4cdc22f4fa4e25f374ee37d0200076089.cab
    c/kb3012997-x64-pl-pl-client_4824af56e24fbae186a278014549c85fb93b7218.cab
    c/kb3012997-x64-pt-br-client_01cb1a515d99cad911ba81fead439a5a64514a5d.cab
    c/kb3012997-x64-ro-ro-client_aedbdf1a526c891683fa18be32fa407ebdb52305.cab
    c/kb3012997-x64-sl-si-client_e695453b23b97827414b8ce769a373aca885a4fe.cab
    c/kb3012997-x64-sr-latn-rs-client_a9665eb291007f5031e97e7c86c5017402b916f4.cab
    c/kb3012997-x64-th-th-client_679d20e231a08eade0864c72d39234c3253ed1c7.cab
    c/kb3012997-x64-tr-tr-client_29a7f18bd7bfa610cf92a887e0bb60a0952d0341.cab
    c/kb3012997-x64-zh-tw-client_2af02ae47bb6bc84c169dc6fc7045b41fe6834b1.cab
    c/kb3012997-x86-cs-cz-client_2d5d4c8ce13ed4c88d5429a5c155d109da7d7d93.cab
    c/kb3012997-x86-da-dk-client_3888bd782e1a32e3c8e8ed3edf1a49a7bddfd865.cab
    c/kb3012997-x86-fr-fr-client_fe7e43eeef4e946ee4adffb8491463eeb1f3c8cf.cab
    c/kb3012997-x86-he-il-client_b5c8237e516afd4ebc3fc9c462fa01a3522d9603.cab
    c/kb3012997-x86-it-it-client_0876c2cdb7339cdb1cf5fbefc65f18d6f4ed9d1a.cab
    c/kb3012997-x86-lt-lt-client_4f2e2b5f3798aa927fe9225a5acdb4a31c960e05.cab
    c/kb3012997-x86-lv-lv-client_9c53e75020ed1b8ec437a5466d96f21aec508608.cab
    c/kb3012997-x86-pl-pl-client_dec425abccfe8cd7b98243c16b90fe0fd9214ebc.cab
    c/kb3012997-x86-ro-ro-client_7dc1e96b9a5060b3f4696b41c8c0e3b131c9d03a.cab
    c/kb3012997-x86-sk-sk-client_39b8e9f56b0a974649324b225bde85cfcb61a776.cab
    c/kb3012997-x86-sr-latn-rs-client_183286f7d80ef48e45df256baf714ab040e24418.cab
    c/kb3012997-x86-sv-se-client_8e2bf7db607ba24c23068cfa08b718c949b5ffcf.cab
    c/kb3012997-x86-uk-ua-client_633c476dfaaece86127d262f913d9591f02f9c22.cab
    d/kb3012997-x64-ar-sa-client_3e7da70d500a9511257a009a6b65ebe2b76af385.cab
    d/kb3012997-x64-bg-bg-client_ae74a5addf8d3c8b1b1df06c5cfbb487fb7ef23a.cab
    d/kb3012997-x64-da-dk-client_101bc1172a0d3d0678b4840bb03426d64fd63ca4.cab
    d/kb3012997-x64-en-us-client_a7c55879fa34baad8fef641f316488e3b45de9f6.cab
    d/kb3012997-x64-es-es-client_f6f2d368b8cef9161a1fedc6bde1ed32bb4a353f.cab
    d/kb3012997-x64-et-ee-client_337a5c1f9060fc2333c3d95085b7be793bbecbbe.cab
    d/kb3012997-x64-fi-fi-client_432c662f138346d072772f88e51db29bce2c4462.cab
    d/kb3012997-x64-hr-hr-client_4866f636367d09dc94c1b3ec53bd84f5b5c8e93c.cab
    d/kb3012997-x64-lt-lt-client_47bab1317a2b345b2e7ef03ced47f02022d55a78.cab
    d/kb3012997-x64-nl-nl-client_601bf2290f1ed205c82fe5537651bcb151a067a5.cab
    d/kb3012997-x64-pt-pt-client_e8085482f6aa0d13c4f972035aa7cb6e4812ed04.cab
    d/kb3012997-x64-ru-ru-client_402e43ccf0bedaf01783a6ab43bf9d195dfc94c1.cab
    d/kb3012997-x64-sk-sk-client_de7ae38a3729faae85d9cdb1484c67a2adcd6032.cab
    d/kb3012997-x64-sv-se-client_7dab22f002d69d88c36ba9398461105d2d1d5dca.cab
    d/kb3012997-x64-uk-ua-client_49dd7a8816a55f6c63a89007d3362360ca0577e6.cab
    d/kb3012997-x64-zh-cn-client_e90502ffad2cd573686a92d9e0fa2c2414633fb4.cab
    d/kb3012997-x64-zh-hk-client_69b538d71a82b42131a3d750f98eb2b5a13a1ec7.cab
    d/kb3012997-x86-ar-sa-client_8d67e84dd9afd47df5752f313cbfc9c3584ac3f4.cab
    d/kb3012997-x86-bg-bg-client_c70720347962c06a2e28ed5a97d5614c7d3d9d52.cab
    d/kb3012997-x86-de-de-client_561247380f029040c1574a5ec976e34452060b76.cab
    d/kb3012997-x86-el-gr-client_dd7addb825f3785acdb625996d9ee369eb8730b1.cab
    d/kb3012997-x86-en-gb-client_1e236f8f2b8e24cb5aa4a1f9202ca2fd6225fac5.cab
    d/kb3012997-x86-en-us-client_d4c1f3ac02803ae50ef89988b685a05f2d0f2479.cab
    d/kb3012997-x86-es-es-client_f80d44c869cec373f5022afc312a07f6d2db7521.cab
    d/kb3012997-x86-et-ee-client_dff80b8516877a4c5419ae167972ccdcd1d25bae.cab
    d/kb3012997-x86-fi-fi-client_35e41ff0fa5b3dd81257ef5e0994fecd4d06e7b3.cab
    d/kb3012997-x86-hr-hr-client_fa7999b04ea16c159cce5026c839bd457e4ec777.cab
    d/kb3012997-x86-hu-hu-client_2f67f71791980dc06bdcf769c90e27dd0e43601d.cab
    d/kb3012997-x86-ja-jp-client_bd942470cf4c87e98770e80ae671ae1e9e44d1c2.cab
    d/kb3012997-x86-ko-kr-client_cedd687f6cfd6a7244a8a646f5b3a871198c9305.cab
    d/kb3012997-x86-nb-no-client_d2cb2cbaa11de0d7a4f67a6caf90bfab602b8645.cab
    d/kb3012997-x86-nl-nl-client_43efa0695a6bc0952ce5022869dc222864214806.cab
    d/kb3012997-x86-pt-br-client_9aa0b02d4af44e95cf7295c4b8785f6e84354320.cab
    d/kb3012997-x86-pt-pt-client_d12b518f0cf4226f03b80e93512fbefb54029d3b.cab
    d/kb3012997-x86-ru-ru-client_272ee7c6055fcd61f0ee6d27ade05e9540dc3982.cab
    d/kb3012997-x86-sl-si-client_3fc0f04db15bc58b56a08d4dac64497ee9b3828d.cab
    d/kb3012997-x86-th-th-client_5f13359f05cbdf92b11d4566917008fd8fdd5596.cab
    d/kb3012997-x86-tr-tr-client_d68e0513e789377a09969f5764fa96bed2c27e7a.cab
    d/kb3012997-x86-zh-cn-client_2cc63aa264e6d69c72e94d5881e8454dd8743e83.cab
    d/kb3012997-x86-zh-hk-client_5182fc68e7bec7f9741cf7d57a5d42a03e34d67f.cab
    d/kb3012997-x86-zh-tw-client_0dee0342fad0e3e1ee00fc6802157b0c69c22b39.cab
    kb2483139-x64-ar-sa_f07f2cc7b55b17076eebceea2c2c2826b08b8f63.exe
    kb2483139-x64-bg-bg_e4c9392592ed2d4a8c7ec68270b5140430df197a.exe
    kb2483139-x64-cs-cz_1ea5b71d701e2480017b464b6560a2987e0d8971.exe
    kb2483139-x64-da-dk_d753d19cc1a0fe95aef21548193393c04a6a8024.exe
    kb2483139-x64-de-de_4f4ce6bd38530b4a02199172863b21a0cba13773.exe
    kb2483139-x64-el-gr_583791fea2fea71725388a746844d5be6488ca45.exe
    kb2483139-x64-en-us_9b9c8a867baff2920507fbf1e1b4a158572b9b87.exe
    kb2483139-x64-es-es_fdbdf4061b960324efb9eedf7106df543ed8ce33.exe
    kb2483139-x64-et-ee_b4fd94f6e461e21b7eec54d1e379e2807861aea2.exe
    kb2483139-x64-fi-fi_223465e1b382484d1d82f8f2ccfcd9ed2f902c76.exe
    kb2483139-x64-fr-fr_0f18e2a244dd9ff04664112a82776d2bd2177798.exe
    kb2483139-x64-he-il_617029400059f0847d7d90d4da673ae4ed43ebd9.exe
    kb2483139-x64-hr-hr_e7c6d648436d81466af331ab1ece07dd22be5fda.exe
    kb2483139-x64-hu-hu_1c298d99baf7af3d830dcd1e2632eeb65d7ee395.exe
    kb2483139-x64-it-it_6d8223c065d6974d833d0eaa162f3ceb7680850f.exe
    kb2483139-x64-ja-jp_aeaf7e9b0b6c2173bf757330017a7f655f1f8715.exe
    kb2483139-x64-ko-kr_0ea76f748e3d5309d568147ad1337b2664090944.exe
    kb2483139-x64-lt-lt_c894f0a591735553ba68f9fb94b1b85133ca922c.exe
    kb2483139-x64-lv-lv_3919fb044a307144f1fc55cf4313aff45cde9a46.exe
    kb2483139-x64-nb-no_78df68604970041a6337b4058a3e5339f79e50b4.exe
    kb2483139-x64-nl-nl_12c90c70d408b08f51f500d6e974878a5d662398.exe
    kb2483139-x64-pl-pl_24d00a966a7a75132c3af5627634483d3e2d01e7.exe
    kb2483139-x64-pt-br_f8035731c55d774c95c7c673aedfd42d52479294.exe
    kb2483139-x64-pt-pt_78485491088298110a3e78b7a5f95e55ff7808df.exe
    kb2483139-x64-ro-ro_6e7a63541f2cb534dab3db719330fee5cfbb4e0f.exe
    kb2483139-x64-ru-ru_0587eb296a2f04e0d3699650d39b53ee18b97a79.exe
    kb2483139-x64-sk-sk_f1fb8a395d7d656649830f4f06496a5311ad572a.exe
    kb2483139-x64-sl-si_84606ed6bc061c72f756bbc061621b490fb761f7.exe
    kb2483139-x64-sr-latn-cs_5f487007933585def54c67087895e74e25e699a9.exe
    kb2483139-x64-sv-se_81051fe3083afdb4f2d1d23752c587de9bb35025.exe
    kb2483139-x64-th-th_dc9c0cc12ae488ed3e8dcaecb4392eef91ec213b.exe
    kb2483139-x64-tr-tr_07e7e3b34426fe68be813e911d3843b941a268b7.exe
    kb2483139-x64-uk-ua_1ca449545a2bcfdeeed6080768186fc29f163504.exe
    kb2483139-x64-zh-cn_2c1884b4fdf6c8e91986369d88bbcaae01c6f187.exe
    kb2483139-x64-zh-hk_285282b1e2f750eeed91466918443b657968d977.exe
    kb2483139-x86-ar-sa_5add6e4a36127029d431ba98d99708c44ef9b53f.exe
    kb2483139-x86-bg-bg_a8a5013e477366119cfdc5fbda43b904755db450.exe
    kb2483139-x86-cs-cz_bb5061f4bd24437dd31a3714e1b54318ced7e63a.exe
    kb2483139-x86-da-dk_67fecaab0a940e2e537bc8dcd8a9ebb8ab4ed102.exe
    kb2483139-x86-de-de_acb9b88b96d432749ab63bd93423af054d23bf81.exe
    kb2483139-x86-el-gr_5aeecda7e1d689a083975128901da8156751dfc5.exe
    kb2483139-x86-en-us_783d6dd59e2ec8fb0995a059c9c121795bde46c8.exe
    kb2483139-x86-es-es_6aef75f7d83edaabc2a921a6b157cc7005628286.exe
    kb2483139-x86-et-ee_d0f798de315b696bf560b559f6f90064687c0b7b.exe
    kb2483139-x86-fi-fi_5259ca6a22a981dbdee352dde5b8e65c2fddd407.exe
    kb2483139-x86-fr-fr_f57427487dfc2f49da67cac22480ab1f48983d22.exe
    kb2483139-x86-he-il_1849d14777a76c7c5b4ef766490dccc8aed5c56b.exe
    kb2483139-x86-hr-hr_685e217ce007af8005db4726087893d04e19dade.exe
    kb2483139-x86-hu-hu_a7a5af62c59ab7a4e8cb0f21242b42606b95195b.exe
    kb2483139-x86-it-it_1d54a8d0047674fc1b5b6f41292a0074d9fe3cc5.exe
    kb2483139-x86-ja-jp_bc46078938ae9129c7ce86a9c176fa517e4c0a3d.exe
    kb2483139-x86-ko-kr_18f213428cc6fde96d8c76c6dd91446348e86ce6.exe
    kb2483139-x86-lt-lt_297c5ee6e98ab646b14f1492716b67cc0970fcd8.exe
    kb2483139-x86-lv-lv_97b58149699a2e8b02bd7cac720ac0795b51c98b.exe
    kb2483139-x86-nb-no_5bd6fc76ad54b7a232d4ceb4a5f5c7c366bf90b6.exe
    kb2483139-x86-nl-nl_b7e1c3046b218fb45a665ab5f5ed8a5ea8125760.exe
    kb2483139-x86-pl-pl_c460a8c1392d7f3d35d1c0b37e56017d3552d245.exe
    kb2483139-x86-pt-br_6e1d337b2fd56669d461e82601aa51004fecbd24.exe
    kb2483139-x86-pt-pt_5cc92ef98ed177b2f6bbae3a0420ee2f12764fab.exe
    kb2483139-x86-ro-ro_d8d9b2b4c5c457fe6a7dcb09a5f645cfe77cc30c.exe
    kb2483139-x86-ru-ru_6532a8f36ad7d15277d5d60da92555f0fbee4daa.exe
    kb2483139-x86-sk-sk_4c7b17a6cb292b09bede4c8731ad4f24cd09ab2a.exe
    kb2483139-x86-sl-si_de7f366819e1c12954557e3e65b7c0f059f49b67.exe
    kb2483139-x86-sr-latn-cs_e3d9acfcc9f608cf7687bd3b5ee7f0d9658b7bc9.exe
    kb2483139-x86-sv-se_bd65af75e8995bd865d93c8d8c8a35091499083f.exe
    kb2483139-x86-th-th_8248f2b209d65a39ddaeb36e1782fcc0f6664f73.exe
    kb2483139-x86-tr-tr_228dfa5fbaa4606b17f93d6fcd51c8c85c0f1fd3.exe
    kb2483139-x86-uk-ua_7f01db99ad2b2d41598bfc71aaa9bd4be04b6369.exe
    kb2483139-x86-zh-cn_ae61ea226215f96fc95be33201ffc96755ac7eb5.exe
    kb2483139-x86-zh-hk_411a6bb68728f12f5ced712d9a33fee9ebe0b0b3.exe
'@

$RegionTable = ConvertFrom-Csv @'
    Region,     Language
    ar-sa,      ar-SA Arabic
    bg-bg,      bg-BG Bulgarian
    cs-cz,      cs-CZ Czech
    da-dk,      da-DK Danish
    de-de,      de-DE German
    el-gr,      el-GR Greek
    en-gb,      en-GB English (United Kingdom)
    en-us,      en-US English (United States)
    es-es,      es-ES Spanish
    et-ee,      et-EE Estonian
    fi-fi,      fi-FI Finnish
    fr-fr,      fr-FR French
    he-il,      he-IL Hebrew
    hr-hr,      hr-HR Croatian
    hu-hu,      hu-HU Hungarian
    it-it,      it-IT Italian
    ja-jp,      ja-JP Japanese
    ko-kr,      ko-KR Korean
    lt-lt,      lt-LT Lithuanian
    lv-lv,      lv-LV Latvian
    nb-no,      nb-NO Norwegian
    nl-nl,      nl-NL Dutch
    pl-pl,      pl-PL Polish
    pt-br,      pt-BR Portuguese (Brazil)
    pt-pt,      pt-PT Portuguese
    ro-ro,      ro-RO Romanian
    ru-ru,      ru-RU Russian
    sk-sk,      sk-SK Slovak
    sl-si,      sl-SI Slovenian
    sr-latn-rs, sr-latn-rs Serbian (Latin)
    sv-se,      sv-SE Swedish
    th-th,      th-TH Thai
    tr-tr,      tr-TR Turkish
    uk-ua,      uk-UA Ukrainian
    zh-cn,      zh-CN Chinese Simplified
    zh-hk,      zh-HK Chinese Traditional (HK)
    zh-tw,      zh-TW Chinese Traditional (Taiwan)
'@

$ListBoxCheck = {
    if ($Version_ListBox.SelectedIndex -gt -1 -and $Arch_ListBox.SelectedIndex -gt -1 -and $Language_ListBox.SelectedIndex -gt -1) {
        $OKButton.Enabled = $true
    }
}

[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

[System.Windows.Forms.Application]::EnableVisualStyles()

$objForm = New-Object System.Windows.Forms.Form
$objForm.Size = New-Object System.Drawing.Size(610,340)
$objForm.StartPosition = 'CenterScreen'
$objForm.MaximizeBox = $false
$objForm.Text = 'W7/W8.1 Language Packs v1.4'

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
$Version_Label.Size = New-Object System.Drawing.Size(130,20)
$Version_Label.Font = [System.Drawing.Font]::new($Version_Label.Font.Name, $FontSize, [System.Drawing.FontStyle]::Bold)
$Version_Label.Text = 'Version'

$objForm.Controls.Add($Version_Label)

$Version_ListBox = New-Object System.Windows.Forms.ListBox
$Version_ListBox.Location = New-Object System.Drawing.Point(25,40)
$Version_ListBox.Size = New-Object System.Drawing.Size(130,20)
$Version_ListBox.Height = 55
$Version_ListBox.Font = [System.Drawing.Font]::new($Version_ListBox.Font.Name, $FontSize)
$Version_ListBox.add_SelectedIndexChanged($ListBoxCheck)

[void] $Version_ListBox.Items.AddRange(@('Windows 8.1','Windows 7 SP1'))
$objForm.Controls.Add($Version_ListBox)

$Arch_Label = New-Object System.Windows.Forms.Label
$Arch_Label.Location = New-Object System.Drawing.Point(175,15)
$Arch_Label.Size = New-Object System.Drawing.Size(65,20)
$Arch_Label.Font = [System.Drawing.Font]::new($Arch_Label.Font.Name, $FontSize, [System.Drawing.FontStyle]::Bold)
$Arch_Label.Text = 'Arch'

$objForm.Controls.Add($Arch_Label)

$Arch_ListBox = New-Object System.Windows.Forms.ListBox
$Arch_ListBox.Location = New-Object System.Drawing.Point(175,40)
$Arch_ListBox.Size = New-Object System.Drawing.Size(65,20)
$Arch_ListBox.Height = 55
$Arch_ListBox.Font = [System.Drawing.Font]::new($Arch_ListBox.Font.Name, $FontSize)
$Arch_ListBox.add_SelectedIndexChanged($ListBoxCheck)

[void] $Arch_ListBox.Items.AddRange(@('x64','x86'))
$objForm.Controls.Add($Arch_ListBox)

$Language_Label = New-Object System.Windows.Forms.Label
$Language_Label.Location = New-Object System.Drawing.Point(270,15)
$Language_Label.Size = New-Object System.Drawing.Size(305,20)
$Language_Label.Font = [System.Drawing.Font]::new($Language_Label.Font.Name, $FontSize, [System.Drawing.FontStyle]::Bold)
$Language_Label.Text = 'Language'

$objForm.Controls.Add($Language_Label)

$Language_ListBox = New-Object System.Windows.Forms.ListBox
$Language_ListBox.Location = New-Object System.Drawing.Point(270,40)
$Language_ListBox.Size = New-Object System.Drawing.Size(305,20)
$Language_ListBox.Height = 185
$Language_ListBox.Font = [System.Drawing.Font]::new($Language_ListBox.Font.Name, $FontSize)
$Language_ListBox.add_SelectedIndexChanged($ListBoxCheck)

$Language_ListBox.UseTabStops = $true
$Language_ListBox.UseCustomTabOffsets = $true

$pattern = [regex]' '

foreach ($item in $RegionTable.Language) {
    [void] $Language_ListBox.Items.Add($pattern.Replace($item,"`t",1))
}
$objForm.Controls.Add($Language_ListBox)

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

$Version = $Version_ListBox.SelectedItem
$Arch = $Arch_ListBox.SelectedItem
$Language = $Language_ListBox.SelectedItem -replace "`t"," "

$Region = ($RegionTable | Where { $_.Language -eq $Language }).Region

if ($Version -match '8.1') {
    $KB = ($KB_List | Where { $_ -like "*kb3012997-$($Arch)-$($Region)*" }).Filename
    $URL = 'http://download.windowsupdate.com/{0}/msdownload/update/software/updt/2014/11/windows8.1-{1}' -f ($KB -split '/')[0], ($KB -split '/',2)[1]
}
else {
    $KB = ($KB_List | Where { $_ -like "*kb2483139-$($Arch)-$($Region)*" }).Filename
    $URL = 'http://download.windowsupdate.com/msdownload/update/software/updt/2011/02/windows6.1-{0}' -f $KB
}
$Filename = ($URL -split '/')[-1]

[System.Net.WebRequest]::DefaultWebProxy = [System.Net.WebRequest]::GetSystemWebProxy()
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if (-not (Test-Path -Path $Filename -PathType Leaf)) {
    try {
        'Downloading "{0}"' -f $Filename
        $LastModified = (Invoke-WebRequest -UseBasicParsing -Uri $URL -Method HEAD).Headers.'Last-Modified'
        $Response = Invoke-WebRequest -UseBasicParsing -Uri $URL -OutFile $Filename

        $File = Get-Item -Path $Filename
        $File.CreationTime = $File.LastWriteTime = $LastModified
    }
    catch {
        $_.Exception.Message
    }
}
else {
    'Duplicate file "{0}"' -f $Filename
}
