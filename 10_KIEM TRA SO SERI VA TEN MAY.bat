@echo off
echo --- KIEM TRA SO SERI VA TEN MAY ---
wmic bios get serialnumber
wmic csproduct get name
pause

:: Mục tiêu: Lấy số Seri để cậu có thể tra cứu bảo hành trên mạng ngay lập tức.