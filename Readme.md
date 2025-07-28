# 🎮 Arch Gaming Setup Script

<div align="center">

![ArchGaming](https://img.shields.io/badge/archgaming-red?style=for-the-badge&logo=archlinux&logoColor=white)
![Version](https://img.shields.io/badge/version-2.0-green?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-purple?style=for-the-badge)
![Gaming](https://img.shields.io/badge/gaming-optimized-orange?style=for-the-badge&logo=steam&logoColor=white)

**Transform Your Arch System into the Ultimate Gaming Powerhouse**

_From fresh installation to gaming paradise in minutes – supporting all major Arch derivatives!_

</div>

---

## 🌟 What Makes ArchGaming Special?

This isn't just another gaming setup script – it's your **personal gaming optimization engineer** that transforms any Arch-based system into a high-performance gaming machine. Whether you're running vanilla Arch, CachyOS for maximum performance, or any derivative, this script delivers a perfectly tuned gaming environment.

### ✨ Key Features

- 🎯 **Universal Arch Support**: Optimized for 8+ Arch-based distributions
- 🎨 **Intelligent Hardware Detection**: Auto-detects GPU and installs optimal drivers
- 🚀 **Performance-First**: Gaming-focused kernel parameters and system optimizations
- 🎮 **Complete Gaming Stack**: Steam, Lutris, emulators, and performance tools
- 🔧 **Smart Configuration**: Pre-configures Wine, DXVK, and Proton for best compatibility
- 🛡️ **Safe & Reliable**: Comprehensive error handling and rollback capabilities

---

## 🎯 Supported Distributions

<table>
<tr>
<td align="center">
  <img src="https://archlinux.org/static/logos/archlinux-logo-dark-90dpi.ebdee92a15b3.png" width="50"><br>
  <strong>Arch Linux</strong><br>
  <em>Pure Arch experience</em>
</td>
<td align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/EndeavourOS_Logo.svg/800px-EndeavourOS_Logo.svg.png" width="50"><br>
  <strong>EndeavourOS</strong><br>
  <em>User-friendly Arch</em>
</td>
<td align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Manjaro-logo.svg/2048px-Manjaro-logo.svg.png" width="50"><br>
  <strong>Manjaro</strong><br>
  <em>Stable release cycle</em>
</td>
<td align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/CachyOS_Logo.svg/2048px-CachyOS_Logo.svg.png" width="50"><br>
  <strong>CachyOS</strong><br>
  <em>Lightning fast</em>
</td>
<td align="center">
  <img src="https://artixlinux.org/img/artix-logo.png" width="50"><br>
  <strong>Artix Linux</strong><br>
  <em>SystemD-free</em>
</td>
</tr>
</table>

---

## 🚀 Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/xi-Rick/archgaming.git
cd archgaming

# Make it executable
chmod +x gaming.sh

# Run with elevated privileges
sudo -E ./gaming.sh
```

---

## 🎛️ Interactive Gaming Menu

When you run the script, you'll see a beautiful, distribution-aware interface:

```
🎮 ArchGaming Setup v2.0
Distribution: CachyOS
GPU: NVIDIA GeForce RTX 4070
Kernel: linux-cachyos

========== Gaming Installation Menu ==========
Select components to install (space-separated numbers):

🎯 Core Gaming
 1) Graphics Drivers (Auto-detected: NVIDIA)
 2) Gaming Platforms (Steam, Lutris, Heroic)
 3) Wine & Compatibility Layers

🎮 Game Launchers & Stores
 4) Steam + Proton GE + SteamTinkerLaunch
 5) Lutris + Wine-GE + DXVK
 6) Heroic Games Launcher (Epic/GOG)
 7) Bottles (Wine prefix manager)

🕹️ Emulation Station
 8) RetroArch + Cores
 9) Console Emulators (Dolphin, PCSX2, RPCS3)
10) Handheld Emulators (Citra, Ryujinx)

⚡ Performance & Monitoring
11) GameMode + MangoHud
12) Performance Tuning (CPU Governor, I/O Scheduler)
13) GPU Control Tools (CoreCtrl/GreenWithEnvy)

🔧 Advanced Gaming Tools
14) Mod Management (Vortex via SteamTinkerLaunch)
15) VR Gaming Support (SteamVR, OpenXR)
16) Game Development Tools

🌟 Quick Setups
17) Essential Gaming (1,2,3,4,11)
18) Complete Gaming Setup (All components)
19) Competitive Gaming (Performance focused)
20) Retro Gaming Paradise (Emulation focused)

