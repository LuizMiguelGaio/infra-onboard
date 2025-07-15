# DESCRICAO: Instala apps atraves do chocolatey usando um arquivo de configuracao
# REQUISITOS: Executar como administrador
# USO: ./04_install_apps_chocolatey.ps1 -ConfigFile .\04_programs.txt

param(
    [string]$ConfigFile = ".\04_programs.txt"  # Caminho padrao para o arquivo de programas
)


# Verifica se o arquivo de configuracao existe
if (-not (Test-Path $ConfigFile)) {
    Write-Error "Arquivo de configuracao nao encontrado: $ConfigFile"
    exit 1
}

# Carrega a lista de programas (ignorando linhas vazias e comentários)
try {
    $programas = Get-Content $ConfigFile | Where-Object { 
        $_ -notmatch '^\s*#' -and $_ -notmatch '^\s*$' 
    }
    
    if (-not $programas) {
        Write-Error "Nenhum programa valido encontrado no arquivo de configuracao"
        exit 1
    }
    
    Write-Host "Programas a serem instalados:`n$($programas -join "`n")"
}
catch {
    Write-Error "Falha ao ler arquivo de configuracao: $_"
    exit 1
}

# Verifica/Instala Chocolatey
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "`nInstalando Chocolatey..." -ForegroundColor Yellow
    
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
            throw "Instalacao do Chocolatey falhou"
        }
        
        Write-Host "Chocolatey instalado com sucesso!" -ForegroundColor Green
    }
    catch {
        Write-Error "ERRO: Falha na instalacao do Chocolatey`n$_"
        exit 1
    }
}
else {
    Write-Host "`nChocolatey ja esta instalado" -ForegroundColor Cyan
}

# Instalação dos programas
Write-Host "`nIniciando instalacao dos programas..." -ForegroundColor Yellow
$erros = 0

foreach ($programa in $programas) {
    Write-Host "`nInstalando $programa..." -ForegroundColor Magenta
    
    try {
        choco install $programa -y --no-progress --force
        if ($LASTEXITCODE -ne 0) { throw "Codigo de saida $LASTEXITCODE" }
        
        Write-Host "$programa instalado com sucesso!" -ForegroundColor Green
    }
    catch {
        $erros++
        Write-Host "ERRO: Falha ao instalar $programa" -ForegroundColor Red
        Write-Host "Detalhes: $_" -ForegroundColor DarkYellow
    }
}

# Resumo final
Write-Host "`nResumo da instalacao:" -ForegroundColor Cyan
Write-Host "Programas instalados: $($programas.Count - $erros)"
Write-Host "Falhas: $erros"

if ($erros -gt 0) {
    Write-Host "`nAlguns programas podem nao ter sido instalados corretamente." -ForegroundColor Red
    exit 1
}

Write-Host "`nTodos os programas foram instalados com sucesso!" -ForegroundColor Green