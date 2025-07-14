# DESCRICAO: Modulo para ajudar na criação de logs e evitar verbosidade dentro do script.  
# REQUISITOS: Executa dentro do script
# modules/LogHelper.psm1

# Funcao que inicializa o caminho do log e retorna a funcao Log pronta para uso
function Initialize-Logger {
    param (
        [string]$ScriptIdentifier  # Ex: "INSTALL_WINDOWS_UPDATE"
    )

    $scriptPath = $MyInvocation.PSCommandPath
    $scriptDir = Split-Path -Parent $scriptPath
    $logDir = Join-Path $scriptDir "..\logs"

    if (-not (Test-Path $logDir)) {
        New-Item -Path $logDir -ItemType Directory | Out-Null
    }

    $hostname = $env:COMPUTERNAME
    $logPath = Join-Path $logDir "$hostname.log"

    return {
        param ([string]$msg)
        $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        Add-Content -Path $logPath -Value "$timestamp :: [$ScriptIdentifier] $msg"
    }
}