Enter your choices:
```

### Example Usage Scenarios

**New Gamer Setup:**

```bash
Enter your choices: 17
```

_Installs essential drivers, platforms, compatibility layers, and performance tools_

**Retro Gaming Enthusiast:**

```bash
Enter your choices: 20
```

_Complete emulation setup with RetroArch and all console emulators_

**Competitive Gamer:**

```bash
Enter your choices: 19
```

_Performance-focused installation with latency reduction and monitoring tools_

**Complete Gaming Rig:**

```bash
Enter your choices: 18
```

_Everything you need for any type of gaming on Linux_

---

## 🎮 What Gets Installed

### 🎯 Graphics Drivers

**Auto-Detection & Installation:**

```bash
# NVIDIA (Automatically detects card generation)
nvidia nvidia-utils nvidia-settings
nvidia-dkms  # For custom kernels

# AMD
mesa vulkan-radeon libva-mesa-driver
amdvlk  # Vulkan driver

# Intel
mesa vulkan-intel intel-media-driver
```

### 🎮 Gaming Platforms

**Steam Ecosystem:**

```bash
# Steam with Proton support
steam steam-native-runtime
# Proton GE Custom for better compatibility
protonup-qt  # GUI manager for Proton versions
# SteamTinkerLaunch for advanced tweaking
steamtinkerlaunch
```

**Multi-Platform Gaming:**

```bash
# Lutris - Universal game manager
lutris wine-staging wine-ge-custom
# Heroic Games Launcher
heroic-games-launcher-bin
# Bottles - Wine prefix manager
bottles
```

### 🕹️ Emulation Powerhouse

**RetroArch Complete:**

```bash
# Core emulator with all systems
retroarch retroarch-assets-xmb retroarch-assets-ozone
libretro-* # All available cores
# Frontend alternatives
emulationstation attract pegasus-frontend
```

**Console Emulators:**

```bash
# Modern consoles
dolphin-emu      # GameCube/Wii
pcsx2            # PlayStation 2
rpcs3-git        # PlayStation 3
duckstation      # PlayStation 1

# Nintendo handhelds
citra            # 3DS
ryujinx          # Switch alternative
```

### ⚡ Performance Arsenal

**Gaming Optimization:**

```bash
# CPU optimization during gaming
gamemode lib32-gamemode
# Performance monitoring overlay
mangohud lib32-mangohud goverlay
# Vulkan improvements
dxvk-bin vkd3d
```

**System Tuning:**

```bash
# CPU governor management
cpupower auto-cpufreq
# I/O scheduler optimization
ioscheduler-udev-rules
# Memory optimization
preload zram-generator
```

---

## 🎨 Distribution-Specific Optimizations

### CachyOS Features

```bash
# Performance-optimized packages
cachyos-gaming-meta
cachyos-kernel-manager
# Optimized Wine builds
wine-cachyos
# Performance monitoring
cachyos-hello
```

### Garuda Linux Features

```bash
# Gaming meta package
garuda-gaming
# Garuda-specific tools
garuda-gamer garuda-assistant
# Pre-configured gaming environment
garuda-gaming-applications
```

### Manjaro Features

```bash
# Manjaro gaming collection
manjaro-gaming-meta
# Hardware detection
mhwd mhwd-db
# Manjaro settings manager
manjaro-settings-manager
```

---

## ⚙️ Advanced Configuration

### Automatic Wine Setup

The script creates optimized Wine prefixes:

```bash
# Gaming-optimized Wine prefix
WINEPREFIX=$HOME/.wine-gaming
winetricks -q vcrun2019 dotnet48 corefonts
# DirectX and Visual C++ runtimes
winetricks -q d3dx9 d3dx10 d3dx11 vcrun2015
```

### Kernel Parameter Optimization

```bash
# /etc/default/grub additions
GRUB_CMDLINE_LINUX_DEFAULT="... mitigations=off processor.max_cstate=1 intel_idle.max_cstate=0"
# For AMD CPUs
GRUB_CMDLINE_LINUX_DEFAULT="... amd_pstate=passive"
```

### GPU-Specific Optimizations

**NVIDIA:**

```bash
# Optimal driver settings
nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
# Power management
nvidia-settings --assign GPUPowerMizerMode=1
```

**AMD:**

```bash
# AMDGPU optimization
echo 'high' > /sys/class/drm/card0/device/power_dpm_force_performance_level
# Vulkan enhancements
export RADV_PERFTEST=aco,llvm
```

---

## 🔧 Post-Installation Configuration

### Steam Setup

```bash
# Enable Proton for all titles
Steam > Settings > Steam Play > Enable for all titles
# Install Proton GE
ProtonUp-Qt: Download latest GE version
# Configure SteamTinkerLaunch
Steam > Game Properties > Launch Options:
STLCMD="%command%" %command%
```

### Lutris Configuration

```bash
# Install Wine-GE
Lutris > Preferences > Runners > Wine > Download Wine-GE
# DXVK setup
Lutris > Preferences > System Options > Enable DXVK
# MangoHud integration
Environment variables: MANGOHUD=1
```

### Performance Monitoring Setup

```bash
# MangoHud configuration (~/.config/MangoHud/MangoHud.conf)
fps
frametime=1
cpu_temp
gpu_temp
ram
vram
position=top-left
```

---

## 📊 Gaming Performance Benchmarks

After installation, the script provides performance validation:

```
🎮 Gaming Setup Complete!

