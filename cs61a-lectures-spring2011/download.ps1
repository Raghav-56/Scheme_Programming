# Using aria2c for faster, more reliable downloads
$baseUrl = "https://people.eecs.berkeley.edu/~bh/61a-pages/Lectures/"
$localPath = "./"

# Create directories and file list based on known structure
$directories = @("1.1", "1.2", "1.3", "2.1", "2.2", "2.4", "3.0", "3.1", "3.2", "3.3", "3.4", "3.5", "4.1", "4.2", "4.4", "Net", "unix")
$rootFiles = @("errors", "groupreduce.scm", "mapreduce-demo.scm", "summary")

New-Item -ItemType Directory -Path $localPath -Force | Out-Null

# Download root files first
Write-Host "Downloading root files..." -ForegroundColor Yellow
foreach ($file in $rootFiles) {
    $url = "$baseUrl$file"
    $output = "$localPath/$file"
    Write-Host "  → $file" -ForegroundColor Cyan
    aria2c --dir="$localPath" --out="$file" --max-connection-per-server=2 --retry-wait=1 "$url"
}

# Download directories
foreach ($dir in $directories) {
    Write-Host "Processing directory: $dir" -ForegroundColor Green
    $dirUrl = "$baseUrl$dir/"
    $dirPath = "$localPath/$dir"
    New-Item -ItemType Directory -Path $dirPath -Force | Out-Null
    
    try {
        # Get directory listing
        $response = Invoke-WebRequest -Uri $dirUrl -UseBasicParsing
        $files = $response.Content | Select-String -Pattern 'href="([^"]*\.(scm|txt|pdf|html?))"' -AllMatches | 
        ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value }
        
        if ($files.Count -gt 0) {
            # Create download list file for aria2c
            $downloadList = "$env:TEMP/aria2c-$dir.txt"
            foreach ($file in $files) {
                "$dirUrl$file`n  out=$dir/$file" | Out-File -FilePath $downloadList -Append -Encoding UTF8
            }
            
            # Download all files in directory at once
            Write-Host "  Downloading $($files.Count) files..." -ForegroundColor Cyan
            aria2c --input-file="$downloadList" --dir="$localPath" --max-concurrent-downloads=3 --max-connection-per-server=2
            Remove-Item $downloadList -ErrorAction SilentlyContinue
        }
    }
    catch {
        Write-Host "  Error processing $dir : $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "Download complete with aria2c!" -ForegroundColor Green
