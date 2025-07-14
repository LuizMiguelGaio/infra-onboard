#Habilitar execu��o tempor�ria (s� altera para a sess�o atual sem impacto permanente)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force

# Lista de programas para instalar via Chocolatey
$programas = @(
    "Winrar",
    "googlechrome",
    "notepadplusplus",
    "adobereader"
)

# Verifica se o choco está instalado
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey não encontrado. Instalando Chocolatey..."

    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Error "Falha na instalação do Chocolatey. Abortando."
        exit 1
    }
} else {
    Write-Host "Chocolatey já instalado."
}

# Instala cada programa da lista
foreach ($programa in $programas) {
    Write-Host "Instalando $programa..."
    choco install $programa -y --no-progress
}
