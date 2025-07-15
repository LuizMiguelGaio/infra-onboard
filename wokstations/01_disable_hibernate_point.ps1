# DESCRICAO: Desabilita hibernacao, suspensao, protecao de tela e bloqueio de tela por tempo.  
# REQUISITOS: Executar como administrador.  
# USO: ./01_disable_hibernate_point.ps1  

# Definindo onde o log sera salvo
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
$logPath = Join-Path $scriptDir "log_setup.txt"

Function Log {
    param([string]$msg)
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Add-Content -Path $logPath -Value "$timestamp :: [DISABLE_HIBERNATE_POINT] $msg"
    Write-Host $msg
}

# Executar como administrador
Write-Host "Desativando hibernacao e suspensoes..."

# Desabilita a hibernacao (impacta tambem no Arquivo hiberfil.sys)
powercfg -h off

# Tempo de inatividade para desligar video: 0 (nunca)
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0

# Tempo de inatividade para suspender: 0 (nunca)
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0

# Tempo de inatividade para desligar disco: 0 (nunca)
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0

# Desativa protecao de tela
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveActive" -Value "0"

# Desativa bloqueio de tela por tempo
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaverIsSecure" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ScreenSaveTimeOut" -Value "0"

# Mensagem final
Write-Host "`nConfiguracoes de hibernacao e economia de energia desativadas com sucesso." -ForegroundColor Cyan