# Lädt die in .env definierten DBT_*-Umgebungsvariablen für lokale dbt Core-Ausführungen.
# Für dbt Projects on Snowflake werden die Werte stattdessen über env.yml aufgelöst.

$envFile = Join-Path $PSScriptRoot ".env"

if (-Not (Test-Path $envFile)) {
    Copy-Item -Path (Join-Path $PSScriptRoot ".env.example") -Destination $envFile
    Write-Error "Die Datei .env wurde nicht gefunden. Eine Kopie aus .env.example wurde angelegt. Bitte passe die Werte an und führe das Skript erneut aus."
    exit 1
}

Get-Content $envFile | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith("#")) {
        $parts = $line.Split('=', 2)
        if ($parts.Length -eq 2) {
            $name = $parts[0].Trim()
            $value = $parts[1].Trim()

            if (-not $name.StartsWith("DBT_")) {
                Write-Warning "Nicht-DBT-Variable '$name' wird ignoriert. Nur Variablen mit DBT_-Prefix werden für dbt unterstützt."
                return
            }

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

Write-Host "DBT_*-Umgebungsvariablen aus $envFile geladen."
Write-Host "DBT_PROFILES_DIR ist jetzt: $profilesDir"
