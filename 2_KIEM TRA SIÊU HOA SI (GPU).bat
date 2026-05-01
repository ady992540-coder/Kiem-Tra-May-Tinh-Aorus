@echo off
echo --- KIEM TRA SIÊU HOA SI (GPU) ---
nvidia-smi --query-gpu=name,memory.total,driver_version --format=csv
powershell "Get-CimInstance -ClassName Win32_VideoController | Select-Object caption, adapterram"
pause


:: "Mục tiêu: Xác nhận sức mạnh của RTX 3060."