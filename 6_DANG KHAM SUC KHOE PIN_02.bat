@echo off
echo --- 1. DANG KHAM SUC KHOE PIN... ---
powercfg /batteryreport

echo --- 2. DANG GOI THONG DICH VIEN PYTHON... ---
python -c "import os; content = open('battery-report.html', 'r', encoding='utf-8').read(); d = int(content.split('DESIGN CAPACITY')[1].split('</td>')[1].split('>')[1].strip().replace(',', '').split(' mWh')[0]); f = int(content.split('FULL CHARGE CAPACITY')[1].split('</td>')[1].split('>')[1].strip().replace(',', '').split(' mWh')[0]); h = (f/d)*100; print('\n' + '='*40 + '\nKẾT QUẢ KHÁM PIN:\n' + '-'*40); print(f'Bình nước mới: {d} mWh'); print(f'Nước hiện tại: {f} mWh'); print(f'Sức khỏe: {h:.2f}%%'); print('='*40); print('KET LUAN: MUA NGAY!' if h>90 else 'KET LUAN: DUNG TOT.' if h>80 else 'KET LUAN: CAN CAN NHAC!')"

pause