# infra-onboard

**Automação de onboarding de infraestrutura Windows pós-formatação, com foco em integração a domínio Active Directory.**

Este projeto oferece uma coleção modular de scripts PowerShell para preparar estações de trabalho (e futuramente servidores) após uma instalação limpa do Windows, facilitando a padronização de ambientes híbridos ou locais.

---

## Objetivos

- Automatizar o pós-formatação de máquinas Windows.
- Padronizar configuração e renomeação de estações.
- Automatizar updates, instalação de apps e ingresso ao domínio.
- Escalar para servidores e nuvem híbrida no futuro.

---

## Estrutura

```

infra-onboard/
├── workstation/       # Scripts para workstations (Testes)
├── server/            # Scripts para servidores (em desenvolvimento)
├── modules/           # Funções reutilizáveis em formato .psm1
├── logs/              # Local onde logs são salvos por máquina

````

---

## Módulos

Todos os scripts compartilham funções comuns localizadas em `/modules`.

- `LogHelper.psm1`: gerenciamento padronizado de logs por hostname.
- `Utility.psm1`: funções auxiliares reutilizáveis.

---

## Uso

Execute os scripts individualmente ou encadeie-os conforme necessário:

```powershell
# Exemplo: executar preparação básica para domínio
cd .\workstation\
.\01_posformat.ps1
.\02_windows_update.ps1
.\03_install_apps.ps1
.\04_rename_pc.ps1
.\05_domain_join.ps1
````

> É recomendável executar com privilégios de administrador.

---

## Requisitos

* PowerShell 5.1+ ou PowerShell Core (dependendo do ambiente)
* Execução de scripts habilitada (use `Set-ExecutionPolicy -Scope Process Bypass` para testes)
* Conectividade de rede para domínio e updates

---

## Futuro

* Scripts para onboarding de servidores Windows (`server/`)
* Integração com ambientes híbridos (Azure AD, Intune, etc.)
* Orquestrador unificado (`main.ps1`) para workflows automatizados
* Geração de relatórios de estado pós-onboarding

---

## 📜 Licença

Este projeto está licenciado sob os termos da [MIT License](./LICENSE).


---
