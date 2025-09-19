# Menu
function Show-Menu {
    Clear-Host
    Write-Host "=== ONBOARDING DE MAQUINA ==="
    Write-Host "1. Desabilidar Hibernação GERAL"
    Write-Host "2. Instalar Programas/Apps"
    Write-Host "3. Atualizar Windows"
    Write-Host "Q. Sair"
    Write-Host "============================="
}

# tratamento de erro
function Invoke-ScriptWithReturn {
    param (
        [string]$ScriptPath
    )
    try {
        & $ScriptPath
    } catch {
        Write-Host "Erro ao executar o script: $_" -ForegroundColor Red
    }
    pause
}

# Loop principal
do {
    Show-Menu
    $opcao = Read-Host "Selecione uma opcao"
    
    switch ($opcao) {
        "1" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\01_disable_hibernate_point.ps1"
        }
        "2" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\02_install_apps_winget.ps1"
        }
        "3" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\03_install_windows_updates.ps1"
        }
    }
} until ($opcao -eq "q" -or $opcao -eq "Q")

Write-Host "Sistema configurado com sucesso!" -ForegroundColor Cyan