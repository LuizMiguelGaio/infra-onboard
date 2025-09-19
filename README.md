# LEGACY WINDOWS AUTOMATION - INSTRUÇÕES DE USO

Automatização pensada para ambientes legados Windows. O objetivo é acelerar a preparação de estações de trabalho sem complicar a vida do administrador.

---

### Pré-requisitos

* Sistema Operacional: Windows 10
* Permissões: PowerShell executado como Administrador
* Política de Execução: Ajustada temporariamente para permitir scripts (sem impacto permanente nas políticas corporativas).

---

### Passo a Passo

#### 1. Preparar o Ambiente

Antes de rodar o menu de instalação de aplicativos (02\_installApps.ps1), execute o download do winget:
https://learn.microsoft.com/en-us/windows/package-manager/winget/ 
Isso garante que o winget esteja pronto para uso.

#### 2. Baixar o Repositório

* Acesse o repositório: [https://github.com/LuizMiguelGaio/infra-onboard](https://github.com/LuizMiguelGaio/infra-onboard)
* Baixe o código (Clone ou Download → Download ZIP)
* Extraia a pasta em um local simples, por exemplo: C:\\

#### 3. Habilitar Execução de Scripts (Sessão Atual)

Abra o PowerShell como Administrador e rode:
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

Nota:

* Vale apenas para esta sessão.
* Não altera políticas globais nem deixa rastros permanentes.

#### 4. Executar o Menu

No mesmo PowerShell, navegue até a pasta:
cd "C:\infra-onboard-main\workstations"  # Ajuste se necessário
.\00_OnboardingMenu.ps1

#### 5. Usando o Menu Interativo

* O onboardingMenu.ps1 é o ponto central: ele chama os outros scripts.
* Todos rodam sem restrição de política (herdam a configuração da sessão).
* Apenas a opção 4 do menu fará o sistema reiniciar.

---

### Observações Corporativas

* Ambientes controlados por TI: consulte o time de segurança antes de rodar scripts não assinados.
* Boa prática: se possível, assine os scripts com um certificado válido da empresa.

