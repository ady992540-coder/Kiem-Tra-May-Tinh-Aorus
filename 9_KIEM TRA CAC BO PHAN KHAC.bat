@echo off
echo --- KIEM TRA CAC BO PHAN KHAC ---
wmic deviceget where "status != 'OK'" get name, status
pause

:: Mục tiêu: Nếu hiện danh sách là máy đang bị lỗi Driver (thiếu tay chân).