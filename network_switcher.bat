@echo off
setlocal enabledelayedexpansion

:: Check and request Windows Administrator Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [!] Requesting administrator privileges...
    powershell -Command "Start-Process -FilePath '%0' -Verb RunAs"
    exit /b
)

:: =============================================================================
:: CONFIGURATION SECTION (Customize your network interfaces & static IP values)
:: =============================================================================
set "IFACE_ETH=Ethernet"
set "IFACE_WIFI=Wi-Fi"
set "IFACE_USB=Ethernet 2"

set "WORK_IP_ETH=192.168.1.250"
set "WORK_IP_WIFI=192.168.1.251"
set "SUBNET_MASK=255.255.255.0"
set "DEFAULT_GATEWAY=192.168.1.1"
:: =============================================================================

:menu
cls
echo ===========================================
echo       WINDOWS NETWORK PROFILE SWITCHER
echo ===========================================
echo  1. HOME: Ethernet (DHCP)
echo  2. HOME: Wi-Fi (DHCP)
echo  3. WORK: Ethernet (Static IP: %WORK_IP_ETH%)
echo  4. WORK: Wi-Fi (Static IP: %WORK_IP_WIFI%)
echo  5. USB TETHERING (%IFACE_USB%)
echo  6. RESET ALL ADAPTERS (Enable all + DHCP)
echo  7. EXIT
echo ===========================================
set /p choice="Select an option (1-7): "

if "%choice%"=="1" goto home_eth
if "%choice%"=="2" goto home_wifi
if "%choice%"=="3" goto work_eth
if "%choice%"=="4" goto work_wifi
if "%choice%"=="5" goto usb_tethering
if "%choice%"=="6" goto reset_all
if "%choice%"=="7" exit /b
goto menu

:home_eth
echo [*] Applying HOME Ethernet configuration...
netsh interface set interface name="%IFACE_WIFI%" admin=disabled
netsh interface set interface name="%IFACE_ETH%" admin=enabled
netsh interface ipv4 set address name="%IFACE_ETH%" source=dhcp
netsh interface ipv4 set dnsservers name="%IFACE_ETH%" source=dhcp
goto status_check

:home_wifi
echo [*] Applying HOME Wi-Fi configuration...
netsh interface set interface name="%IFACE_ETH%" admin=disabled
netsh interface set interface name="%IFACE_WIFI%" admin=enabled
netsh interface ipv4 set address name="%IFACE_WIFI%" source=dhcp
netsh interface ipv4 set dnsservers name="%IFACE_WIFI%" source=dhcp
goto status_check

:work_eth
echo [*] Applying WORK Ethernet configuration...
netsh interface set interface name="%IFACE_WIFI%" admin=disabled
netsh interface set interface name="%IFACE_ETH%" admin=enabled
netsh interface ipv4 set address name="%IFACE_ETH%" static %WORK_IP_ETH% %SUBNET_MASK% %DEFAULT_GATEWAY%
goto status_check

:work_wifi
echo [*] Applying WORK Wi-Fi configuration...
netsh interface set interface name="%IFACE_ETH%" admin=disabled
netsh interface set interface name="%IFACE_WIFI%" admin=enabled
netsh interface ipv4 set address name="%IFACE_WIFI%" static %WORK_IP_WIFI% %SUBNET_MASK% %DEFAULT_GATEWAY%
goto status_check

:usb_tethering
echo [*] Enabling USB Tethering profile...
netsh interface set interface name="%IFACE_ETH%" admin=disabled
netsh interface set interface name="%IFACE_WIFI%" admin=disabled
netsh interface set interface name="%IFACE_USB%" admin=enabled
netsh interface ipv4 set address name="%IFACE_USB%" source=dhcp
goto status_check

:reset_all
echo [*] Resetting all interfaces to default DHCP...
netsh interface set interface name="%IFACE_ETH%" admin=enabled
netsh interface set interface name="%IFACE_WIFI%" admin=enabled
netsh interface ipv4 set address name="%IFACE_ETH%" source=dhcp
netsh interface ipv4 set address name="%IFACE_WIFI%" source=dhcp
netsh interface ipv4 set dnsservers name="%IFACE_ETH%" source=dhcp
netsh interface ipv4 set dnsservers name="%IFACE_WIFI%" source=dhcp
echo [V] All adapters reset successfully.
pause
goto menu

:status_check
if %errorlevel% neq 0 (
    echo.
    echo [X] Operation failed! Verify your network adapter names in the CONFIG section.
) else (
    echo [V] Profile applied successfully.
)
pause
goto menu
