@echo off
title LAPTOP CHECK PRO - HENRY 2026
cls
echo ======================================================
echo    ALL-IN-ONE SYSTEM CHECK (KIEM TRA TOAN BO MAY TINH)
echo ======================================================
echo Please wait 3 seconds... (Vui long cho 3 giay...)

:: 1. COLLECTING DATA (DANG LAY THONG TIN)
powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores | Out-File -FilePath 'cpu.txt' -Encoding utf8"
powershell -Command "Get-CimInstance Win32_VideoController | Select-Object Caption | Out-File -FilePath 'gpu.txt' -Encoding utf8"
powershell -Command "Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum | ForEach-Object { '{0:N2} GB' -f ($_.Sum / 1GB) } | Out-File -FilePath 'ram.txt' -Encoding utf8"
powershell -Command "Get-CimInstance Win32_DiskDrive | Select-Object Model, @{Name='SizeGB';Expression={$_.Size/1GB}} | Out-File -FilePath 'ssd.txt' -Encoding utf8"
powershell -Command "Get-CimInstance Win32_VideoController | Select-Object CurrentRefreshRate | Out-File -FilePath 'screen.txt' -Encoding utf8"
powershell -Command "Get-CimInstance Win32_Bios | Select-Object SerialNumber | Out-File -FilePath 'seri.txt' -Encoding utf8"
powercfg /batteryreport > nul

:: 2. PYTHON ANALYZER (ROBOT PHAN TICH PYTHON)
python -c "import os; 
def read_f(name): return open(name, 'r', encoding='utf-16').read() if os.path.exists(name) else 'N/A';
c = read_f('cpu.txt'); g = read_f('gpu.txt'); r = read_f('ram.txt'); s = read_f('ssd.txt'); hz = read_f('screen.txt'); sn = read_f('seri.txt');

print('\n' + '='*50 + '\nDETECTIVE REPORT (BAN BAO CAO THAM TU)\n' + '='*50);
print(f'1. CPU (Bo nao): {c.splitlines()[-1] if len(c.splitlines())>1 else c.strip()}');
print(f'2. GPU (Hoa si): {g.splitlines()[-1] if len(g.splitlines())>1 else g.strip()}');
print(f'3. RAM (Ban lam viec): {r.strip()}');
print(f'4. SSD (Kho chua): {s.splitlines()[-1] if len(s.splitlines())>1 else s.strip()}');
print(f'5. SCREEN (Man hinh): {hz.splitlines()[-1] if len(hz.splitlines())>1 else hz.strip()} Hz');
print(f'6. SERIAL (So Seri): {sn.splitlines()[-1] if len(sn.splitlines())>1 else sn.strip()}');

print('\n' + '-'*50 + '\nAD vs REALITY (QUANG CAO VS THUC TE)\n' + '-'*50);
score = 0;
if 'i7' in c: print('CPU: MATCH! (GIONG i7) [OK] \xe2\x9c\x85'); score += 1;
else: print('CPU: WRONG! (KHONG PHAI i7) [FAIL] \xe2\x9d\x8c');

if '3060' in g: print('GPU: MATCH! (GIONG RTX 3060) [OK] \xe2\x9c\x85'); score += 1;
else: print('GPU: WRONG! (KHONG PHAI RTX 3060) [FAIL] \xe2\x9d\x8c');

print('\n' + '='*50);
if score >= 2: print('DECISION: BUY NOW! (QUYET DINH: MUA NGAY!)');
else: print('DECISION: DO NOT BUY! (QUYET DINH: KHONG MUA!)');
print('='*50);"

:: 3. CLEAN UP (DON DEP)
del cpu.txt gpu.txt ram.txt ssd.txt screen.txt seri.txt battery-report.html > nul 2>&1
pause
