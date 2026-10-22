# Windows Network Profile Switcher

A lightweight Windows batch utility to switch between different network configurations (Home DHCP, Work static IPs, USB tethering, and factory reset) with a single click. Automatically requests Administrator elevation when run.

![Platform](https://img.shields.io/badge/platform-Windows-0078D6)
![Shell](https://img.shields.io/badge/script-Batch-orange)
![License](https://img.shields.io/badge/license-MIT-green)

---

## ✨ Features

- **Automatic UAC Elevation:** Auto-elevates privileges to Administrator via PowerShell if launched in standard user context.
- **Home Profiles (DHCP):** Enables either Ethernet or Wi-Fi while disabling the redundant adapter to prevent routing conflicts.
- **Work Profiles (Static IP):** Assigns predefined static IP, subnet mask, and default gateway configurations.
- **USB Tethering Mode:** Disables fixed interfaces and switches to the mobile tethering adapter.
- **Full Reset Mode:** Re-enables all physical interfaces and restores standard dynamic DHCP addressing.

---

## ⚙️ Configuration

Before running the script, open `network_switcher.bat` in a text editor (e.g., Notepad, VS Code) and adapt the parameters in the **CONFIGURATION SECTION** to match your network environment:

```bat
set "IFACE_ETH=Ethernet"
set "IFACE_WIFI=Wi-Fi"
set "IFACE_USB=Ethernet 2"

set "WORK_IP_ETH=192.168.1.250"
set "WORK_IP_WIFI=192.168.1.251"
set "SUBNET_MASK=255.255.255.0"
set "DEFAULT_GATEWAY=192.168.1.1"

## 🚀 How to Run

Clone or download the repository:

Bash
git clone [https://github.com/Mannyland982/windows-network-switcher.git](https://github.com/Mannyland982/windows-network-switcher.git)
cd windows-network-switcher
Double-click network_switcher.bat (confirm the Windows UAC elevation prompt).

Select an option from 1 to 7 from the terminal menu.

📄 License
