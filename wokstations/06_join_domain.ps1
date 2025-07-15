# DESCRICAO: Insere o computador atual no dominio desejado.
# REQUISITOS: Executar como administrador.
# USO: ./06_join_domain.ps1

# Definindo onde o log sera salvo
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$logPath = Join-Path $scriptDir "log_setup.txt"

Function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logPath -Value "$timestamp :: [JOIN_DOMAIN] $msg"
    Write-Host $msg
}

# Solicita o nome do domi≠nio
$dominio = Read-Host "Digite o nome do dom√≠nio (ex: dominio.empresa.com)"

# Exibe confirmacao para o usuario
Write-Host " - Dominio: $dominio"
$confirmacao = Read-Host "Deseja continuar? (S/N)"

if ($confirmacao -match '^[Ss]$') {
    try {
        Add-Computer -DomainName $dominio -Credential (Get-Credential) -Restart
    }
    catch {
        Write-Error "Erro ao dominio: $_"
    }
} else {
    Write-Host "Operacao cancelada pelo usuario."
}
