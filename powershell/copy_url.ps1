$FolderPath = Read-Host "��Ҫ���Ƶ�url�ļ����ڵ��ļ���·��"

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
