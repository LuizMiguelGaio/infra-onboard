# DESCRICAO: Instala apps através do winget usando um arquivo de configuração
# REQUISITOS: Executar como administrador, Windows com acesso à internet e permissões para instalar pacotes da Microsoft Store
# USO: ./04_install_apps_winget.ps1 -ConfigFile .\04_programs.txt

param(
    [string]$ConfigFile = ".\03_programs.txt"
)

# Verifica se o arquivo existe
if (-not (Test-Path $ConfigFile)) {
    Write-Error "Arquivo de configuração não encontrado: $ConfigFile"
    exit 1
}

# Carrega a lista de programas ignorando linhas vazias e comentários
try {
    $programas = Get-Content $ConfigFile | Where-Object {
        $_ -notmatch '^\s*#' -and $_ -notmatch '^\s*$'
    }

    if (-not $programas) {
        Write-Error "Nenhum programa válido encontrado no arquivo de configuração"
        exit 1
    }

    Write-Host "Programas a serem instalados:`n$($programas -join "`n")"
}
catch {
    Write-Error "Falha ao ler arquivo de configuração: $_"
    exit 1
}

# Verifica se winget está disponível, senão tenta instalar
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget não encontrado. Tentando instalar o App Installer..." -ForegroundColor Yellow

    try {
        $installerPath = "$env:TEMP\AppInstaller.appxbundle"

        # Baixa o App Installer oficial
        Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile $installerPath -UseBasicParsing

        # Instala o pacote
        Add-AppxPackage -Path $installerPath

        # Aguarda a instalação
        Start-Sleep -Seconds 10

        # Verifica novamente
        if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
            throw "Winget ainda não está disponível após a tentativa de instalação."
        }

        Write-Host "Winget instalado com sucesso!" -ForegroundColor Green
    }
    catch {
        Write-Error "Falha ao instalar o Winget automaticamente: $_"
        Write-Host "Tente instalar manualmente via Microsoft Store: https://aka.ms/getwinget" -ForegroundColor DarkYellow
        exit 1
    }
}

# Início da instalação
Write-Host "`nIniciando instalação dos programas..." -ForegroundColor Yellow
$erros = 0

foreach ($programa in $programas) {
    Write-Host "`nInstalando $programa..." -ForegroundColor Magenta

    try {
        winget install --id "$programa" --accept-source-agreements --accept-package-agreements -e -h
        if ($LASTEXITCODE -ne 0) { throw "Código de saída $LASTEXITCODE" }

        Write-Host "$programa instalado com sucesso!" -ForegroundColor Green
    }
    catch {
        $erros++
        Write-Host "ERRO: Falha ao instalar $programa" -ForegroundColor Red
        Write-Host "Detalhes: $_" -ForegroundColor DarkYellow
    }
}

# Resumo
Write-Host "`nResumo da instalação:" -ForegroundColor Cyan
Write-Host "Programas instalados: $($programas.Count - $erros)"
Write-Host "Falhas: $erros"

if ($erros -gt 0) {
    Write-Host "`nAlguns programas podem não ter sido instalados corretamente." -ForegroundColor Red
    exit 1
}

Write-Host "`nTodos os programas foram instalados com sucesso!" -ForegroundColor Green
