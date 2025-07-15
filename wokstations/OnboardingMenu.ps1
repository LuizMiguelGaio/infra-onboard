Write-Host "=== ONBOARDING DE MAQUINA ==="
Write-Host "1. Preparar o pós-formatação"
Write-Host "2. Puxar updates do windows (Deve reiniciar)"
Write-Host "3. Instalar Programas/Apps"
Write-Host "4. Renomeia o PC (Fazer Logoff)"
Write-Host "5. Ingressa no dominio (Fazer Logoff)"
$opcao = Read-Host "Escolha uma etapa (1-5)"

switch ($opcao){
    "1" {.\01_disable_hibernate_point.ps1; .\02_create_restore_point.ps1}
    "2" {.\03_install_windows_updates.ps1}
    "3" {.\04_install_apps_chocolatey.ps1}
    "4" {.\05_rename_computer.ps1}
    "5" {.\06_join_domain.ps1}
    }