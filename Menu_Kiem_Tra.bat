@echo off
:menu
cls
echo ======================================================
echo    MASTER LAPTOP CHECK (TRUNG TAM KIEM TRA MAY TINH)
echo ======================================================
echo 1. Check Processor (Kiem tra Bo nao - CPU)
echo 2. Check Graphics (Kiem tra Hoa si - GPU)
echo 3. Check Memory (Kiem tra RAM)
echo 4. Check Storage (Kiem tra O cung SSD)
echo 5. Check Screen Refresh (Kiem tra Do muot man hinh)
echo 6. Check Battery Health (Kham suc khoe Pin)
echo 7. Check System Age (Kiem tra ngay cai dat may)
echo 8. Check Wi-Fi Signal (Kiem tra tin hieu Wi-Fi)
echo 9. Check Hardware Errors (Kiem tra loi linh kien)
echo 10. Get Serial Number (Lay so Seri de check bao hanh)
echo 0. Exit (Thoat)
echo ======================================================
set /p choice=Select a number (Chon mot so 0-10): 

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
echo --- CHECKING PROCESSOR (DANG SOI BO NAO) ---
wmic cpu get name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed
pause
goto menu

:gpu
echo --- CHECKING GRAPHICS (DANG SOI HOA SI) ---
nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv[cite: 2]
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object caption, adapterram"[cite: 2]
pause
goto menu

:ram
echo --- CHECKING MEMORY (DANG SOI RAM) ---
wmic memorychip get capacity, speed, manufacturer[cite: 3]
powershell "Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | ForEach-Object { '{0:N2} GB' -f ($_.Sum / 1GB) }"[cite: 3]
pause
goto menu

:ssd
echo --- CHECKING STORAGE (DANG SOI O CUNG) ---
wmic diskdrive get model, size, status[cite: 4]
pause
goto menu

:screen
echo --- CHECKING REFRESH RATE (DANG SOI DO MUOT MAN HINH) ---
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object CurrentRefreshRate"[cite: 5]
pause
goto menu

:pin
echo --- CHECKING BATTERY (DANG KHAM SUC KHOE PIN) ---
powercfg /batteryreport
python -c "import os; content = open('battery-report.html', 'r', encoding='utf-8').read(); d = int(content.split('DESIGN CAPACITY')[1].split('</td>')[1].split('>')[1].strip().replace(',', '').split(' mWh')[0]); f = int(content.split('FULL CHARGE CAPACITY')[1].split('</td>')[1].split('>')[1].strip().replace(',', '').split(' mWh')[0]); h = (f/d)*100; print('\n' + '='*40 + '\nBATTERY RESULT (KET QUA PIN):\n' + '-'*40); print(f'Original (Binh moi): {d} mWh'); print(f'Current (Hien tai): {f} mWh'); print(f'Health (Suc khoe): {h:.2f}%%'); print('='*40); print('BUY NOW! (MUA NGAY!)' if h>90 else 'GOOD (DUNG TOT)' if h>80 else 'THINK AGAIN (CAN CAN NHAC)')"
pause
goto menu

:age
echo --- CHECKING SYSTEM AGE (DANG SOI TUOI MAY) ---
systeminfo | findstr /C:"Original Install Date"[cite: 7]
pause[cite: 1]
goto menu

:wifi
echo --- CHECKING WI-FI (DANG SOI TIN HIEU WIFI) ---
netsh wlan show interfaces[cite: 8]
pause[cite: 1]
goto menu

:driver
echo --- CHECKING ERRORS (DANG SOI LOI LINH KIEN) ---
wmic deviceget where "status != 'OK'" get name, status[cite: 9]
pause[cite: 1]
goto menu

:seri
echo --- GETTING SERIAL (DANG LAY SO SERI) ---
wmic bios get serialnumber[cite: 10]
wmic csproduct get name[cite: 10]
pause[cite: 1]
goto menu
