@echo off
echo --- KIEM TRA BAN LAM VIEC (RAM) ---
wmic memorychip get capacity, speed, manufacturer, partnumber
powershell "Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | ForEach-Object { '{0:N2} GB' -f ($_.Sum / 1GB) }"
pause

:: Mục tiêu: Xem có đúng 32GB và máy đang dùng mấy khe cắm.