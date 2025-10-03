# Simple script to download with curl
$baseUrl = "https://people.eecs.berkeley.edu/~bh/61a-pages/Lectures/"

# Get directory listing
$listing = curl -s $baseUrl
$files = $listing | Select-String -Pattern 'href="([^"]*\.(scm|txt|pdf|html?))"' -AllMatches | 
ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value }

# Download each file
New-Item -ItemType Directory -Path "./" -Force
foreach ($file in $files) {
    Write-Host "Downloading: $file"
    curl -o "./$file" "$baseUrl$file"
}
