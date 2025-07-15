# DESCRICAO: Cria um ponto de restauracao do sistama limpo.  
# REQUISITOS: Executar como administrador.  
# USO: ./02_create_restore_point.ps1

# Habilitar execucao temporaria (so altera para a sessao atual sem impacto permanente)
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force  

# Definindo onde o log sera salvo
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$logPath = Join-Path $scriptDir "log_setup.txt"

Function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logPath -Value "$timestamp :: [CREATE_RESTORE_POINT] $msg"
    Write-Host $msg
}

# Verifica e ativa protecao do sistema na unidade C
Enable-ComputerRestore -Drive "C:\" 2>$null

# Cria ponto de restauracao
try {
    Checkpoint-Computer -Description "Ponto inicial - Pos setup" -RestorePointType MODIFY_SETTINGS
    Write-Host "`nPonto de restauracao criado com sucesso." -ForegroundColor Cyan
}
catch {
    Write-Warning "Nao foi possivel criar o ponto de restauracao. Verifique se a protecao do sistema estao ativa." 
}