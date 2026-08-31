# Setzt die Umgebungsvariablen aus der .env-Datei
# und konfiguriert den Pfad zur profiles.yml

$envFile = Join-Path $PSScriptRoot ".env"

if (-Not (Test-Path $envFile)) {
    Write-Error "Die Datei .env wurde nicht gefunden. Bitte kopiere .env.example nach .env und passe die Werte an."
    exit 1
}

Get-Content $envFile | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith("#")) {
        $parts = $line.Split('=', 2)
        if ($parts.Length -eq 2) {
            $name = $parts[0].Trim()
            $value = $parts[1].Trim()
            [System.Environment]::SetEnvironmentVariable($name, $value, [System.EnvironmentVariableTarget]::Process)
        }
    }
}

# DBT_PROFILES_DIR aus .env übernehmen, falls gesetzt; sonst aktuellen Ordner verwenden
$profilesDir = [System.Environment]::GetEnvironmentVariable("DBT_PROFILES_DIR", [System.EnvironmentVariableTarget]::Process)
if (-not $profilesDir) {
    $profilesDir = $PSScriptRoot
    [System.Environment]::SetEnvironmentVariable("DBT_PROFILES_DIR", $profilesDir, [System.EnvironmentVariableTarget]::Process)
}

Write-Host "Umgebungsvariablen aus $envFile geladen."
Write-Host "DBT_PROFILES_DIR ist jetzt: $profilesDir"
