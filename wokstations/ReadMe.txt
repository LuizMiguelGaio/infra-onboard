
# **LEGACY WINDOWS AUTOMATION - INSTRUÇÕES DE USO**  

### **Pré-requisitos**  
✅ **Sistema Operacional**: Windows 10  
✅ **Permissões**: PowerShell executado como **Administrador**  
✅ **Política de Execução**: Temporariamente ajustada para permitir scripts (não afeta políticas corporativas permanentes).  

---

### **Passo a Passo**  

#### **1. Baixar o Repositório**  
- Acesse o repositório: **[https://github.com/LuizMiguelGaio/legacy-windows-automation](https://github.com/LuizMiguelGaio/legacy-windows-automation)**  
- Baixe o código (Clone ou Download → "Download ZIP")  
- Extraia a pasta em um local de fácil acesso (ex.: `C:\Automacao`)  

#### **2. Habilitar Execução de Scripts (Temporário)**  
Abra o PowerShell **como Administrador** e execute:  
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
```  
⚠ **Importante**:  
- Essa configuração vale apenas **para esta sessão** (não persiste após fechar o PowerShell).  
- Não altera políticas de segurança do sistema permanentemente.  

#### **3. Navegar até a Pasta e Executar o Menu**  
No **mesmo PowerShell** (já com permissão temporária), digite:  
```powershell
cd C:\Automacao\legacy-windows-automation-main\workstations  # Ajuste o caminho conforme sua extração
.\onboardingMenu.ps1
```  

#### **4. Usando o Menu Interativo**  
- O script `onboardingMenu.ps1` chamará outros scripts automaticamente.  
- Todos os scripts rodarão **sem erros de política de execução**, pois herdam a configuração da sessão atual.  

---

graph TD
  A[PowerShell Admin] --> B[Set ExecutionPolicy]
  B --> C[Execute Menu]
  C --> D[Scripts Automatizados]

---

### **Solução de Problemas**  
🔹 **Erro "File cannot be loaded"**:  
- Certifique-se de que:  
  1. O PowerShell foi aberto **como Administrador**.  
  2. O comando `Set-ExecutionPolicy` foi executado **antes** de rodar o menu.  

🔹 **Script bloqueado pelo Windows**:  
- Caso o script tenha sido baixado da internet, desbloqueie-o com:  
  ```powershell
  Unblock-File -Path C:\Automacao\legacy-windows-automation-main\workstations\*.ps1
  ```  

---

### **Observações Corporativas**  
- **Ambientes controlados por TI**: Consulte a equipe de segurança antes de executar scripts desconhecidos.  
- **Alternativa corporativa**: Se possível, assine os scripts com um certificado válido da empresa.  

---

### **Exemplo de Uso em Imagem**  
```powershell
PS C:\> Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
PS C:\> cd C:\Automacao\legacy-windows-automation-main\workstations
PS C:\Automacao...> .\onboardingMenu.ps1
```  
