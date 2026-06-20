@echo off
cd /d E:\1.Environment\zerollama-dashboard

echo Starting dashboard with fixed progress bar...
start /b python -m http.server 3009 --bind 127.0.0.1
ping 127.0.0.1 -n 3 >nul
start http://127.0.0.1:3009/monitor-enhanced.html?server=http://127.0.0.1:8080
echo Dashboard open at http://127.0.0.1:3009/monitor-enhanced.html?server=http://127.0.0.1:8080
echo Test: start generation and watch the progress bar move
echo.
pause
