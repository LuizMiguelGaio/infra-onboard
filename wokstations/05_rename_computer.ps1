# DESCRICAO: Renomeia o computador.
# REQUISITOS: Executar como administrador.
# USO: ./05_rename_computer.ps1

# Definindo onde o log sera salvo
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$logPath = Join-Path $scriptDir "log_setup.txt"

Function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logPath -Value "$timestamp :: [RENAME_COMPUTER] $msg"
    Write-Host $msg
}

# Solicita o novo nome do computador
$nome = Read-Host "Digite o novo nome do computador"

# Exibe confirmacao para o usuario

Write-Host " - Novo nome: $nome"

$confirmacao = Read-Host "Deseja continuar? (S/N)"

if ($confirmacao -match '^[Ss]$') {
    try {
        Rename-Computer -NewName $nome -Force -Restart
        
    }
    catch {
        Write-Error "Erro ao renomear: $_"
    }
} else {
    Write-Host "Operacao cancelada pelo usuario."
}