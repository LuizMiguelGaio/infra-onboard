# DESCRICAO: Puxa e instala as atualizacoes mais recentes do Windows.
# REQUISITOS: Executar como administrador.
# USO: ./03_install_windows_updates.ps1

# Habilitar execucao temporaria (so altera para a sessao atual sem impacto permanente)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force

# Definindo onde o log sera salvo
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$logPath = Join-Path $scriptDir "log_setup.txt"

Function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logPath -Value "$timestamp :: [INSTALL_WINDOWS_UPDATE] $msg"
}

# Verificar se modulo PSWindowsUpdate já está instalado
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    try {
        Log "PSWindowsUpdate não encontrado. Instalando módulo..."
        Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser -ErrorAction Stop
        Log "Módulo PSWindowsUpdate instalado com sucesso."
    } catch {
        Log "Erro ao instalar PSWindowsUpdate: $_"
        Write-Error "Falha crítica ao instalar módulo. Abortando."
        exit 1
    }
} else {
    Log "Módulo PSWindowsUpdate já instalado."
}

# Importar módulo
Import-Module PSWindowsUpdate -Force

# Avisar sobre reinicialização automática
Write-Warning "Este script pode reiniciar automaticamente o sistema após aplicar as atualizações."
$response = Read-Host "Deseja continuar? (S/N)"
if ($response -ne 'S' -and $response -ne 's') {
    Log "Execução cancelada pelo usuário."
    Write-Host "Execução cancelada." -ForegroundColor Red
    exit
}

# Verificar atualizações
try {
    Write-Host "Buscando atualizações..." -ForegroundColor Yellow
    Log "Iniciando verificação de atualizações..."
    
    $updates = Get-WindowsUpdate -AcceptAll
    if ($updates) {
        Log "$($updates.Count) atualizações encontradas. Iniciando instalação..."
        Get-WindowsUpdate -AcceptAll -Install -AutoReboot
        Log "Atualizações instaladas com sucesso."
    } else {
        Log "Nenhuma atualização necessária."
        Write-Host "Sistema já está atualizado." -ForegroundColor Green
    }
} catch {
    Log "Erro ao buscar ou instalar atualizações: $_"
    Write-Error "Falha ao aplicar atualizações."
    exit 1
}
