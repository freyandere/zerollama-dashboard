@echo off
cd /d E:\1.Environment\zerollama-dashboard

:: Start Python HTTP server in background
start /b python -m http.server 3009 --bind 127.0.0.1

:: Open enhanced dashboard in browser
ping 127.0.0.1 -n 3 >nul
start http://127.0.0.1:3009/monitor-enhanced.html?server=http://127.0.0.1:8080
