$FolderPath = Read-Host "需要复制的url文件所在的文件夹路径"

$urlFiles = Get-ChildItem -Path $FolderPath -Filter *.url -File
$outputPath = Join-Path -Path $FolderPath -ChildPath "output.txt"

$urlResults = foreach ($file in $urlFiles) {
    $foundUrl = $null
    foreach ($line in (Get-Content -Path $file.FullName -Encoding Default)) {
        if ($line -match '^URL=(.*)') {
            $foundUrl = $matches[1]
            break
        }
    }
    if ($foundUrl) { $foundUrl }
}

$urlResults | Set-Content -Path $outputPath -Encoding UTF8