Performance Status:
  Graphics Driver: ✅ NVIDIA 545.29.06
  Vulkan Support: ✅ Enabled
  DXVK: ✅ Latest version installed
  GameMode: ✅ Active
  MangoHud: ✅ Configured

Gaming Platforms:
  Steam: ✅ Ready with Proton GE
  Lutris: ✅ Wine-GE configured
  Heroic: ✅ Epic Games & GOG ready
  RetroArch: ✅ All cores installed

Emulation Status:
  Dolphin (GameCube/Wii): ✅ Optimized
  PCSX2 (PS2): ✅ Latest stable
  RPCS3 (PS3): ✅ Development build

🚀 Your Arch gaming rig is ready to dominate!

🎯 Next Steps:
  • Reboot to apply kernel parameters
  • Launch Steam and enable Proton for all games
  • Join ProtonDB to check game compatibility
  • Configure MangoHud overlay settings

📈 Expected Performance Improvements:
  • 15-30% better frame rates with GameMode
  • Reduced input latency with optimized kernel
  • Better compatibility with Proton GE
  • Professional monitoring with MangoHud
```

---

## 🎯 Gaming Optimization Profiles

### Competitive Gaming Profile

```bash
# Ultra-low latency configuration
echo 'performance' | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
# Disable CPU mitigations
GRUB_CMDLINE_LINUX_DEFAULT="... mitigations=off"
# High-precision mouse
echo 1000 > /sys/module/usbhid/parameters/mousepoll
```

### High-End Gaming Profile

```bash
# Maximum performance
cpupower frequency-set -g performance
# GPU overclocking (NVIDIA)
nvidia-settings --assign GPUGraphicsClockOffset[3]=100
# Memory optimization
echo always > /sys/kernel/mm/transparent_hugepage/enabled
```

### Battery-Conscious Gaming Profile

```bash
# Balanced performance for laptops
cpupower frequency-set -g powersave
# GPU power limit
nvidia-smi -pl 150  # 150W limit for NVIDIA
# Reduced refresh rate
xrandr --output eDP-1 --rate 60
```

---

## 🛡️ Troubleshooting & Support

### Common Issues & Solutions

**Steam games not launching:**

```bash
# Verify Proton installation
ls ~/.steam/compatibilitytools.d/
# Reset Steam
rm -rf ~/.steam/steam/appcache/
```

**Poor gaming performance:**

```bash
# Check GameMode status
gamemoded -s
# Verify GPU drivers
glxinfo | grep "OpenGL renderer"
# Check thermal throttling
watch sensors
```

**Wine games crashing:**

```bash
# Reinstall Wine dependencies
winetricks --force vcrun2019 dotnet48
# Check Wine logs
tail -f ~/.wine/drive_c/windows/temp/wine.log
```

---

## 🤝 Contributing

Help make ArchGaming even better! Here's how:

### Development Setup

```bash
git clone https://github.com/xi-Rick/archgaming.git
cd archgaming

# Test in virtual machine
qemu-system-x86_64 -enable-kvm -m 4G archlinux.qcow2
# Or use containers
docker run -it archlinux:latest /bin/bash
```

### Testing Checklist

- [ ] Test on vanilla Arch Linux
- [ ] Test on major derivatives (CachyOS, EndeavourOS, Manjaro)
- [ ] Verify NVIDIA driver installation
- [ ] Verify AMD driver installation
- [ ] Test Steam Proton functionality
- [ ] Verify emulator installation
- [ ] Check performance tools

---

## 📚 Resources & Community

### Official Documentation

- [Arch Wiki Gaming](https://wiki.archlinux.org/title/Gaming)
- [ProtonDB](https://www.protondb.com/) - Game compatibility database
- [Lutris](https://lutris.net/) - Game management platform

### Gaming Communities

- [r/linux_gaming](https://reddit.com/r/linux_gaming) - Reddit community
- [Gaming on Linux](https://www.gamingonlinux.com/) - News and reviews
- [Boiling Steam](https://boilingsteam.com/) - Linux gaming coverage

### Distribution-Specific Resources

- **CachyOS**: [Gaming Wiki](https://wiki.cachyos.org/gaming/)
- **Garuda**: [Gaming Guide](https://wiki.garudalinux.org/gaming)
- **Manjaro**: [Gaming Tutorial](https://wiki.manjaro.org/gaming)

---

<div align="center">

**🎮 Ready to Game on Arch? ⭐ Star this repo and let's play! ⭐**

_Transform your Arch system into a gaming powerhouse today!_

Made with 🎮 by gamers, for the Linux gaming community

</div>
