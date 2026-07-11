@echo off
cd /d "%~dp0"
echo ==================================================
echo    Curso Nivelatorio de R  -  Servidor local
echo ==================================================
echo.
echo  1) DEJA esta ventana negra ABIERTA mientras usas el curso.
echo  2) Abre tu navegador en esta direccion:
echo.
echo         http://localhost:8099/index.html
echo.
echo  Para DETENER el servidor: cierra esta ventana.
echo ==================================================
echo.
py -m http.server 8099 2>nul || python -m http.server 8099
echo.
echo (Si ves un error arriba, es que Python no esta instalado:
echo  instalalo desde https://www.python.org/downloads/ y marca
echo  la casilla "Add Python to PATH".)
pause
