@echo off
echo --- KIEM TRA DO MUOT MAN HINH ---
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object CurrentRefreshRate"
pause


:: Mục tiêu: Aorus thường có màn hình 240Hz siêu mượt, nếu hiện 60Hz thì cần xem lại.

