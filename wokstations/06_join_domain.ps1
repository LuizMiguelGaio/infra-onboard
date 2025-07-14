# Solicita o nome do domínio
$dominio = Read-Host "Digite o nome do domínio (ex: dominio.empresa.com)"

# Exibe confirmação para o usuário
Write-Host " - Domínio: $dominio"
$confirmacao = Read-Host "Deseja continuar? (S/N)"

if ($confirmacao -match '^[Ss]$') {
    try {
        Add-Computer -DomainName $dominio -Credential (Get-Credential) -Restart
    }
    catch {
        Write-Error "Erro ao domínio: $_"
    }
} else {
    Write-Host "Operação cancelada pelo usuário."
}
