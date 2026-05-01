@echo off
echo --- KIEM TRA BO NAO (CPU) ---
wmic cpu get name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed
pause

:: "Mục tiêu: Kiểm tra xem có đúng là i7-10870H với 8 nhân 16 luồng không."