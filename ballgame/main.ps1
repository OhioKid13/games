param (
    [string]$Score,
    [string]$FilePath = "progress.json"
)

$progress = @{
    score = $Score
}

$progress | ConvertTo-Json | Set-Content -Path $FilePath
