# Using aria2c for faster, more reliable downloads of CS61A Library files
$baseUrl = "https://people.eecs.berkeley.edu/~bh/61a-pages/Lib/"
$localPath = "./"

# All the library files from the Lib directory (no subdirectories, just files)
$rootFiles = @(
    "adv-world.scm",
    "adv.scm", 
    "ambdiff",
    "ambeval.scm",
    "analyze.scm",
    "animal.scm",
    "apl-meta.scm",
    "apl.scm",
    "berkeley.scmm",
    "bst.scm",
    "calc.scm",
    "chapter1.code",
    "chapter2.code", 
    "chapter3.code",
    "concurrent.scm",
    "constraint.scm",
    "huffman.scm",
    "labyrinth.scm",
    "lazy.scm",
    "logo-meta.scm",
    "logo.scm",
    "maze.scm",
    "mceval.scm",
    "obj.scm",
    "old-obj.scm",
    "picture.scm",
    "pigl.scm",
    "prisoner.scm",
    "pronounce.scm",
    "query.scm",
    "ref-man.txt",
    "resist.scm",
    "review",
    "rps.scm",
    "scheme1.scm",
    "scmset",
    "serial.scm",
    "small-world.scm",
    "tables.scm",
    "test.logo",
    "tri.l",
    "turkey",
    "twenty-one.scm",
    "vambeval.scm"
)

New-Item -ItemType Directory -Path $localPath -Force | Out-Null

# Create download list file for aria2c (batch download)
$downloadList = "$env:TEMP/aria2c-lib.txt"
Remove-Item $downloadList -ErrorAction SilentlyContinue

Write-Host "Preparing download list for $($rootFiles.Count) library files..." -ForegroundColor Yellow

foreach ($file in $rootFiles) {
    $url = "$baseUrl$file"
    "$url`n  out=$file" | Out-File -FilePath $downloadList -Append -Encoding UTF8
}

# Download all files at once with aria2c
Write-Host "Downloading CS61A Library files with aria2c..." -ForegroundColor Green
Write-Host "Files will be saved to: $localPath" -ForegroundColor Cyan

aria2c --input-file="$downloadList" --dir="$localPath" --max-concurrent-downloads=5 --max-connection-per-server=2 --retry-wait=1 --continue=true

# Clean up
Remove-Item $downloadList -ErrorAction SilentlyContinue

# Show download summary
Write-Host "`nDownload Summary:" -ForegroundColor Yellow
$downloadedFiles = Get-ChildItem -Path $localPath -File -ErrorAction SilentlyContinue
if ($downloadedFiles) {
    Write-Host "Successfully downloaded: $($downloadedFiles.Count) files" -ForegroundColor Green
    
    # Group by file extension
    $extensions = $downloadedFiles | Group-Object Extension | Sort-Object Name
    foreach ($ext in $extensions) {
        $extName = if ($ext.Name -eq "") { "(no extension)" } else { $ext.Name }
        Write-Host "  $extName`: $($ext.Count) files" -ForegroundColor Cyan
    }
    
    Write-Host "`nKey files downloaded:" -ForegroundColor Yellow
    $keyFiles = @("berkeley.scmm", "obj.scm", "mceval.scm", "ambeval.scm", "lazy.scm", "scheme1.scm")
    foreach ($keyFile in $keyFiles) {
        if ($downloadedFiles.Name -contains $keyFile) {
            Write-Host "  ✓ $keyFile" -ForegroundColor Green
        } else {
            Write-Host "  ✗ $keyFile (missing)" -ForegroundColor Red
        }
    }
} else {
    Write-Host "No files found in download directory. Check for errors above." -ForegroundColor Red
}

Write-Host "`nDownload complete! Library files saved to: $localPath" -ForegroundColor Green
