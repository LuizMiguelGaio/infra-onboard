# DESCRIÇÃO: Renomeia o computador e reinicia.  
# REQUISITOS: Executar como administrador.  
# USO: ./05_rename_computer.ps1  

# Definindo onde o log será salvo no final
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$logPath = Join-Path $scriptDir "log_setup.txt"

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
    Write-Host "Operacao cancelada pelo usuÃ¡rio."
}

# Gerando Log
Add-Content -Path $logPath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') :: [RENAME-COMPUTER] concluído com sucesso"

