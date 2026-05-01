@echo off
:menu
cls
echo ======================================================
echo       TRUNG TAM DIEU KHIEN KIEM TRA AORUS
echo ======================================================
echo 1. Kiem tra Bo Nao (CPU)
echo 2. Kiem tra Hoa Si (GPU)
echo 3. Kiem tra Ban Lam Viec (RAM)
echo 4. Kiem tra Kho Chua (SSD)
echo 5. Kiem tra Do Muot Man Hinh
echo 6. Kham suc khoe Pin
echo 7. Kiem tra Ngay sinh cua may
echo 8. Kiem tra Wi-Fi
echo 9. Kiem tra Loi Linh Kien (Driver)
echo 10. Lay So Seri (Tra bao hanh)
echo 0. Thoat
echo ======================================================
set /p choice=Nhap so cau muon kiem tra (0-10): 

if %choice%==1 goto cpu
if %choice%==2 goto gpu
if %choice%==3 goto ram
if %choice%==4 goto ssd
if %choice%==5 goto screen
if %choice%==6 goto pin
if %choice%==7 goto age
if %choice%==8 goto wifi
if %choice%==9 goto driver
if %choice%==10 goto seri
if %choice%==0 exit

:cpu
echo --- DANG SOI BO NAO ---
wmic cpu get name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed
pause
goto menu

:gpu
echo --- DANG SOI HOA SI ---
nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object caption, adapterram"
pause
goto menu

:ram
echo --- DANG SOI RAM ---
wmic memorychip get capacity, speed, manufacturer, partnumber
powershell "Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | ForEach-Object { '{0:N2} GB' -f ($_.Sum / 1GB) }"
pause
goto menu

:ssd
echo --- DANG SOI SSD ---
wmic diskdrive get model, size, status
powershell "Get-PhysicalDisk | Select-Object FriendlyName, HealthStatus, Size"
pause
goto menu

:screen
echo --- DANG SOI TAN SO QUET ---
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object CurrentRefreshRate"
pause
goto menu

:pin
echo --- DANG KHOI TAO BAO CAO PIN ---
powercfg /batteryreport
start battery-report.html
goto menu

:age
echo --- DANG SOI NGAY CAI DAT ---
systeminfo | findstr /C:"Original Install Date" /C:"System Boot Time"
pause
goto menu

:wifi
echo --- DANG SOI TIN HIEU MANG ---
netsh wlan show interfaces
pause
goto menu

:driver
echo --- DANG SOI LOI LINH KIEN ---
wmic deviceget where "status != 'OK'" get name, status
pause
goto menu

:seri
echo --- DANG LAY SO SERI ---
wmic bios get serialnumber
wmic csproduct get name
pause
goto menu