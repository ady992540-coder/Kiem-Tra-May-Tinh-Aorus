@echo off
echo --- KIEM TRA KHO CHUA (SSD) ---
wmic diskdrive get model, size, status
powershell "Get-PhysicalDisk | Select-Object FriendlyName, HealthStatus, Size"
pause


:: Mục tiêu: SSD 512GB phải có chữ "Healthy" (Khỏe mạnh).