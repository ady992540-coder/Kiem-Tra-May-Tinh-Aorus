@echo off
echo --- KIEM TRA NGAY SINH CUA MAY ---
systeminfo | findstr /C:"Original Install Date" /C:"System Boot Time"
pause

:: Mục tiêu: Biết máy này đã được cài lại Windows khi nào và hoạt động bao lâu rồi.

