function Show-Menu {

    Write-Host "=== ONBOARDING DE MAQUINA ==="
    Write-Host "1. Preparar o pos-formatação"
    Write-Host "2. Puxar updates do windows"
    Write-Host "3. Instalar Programas/Apps"
    Write-Host "4. Renomeia o PC"
    Write-Host "5. Ingressa no dominio"
    Write-Host "Q. Sair"
    Write-Host "============================="
}

function Invoke-ScriptWithReturn {
    param (
        [string]$ScriptPath
    )
    try {
        & $ScriptPath
    } catch {
        Write-Host "Erro ao executar o script: $_" - -ForegroundColor Red
    }
    pause
    Show-Menu
}

# loop principal

do {
    Show-Menu
    $input = Read-Host "Selecione uma opcao"
    
    switch ($opcao){
        "1" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\01_disable_hibernate_point.ps1" 
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\02_create_restore_point.ps1}"
        }
        "2" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\03_install_windows_updates.ps1}"
        }
        "3" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\04_install_apps_chocolatey.ps1}"
        }
        "4" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\05_rename_computer.ps1}"
        }
        "5" {
            Invoke-ScriptWithReturn -ScriptPath "$PSScriptRoot\06_join_domain.ps1}"
        }
    }
} until ($input -eq "q")

Write-Host "Sistema configurado com sucesso!" -ForegroundColor Cyan