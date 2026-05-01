@echo off
setlocal enabledelayedexpansion

echo ======================================================
echo    ALL-IN-ONE SYSTEM CHECK (KIEM TRA TOAN BO MAY TINH)
echo ======================================================
echo Please wait... (Vui long cho trong giay lat...)

:: 1. GATHERING DATA (DANG THU THAP DU LIEU)
wmic cpu get name, NumberOfCores > cpu.txt
wmic memorychip get capacity > ram.txt[cite: 3]
wmic diskdrive get model, size > ssd.txt
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object caption" > gpu.txt
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object CurrentRefreshRate" > screen.txt[cite: 5]
powercfg /batteryreport > nul
systeminfo | findstr /C:"Original Install Date" > age.txt[cite: 7]
wmic bios get serialnumber > seri.txt

:: 2. RUNNING PYTHON ANALYZER (DANG GOI ROBOT PHAN TICH)
python -c "import os; 
def get_txt(f): return open(f, 'r').read().strip() if os.path.exists(f) else 'N/A';
cpu = get_txt('cpu.txt'); ram = get_txt('ram.txt'); ssd = get_txt('ssd.txt'); gpu = get_txt('gpu.txt');
screen = get_txt('screen.txt'); age = get_txt('age.txt'); seri = get_txt('seri.txt');

# ADVERTISING DATA (DU LIEU QUANG CAO)
target = {'cpu': 'i7-10870H', 'gpu': 'RTX 3060', 'ram': 32, 'ssd': 512};

# LOGIC COMPARISON (SO SANH)
print('\n' + '='*50 + '\nFINAL REPORT (BAN BAO CAO CUOI CUNG)\n' + '='*50);
print(f'1. CPU (BO NAO): {cpu}');
print(f'2. GPU (HOA SI): {gpu}');
print(f'3. RAM (BAN LAM VIEC): {ram}');
print(f'4. SSD (KHO CHUA): {ssd}');
print(f'5. SCREEN (MAN HINH): {screen}');
print(f'6. AGE (TUOI MAY): {age}');
print(f'7. SERIAL (SO SERI): {seri}');

print('\n' + '-'*50 + '\nCOMPARISON (SO SANH VOI QUANG CAO)\n' + '-'*50);
points = 0;
if 'i7' in cpu: print('CPU: MATCH! (GIONG QUANG CAO) ✅'); points += 1;
else: print('CPU: DIFFERENT! (KHAC QUANG CAO) ❌');

if '3060' in gpu: print('GPU: MATCH! (GIONG QUANG CAO) ✅'); points += 1;
else: print('GPU: DIFFERENT! (KHAC QUANG CAO) ❌');

# FINAL VERDICT (QUYET DINH CUOI CUNG)
print('\n' + '='*50);
if points >= 2: print('VERDICT: BUY NOW! (QUYET DINH: MUA NGAY!)');
else: print('VERDICT: DO NOT BUY! (QUYET DINH: KHONG NEN MUA!)');
print('='*50);"

:: 3. CLEAN UP (DON DEP)
del cpu.txt ram.txt ssd.txt gpu.txt screen.txt age.txt seri.txt
pause
