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
    Write-Host $msg
}

# Verificar se modulo PSWindowsUpdate ja esta instalado
if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    try {
        Log "PSWindowsUpdate nao encontrado. Instalando modulo..."
        Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser -ErrorAction Stop
        Log "Modulo PSWindowsUpdate instalado com sucesso."
    } catch {
        Log "Erro ao instalar PSWindowsUpdate: $_"
        Write-Error "Falha critica ao instalar modulo. Abortando."
        exit 1
    }
} else {
    Log "Modulo PSWindowsUpdate ja instalado."
}

# Importar modulo
Import-Module PSWindowsUpdate -Force

# Avisar sobre reinicializacao automatica
Write-Warning "Este script pode reiniciar automaticamente o sistema apos aplicar as atualizacoes."
$response = Read-Host "Deseja continuar? (S/N)"
if ($response -ne 'S' -and $response -ne 's') {
    Log "Execucao cancelada pelo usuario."
    Write-Host "Execucao cancelada." -ForegroundColor Red
    exit
}

# Verificar atualizações
try {
    Write-Host "Buscando atualizacoes..." -ForegroundColor Yellow
    Log "Iniciando verificação de atualizacoes..."
    
    $updates = Get-WindowsUpdate -AcceptAll
    if ($updates) {
        Log "$($updates.Count) atualizações encontradas. Iniciando instalacao..."
        Get-WindowsUpdate -AcceptAll -Install -AutoReboot
        Log "Atualizacoes instaladas com sucesso."
    } else {
        Log "Nenhuma atualizacao necessaria."
        Write-Host "Sistema ja está atualizado." -ForegroundColor Cyan
    }
} catch {
    Log "Erro ao buscar ou instalar atualizacoes: $_"
    Write-Error "Falha ao aplicar atualizacoes."
    exit 1
}
