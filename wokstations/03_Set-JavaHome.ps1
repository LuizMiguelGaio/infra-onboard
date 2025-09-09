# Caminho base onde o JDK está instalado
$javaBase = "C:\Program Files\Java"

# Tenta encontrar o JDK mais recente instalado
$jdkPath = Get-ChildItem -Path $javaBase -Directory |
    Where-Object { $_.Name -like "jdk1.8.0*" -or $_.Name -like "jdk-1.8.0*" } |
    Sort-Object Name -Descending |
    Select-Object -First 1

if (-not $jdkPath) {
    Write-Error "Nenhuma instalação do JDK 8 foi encontrada em $javaBase."
    exit 1
}

$fullPath = $jdkPath.FullName
$javaBin = Join-Path $fullPath "bin"

# Configura JAVA_HOME
[Environment]::SetEnvironmentVariable("JAVA_HOME", $fullPath, "Machine")
Write-Output "JAVA_HOME definido como: $fullPath"

# Adiciona ao PATH, se ainda não estiver
$currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")

if ($currentPath -notlike "*$javaBin*") {
    $newPath = "$currentPath;$javaBin"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
    Write-Output "Caminho $javaBin adicionado ao PATH do sistema."
} else {
    Write-Output "$javaBin já está no PATH."
}
