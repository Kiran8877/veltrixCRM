@echo off
set "PATH=C:\Program Files\nodejs;%PATH%"
title VeltrixCRM Launcher
echo ========================================================
echo               Starting VeltrixCRM
echo ========================================================
echo.
echo [1/2] Starting Backend Server on http://localhost:5050 ...
start "VeltrixCRM Backend API (Port 5050)" cmd /k "cd /d ""%~dp0"" && set ""PATH=C:\Program Files\nodejs;%%PATH%%"" && node server/index.js"

echo [2/2] Starting Frontend Client on http://localhost:3000 ...
start "VeltrixCRM Frontend Client (Port 3000)" cmd /k "cd /d ""%~dp0client"" && set ""PATH=C:\Program Files\nodejs;%%PATH%%"" && npx vite"

echo.
echo ========================================================
echo  Both servers are launching in separate windows!
echo  - Frontend: http://localhost:3000
echo  - Backend:  http://localhost:5050
echo  - Admin:    admin@veltrix.com / password123
echo  - Staff:    staff@veltrix.com / password123
echo ========================================================
echo.
pause
