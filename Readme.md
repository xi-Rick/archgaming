# Arch Gaming Setup Script

A comprehensive gaming setup script for Arch Linux and its derivatives (CachyOS, EndeavourOS, Manjaro, Garuda, etc.)

![Arch Gaming Setup](https://github.com/xi-Rick/archgaming/blob/main/gaming.sh)

## Overview

This script automates the installation and configuration of gaming-related software, drivers, and optimizations for Arch-based Linux distributions. It detects your specific distribution and hardware, then tailors the installation process accordingly, providing a seamless setup experience for Linux gaming.

## Features

- **Distribution Detection**: Automatically identifies and optimizes for CachyOS, EndeavourOS, Manjaro, Garuda, or vanilla Arch
- **Driver Installation**: Detects and installs appropriate NVIDIA, AMD, or Intel graphics drivers
- **Gaming Platforms**:
  - Steam with Proton GE support via ProtonUp-Qt
  - Lutris for managing non-Steam games
  - Heroic Games Launcher for Epic Games & GOG
  - PlayOnLinux for Windows games
  - Steam Tinker Launch with Vortex and Mod Organizer 2 support
- **Emulation**: RetroArch, Cemu (Wii U), Dolphin (GameCube/Wii), PCSX2 (PS2), RPCS3 (PS3)
- **Performance Tools**:
  - GameMode for CPU optimization during gameplay
  - MangoHud for in-game performance monitoring
  - DXVK for DirectX to Vulkan translation
  - CoreCtrl for AMD GPU control
  - GreenWithEnvy for NVIDIA GPU control
- **System Optimization**: Kernel parameter tuning, Wine configuration, CPU performance mode settings

## Prerequisites

- An Arch-based Linux distribution
- Root access
- Internet connection

## Installation

1. Download the script:

   ```bash
   curl -O https://github.com/xi-Rick/archgaming/blob/main/gaming.sh
   ```

2. Make it executable:

   ```bash
   chmod +x gaming.sh
   ```

3. Run with root privileges (using -E to preserve environment variables):
   ```bash
   sudo -E ./gaming.sh
   ```

## Usage

The script is interactive and will guide you through the setup process with clear prompts. You can choose which components to install based on your preferences.

For each major component, you'll be asked for confirmation before installation:

- System updates
- Graphics drivers
- Gaming meta-packages
- Gaming platforms
- Performance tools
- System optimizations

## Distribution-Specific Features

The script provides tailored experiences for different Arch-based distributions:

- **CachyOS**: Installs cachyos-gaming-meta and cachyos-gaming-applications
- **Garuda**: Installs garuda-gaming and garuda-gamer utility
- **Manjaro**: Uses Manjaro's package manager and installs manjaro-gaming-meta
- **EndeavourOS**: Provides optimized installation for EndeavourOS environment
- **Vanilla Arch**: Standard Arch Linux gaming setup

## Post-Installation

After running the script, you may need to:

1. Reboot your system (the script will offer this option)
2. Configure your newly installed gaming platforms
3. Install games and enjoy!

## Resources

The script provides links to distribution-specific resources for further gaming optimization:

- Distribution wikis and forums
- ProtonDB for Steam game compatibility
- Gaming on Linux news site
- Linux gaming communities

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- The Arch Linux community
- Various Arch-based distribution communities (CachyOS, EndeavourOS, Manjaro, Garuda)
- Linux gaming communities for their continuous support and documentation
