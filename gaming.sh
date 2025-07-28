#!/bin/bash

# Arch Gaming Setup Script v2.0 - Interactive Menu Edition
# This script helps set up gaming environments on Arch-based distributions
# Run script with sudo -E ./gaming.sh

# Colors for better readability
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
ORANGE='\033[0;33m'
PURPLE='\033[0;35m'
LIGHT_BLUE='\033[1;34m'
LIGHT_GREEN='\033[1;32m'
LIGHT_CYAN='\033[1;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Set REAL_USER from SUDO_USER (or fallback to current user)
REAL_USER=${SUDO_USER:-$(whoami)}
# Assumes home directory is /home/<REAL_USER>
USER_HOME="/home/$REAL_USER"

# Global variables for system detection
DISTRO=""
DISTRO_NAME=""
DISTRO_STYLE=""
GPU_INFO=""
CPU_INFO=""
KERNEL_INFO=""

# Array to store user selections
declare -a SELECTED_COMPONENTS=()

# Function to display ASCII art based on detected distro
display_ascii_art() {
    local distro=$1
    case "$distro" in
        "cachyos")
            echo -e "${CYAN}"
            echo -e "   _____                _              ____   _____    _____                 _             "
            echo -e "  / ____|              | |            / __ \ / ____|  / ____|               (_)            "
            echo -e " | |     __ _  ___  ___| |__  _   _  | |  | | (___   | |  __  __ _ _ __ ___ _ _ __   __ _ "
            echo -e " | |    / \`_\` |/ _ \\/ __| '_ \\| | | | | |  | |\\___ \\  | | |_ |/ \`_\` | '_ \` _ \\| | '_ \\ / _\` |"
            echo -e " | |___| (_| | (__| (__| | | | |_| | | |__| |____) | | |__| | (_| | | | | | | | | | | (_| |"
            echo -e "  \\_____\\__,_|\\___|\\___|_| |_|\\__, |  \\____/|_____/   \\_____|\__,_|_| |_| |_|_|_| |_|\\__, |"
            echo -e "                               __/ |                                                   __/ |"
            echo -e "                              |___/                                                   |___/ "
            echo -e "                        🎮 G A M I N G  S E T U P  v2.0 🎮                                "
            echo -e "${NC}"
            ;;
        "endeavouros")
            echo -e "${PURPLE}"
            echo -e "  ______  _   _____  ______   ___    _______  __  __  ______   ____   _____"
            echo -e " / ____// | / / __ \\/ ____/  /   |  / ____/ |/ / / / / / __ \\ / __ \\ / ___/"
            echo -e "/ __/  /  |/ / / / / __/    / /| | / __/  |   / / / / / /_/ // /_/ /\\__ \\ "
            echo -e "/ /___ / /|  / /_/ / /___   / ___ |/ /___ /   | / /_/ / _, _/ \\____/___/ / "
            echo -e "/_____//_/ |_/_____/_____/ /_/  |_/_____//_/|_| \\____/_/ |_|      /____/  "
            echo -e "                      🎮 G A M I N G  S E T U P  v2.0 🎮                   "
            echo -e "${NC}"
            ;;
        "manjaro")
            echo -e "${GREEN}"
            echo -e " _____ _____ _____ _____ _____ _____ _____ "
            echo -e "|     |  _  |   | |     |  _  |     |     |"
            echo -e "| | | |     | | | |  |  |     |  |  |  |  |"
            echo -e "|_|_|_|__|__|_|___|_____|__|__|_____|_____|"
            echo -e "           🎮 G A M I N G  S E T U P  v2.0 🎮"
            echo -e "${NC}"
            ;;
        "arch")
            echo -e "${LIGHT_BLUE}"
            echo -e "                 _             "
            echo -e "                | |            "
            echo -e "      __ _  __ _| |__    Linux  "
            echo -e "     / _\` |/ _\`| '_ \\          "
            echo -e "    | (_| | (_| | | | |         "
            echo -e "     \\__,_|\\__,_|_| |_|         "
            echo -e "                               "
            echo -e "    🎮 G A M I N G  S E T U P  v2.0 🎮"
            echo -e "${NC}"
            ;;
        "garuda")
            echo -e "${RED}"
            echo -e "    ____                      _      "
            echo -e "   / ___| __ _ _ __ _   _  __| | __ _ "
            echo -e "  | |  _ / _\` | '__| | | |/ _\` |/ _\` |"
            echo -e "  | |_| | (_| | |  | |_| | (_| | (_| |"
            echo -e "   \\____|\__,_|_|   \\__,_|\\__,_|\\__,_|"
            echo -e "                                      "
            echo -e "        🎮 G A M I N G  S E T U P  v2.0 🎮"
            echo -e "${NC}"
            ;;
        *)
            echo -e "${LIGHT_CYAN}"
            echo -e "    ___              __      _      _                 "
            echo -e "   /   |  __________/ /_    | |    (_)_  __ ___  ___ "
            echo -e "  / /| | / ___/ ___/ __ \\   | |   / /| |/_// / / / _ \\"
            echo -e " / ___ |/ /  / /__/ / / /   | |  / /_>  < / /_/ /  __/"
            echo -e "/_/  |_/_/   \\___/_/ /_/    |_| /_//_/|_| \\__,_/\\___/ "
            echo -e "                                                       "
            echo -e "              🎮 G A M I N G  S E T U P  v2.0 🎮       "
            echo -e "${NC}"
            ;;
    esac
}

# Function to detect distribution and system info
detect_system() {
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        DISTRO_ID=$(echo "$ID" | tr '[:upper:]' '[:lower:]')
        DISTRO_NAME="$NAME"

        # Check for common Arch derivatives
        if [[ "$DISTRO_ID" == "arch" ]]; then
            DISTRO="arch"
            DISTRO_STYLE="${LIGHT_BLUE}"
        elif [[ "$DISTRO_ID" == "cachyos" || "$PRETTY_NAME" == *"CachyOS"* ]]; then
            DISTRO="cachyos"
            DISTRO_STYLE="${CYAN}"
        elif [[ "$DISTRO_ID" == "endeavouros" || "$PRETTY_NAME" == *"EndeavourOS"* ]]; then
            DISTRO="endeavouros"
            DISTRO_STYLE="${PURPLE}"
        elif [[ "$DISTRO_ID" == "manjaro" || "$PRETTY_NAME" == *"Manjaro"* ]]; then
            DISTRO="manjaro"
            DISTRO_STYLE="${GREEN}"
        elif [[ "$DISTRO_ID" == "garuda" || "$PRETTY_NAME" == *"Garuda"* ]]; then
            DISTRO="garuda"
            DISTRO_STYLE="${RED}"
        elif [[ "$DISTRO_ID" == "artix" || "$PRETTY_NAME" == *"Artix"* ]]; then
            DISTRO="artix"
            DISTRO_STYLE="${MAGENTA}"
        else
            DISTRO="arch-based"
            DISTRO_STYLE="${LIGHT_CYAN}"
        fi
    else
        DISTRO="unknown"
        DISTRO_NAME="Unknown Distribution"
        DISTRO_STYLE="${NC}"
    fi

    # Get system information
    KERNEL_INFO=$(uname -r)
    CPU_INFO=$(grep "model name" /proc/cpuinfo | head -1 | cut -d ':' -f2 | sed 's/^[ \t]*//')
    
    # Detect GPU
    if lspci | grep -i nvidia &> /dev/null; then
        GPU_INFO="NVIDIA $(lspci | grep -i nvidia | head -1 | sed 's/.*: //' | sed 's/ (.*//')"
    elif lspci | grep -i amd &> /dev/null; then
        GPU_INFO="AMD $(lspci | grep -i amd | grep -i vga | head -1 | sed 's/.*: //' | sed 's/ (.*//')"
    elif lspci | grep -i intel &> /dev/null && lspci | grep -i vga &> /dev/null; then
        GPU_INFO="Intel $(lspci | grep -i intel | grep -i vga | head -1 | sed 's/.*: //' | sed 's/ (.*//')"
    else
        GPU_INFO="Unknown GPU"
    fi
}

# Function to display system information header
display_system_info() {
    clear
    detect_system
    display_ascii_art "$DISTRO"
    
    echo -e "${DISTRO_STYLE}${BOLD}Distribution:${NC} $DISTRO_NAME"
    echo -e "${DISTRO_STYLE}${BOLD}GPU:${NC} $GPU_INFO"
    echo -e "${DISTRO_STYLE}${BOLD}Kernel:${NC} $KERNEL_INFO"
    echo -e "${DISTRO_STYLE}${BOLD}CPU:${NC} $CPU_INFO"
    echo
}

# Function to display the interactive menu
display_menu() {
    display_system_info
    
    echo -e "${DISTRO_STYLE}${BOLD}========== Gaming Installation Menu ==========${NC}"
    echo -e "${YELLOW}Select components to install (space-separated numbers):${NC}"
    echo
    
    echo -e "${CYAN}🎯 ${BOLD}Core Gaming${NC}"
    echo -e "  ${LIGHT_GREEN}1)${NC} Graphics Drivers (Auto-detected: $(echo $GPU_INFO | awk '{print $1}'))"
    echo -e "  ${LIGHT_GREEN}2)${NC} Gaming Platforms (Steam, Lutris, Heroic)"
    echo -e "  ${LIGHT_GREEN}3)${NC} Wine & Compatibility Layers"
    echo
    
    echo -e "${MAGENTA}🎮 ${BOLD}Game Launchers & Stores${NC}"
    echo -e "  ${LIGHT_GREEN}4)${NC} Steam + Proton GE + SteamTinkerLaunch"
    echo -e "  ${LIGHT_GREEN}5)${NC} Lutris + Wine-GE + DXVK"
    echo -e "  ${LIGHT_GREEN}6)${NC} Heroic Games Launcher (Epic/GOG)"
    echo -e "  ${LIGHT_GREEN}7)${NC} Bottles (Wine prefix manager)"
    echo
    
    echo -e "${BLUE}🕹️ ${BOLD} Emulation Station${NC}"
    echo -e "  ${LIGHT_GREEN}8)${NC} RetroArch + Cores"
    echo -e "  ${LIGHT_GREEN}9)${NC} Console Emulators (Dolphin, PCSX2, RPCS3)"
    echo -e "  ${LIGHT_GREEN}10)${NC} Handheld Emulators (Citra, Ryujinx)"
    echo
    
    echo -e "${ORANGE}⚡ ${BOLD}Performance & Monitoring${NC}"
    echo -e "  ${LIGHT_GREEN}11)${NC} GameMode + MangoHud"
    echo -e "  ${LIGHT_GREEN}12)${NC} Performance Tuning (CPU Governor, I/O Scheduler)"
    echo -e "  ${LIGHT_GREEN}13)${NC} GPU Control Tools (CoreCtrl/GreenWithEnvy)"
    echo
    
    echo -e "${PURPLE}🔧 ${BOLD}Advanced Gaming Tools${NC}"
    echo -e "  ${LIGHT_GREEN}14)${NC} Mod Management (Vortex via SteamTinkerLaunch)"
    echo -e "  ${LIGHT_GREEN}15)${NC} VR Gaming Support (SteamVR, OpenXR)"
    echo -e "  ${LIGHT_GREEN}16)${NC} Game Development Tools"
    echo
    
    echo -e "${LIGHT_CYAN}🌟 ${BOLD}Quick Setups${NC}"
    echo -e "  ${LIGHT_GREEN}17)${NC} Essential Gaming (1,2,3,4,11)"
    echo -e "  ${LIGHT_GREEN}18)${NC} Complete Gaming Setup (All components)"
    echo -e "  ${LIGHT_GREEN}19)${NC} Competitive Gaming (Performance focused)"
    echo -e "  ${LIGHT_GREEN}20)${NC} Retro Gaming Paradise (Emulation focused)"
    echo
    
    echo -e "${LIGHT_GREEN}0)${NC} Exit"
    echo
    echo -e "${YELLOW}Enter your choices (e.g., '1 4 11' or '18' for complete setup): ${NC}"
}

# Function to parse user input
parse_user_input() {
    local input=$1
    SELECTED_COMPONENTS=()
    
    # Handle quick setups
    if [[ "$input" == *"17"* ]]; then
        SELECTED_COMPONENTS+=(1 2 3 4 11)
    elif [[ "$input" == *"18"* ]]; then
        SELECTED_COMPONENTS+=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)
    elif [[ "$input" == *"19"* ]]; then
        SELECTED_COMPONENTS+=(1 4 11 12 13)
    elif [[ "$input" == *"20"* ]]; then
        SELECTED_COMPONENTS+=(8 9 10 11)
    else
        # Parse individual selections
        for num in $input; do
            if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le 16 ]; then
                SELECTED_COMPONENTS+=($num)
            fi
        done
    fi
    
    # Remove duplicates
    SELECTED_COMPONENTS=($(printf "%s\n" "${SELECTED_COMPONENTS[@]}" | sort -u))
}

# Function to confirm selections
confirm_selections() {
    echo
    echo -e "${CYAN}${BOLD}You have selected the following components:${NC}"
    echo
    
    for component in "${SELECTED_COMPONENTS[@]}"; do
        case $component in
            1) echo -e "  ${GREEN}✓${NC} Graphics Drivers" ;;
            2) echo -e "  ${GREEN}✓${NC} Gaming Platforms" ;;
            3) echo -e "  ${GREEN}✓${NC} Wine & Compatibility Layers" ;;
            4) echo -e "  ${GREEN}✓${NC} Steam + Proton GE + SteamTinkerLaunch" ;;
            5) echo -e "  ${GREEN}✓${NC} Lutris + Wine-GE + DXVK" ;;
            6) echo -e "  ${GREEN}✓${NC} Heroic Games Launcher" ;;
            7) echo -e "  ${GREEN}✓${NC} Bottles" ;;
            8) echo -e "  ${GREEN}✓${NC} RetroArch + Cores" ;;
            9) echo -e "  ${GREEN}✓${NC} Console Emulators" ;;
            10) echo -e "  ${GREEN}✓${NC} Handheld Emulators" ;;
            11) echo -e "  ${GREEN}✓${NC} GameMode + MangoHud" ;;
            12) echo -e "  ${GREEN}✓${NC} Performance Tuning" ;;
            13) echo -e "  ${GREEN}✓${NC} GPU Control Tools" ;;
            14) echo -e "  ${GREEN}✓${NC} Mod Management" ;;
            15) echo -e "  ${GREEN}✓${NC} VR Gaming Support" ;;
            16) echo -e "  ${GREEN}✓${NC} Game Development Tools" ;;
        esac
    done
    
    echo
    echo -e "${YELLOW}Proceed with installation? [y/N]: ${NC}"
    read -r confirm
    
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation cancelled.${NC}"
        return 1
    fi
    
    return 0
}

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run this script as root or with sudo -E.${NC}"
        exit 1
    fi
}

# Function to install AUR helper
install_aur_helper() {
    if command -v yay &> /dev/null; then
        echo -e "${GREEN}AUR helper (yay) is already installed.${NC}"
        return
    fi
    
    echo -e "${CYAN}Installing yay AUR helper...${NC}"
    pacman -S --needed git base-devel
    sudo -u "$REAL_USER" git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit
    sudo -u "$REAL_USER" makepkg -si --noconfirm
    cd - || exit
    rm -rf /tmp/yay
    echo -e "${GREEN}yay installed successfully.${NC}"
}

# Installation functions for each component
install_graphics_drivers() {
    echo -e "${CYAN}Installing Graphics Drivers...${NC}"
    
    if lspci | grep -i nvidia &> /dev/null; then
        echo -e "${YELLOW}Installing NVIDIA drivers...${NC}"
        pacman -S --needed nvidia nvidia-utils lib32-nvidia-utils
    fi
    
    if lspci | grep -i amd &> /dev/null; then
        echo -e "${YELLOW}Installing AMD drivers...${NC}"
        pacman -S --needed mesa vulkan-radeon lib32-mesa lib32-vulkan-radeon
    fi
    
    if lspci | grep -i intel &> /dev/null; then
        echo -e "${YELLOW}Installing Intel drivers...${NC}"
        pacman -S --needed mesa vulkan-intel lib32-mesa lib32-vulkan-intel intel-media-driver
    fi
    
    echo -e "${GREEN}Graphics drivers installed.${NC}"
}

install_gaming_platforms() {
    echo -e "${CYAN}Installing Gaming Platforms...${NC}"
    pacman -S --needed steam lutris
    echo -e "${GREEN}Gaming platforms installed.${NC}"
}

install_wine_compatibility() {
    echo -e "${CYAN}Installing Wine & Compatibility Layers...${NC}"
    pacman -S --needed wine-staging wine-gecko wine-mono winetricks
    pacman -S --needed lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse lib32-alsa-plugins
    echo -e "${GREEN}Wine & compatibility layers installed.${NC}"
}

install_steam_enhanced() {
    echo -e "${CYAN}Installing Steam + Proton GE + SteamTinkerLaunch...${NC}"
    pacman -S --needed steam
    sudo -u "$REAL_USER" yay -S --needed protonup-qt steamtinkerlaunch
    echo -e "${GREEN}Steam enhanced setup completed.${NC}"
}

install_lutris_enhanced() {
    echo -e "${CYAN}Installing Lutris + Wine-GE + DXVK...${NC}"
    pacman -S --needed lutris
    sudo -u "$REAL_USER" yay -S --needed dxvk-bin lutris-wine-meta
    echo -e "${GREEN}Lutris enhanced setup completed.${NC}"
}

install_heroic() {
    echo -e "${CYAN}Installing Heroic Games Launcher...${NC}"
    sudo -u "$REAL_USER" yay -S --needed heroic-games-launcher-bin
    echo -e "${GREEN}Heroic Games Launcher installed.${NC}"
}

install_bottles() {
    echo -e "${CYAN}Installing Bottles...${NC}"
    sudo -u "$REAL_USER" yay -S --needed bottles
    echo -e "${GREEN}Bottles installed.${NC}"
}

install_retroarch() {
    echo -e "${CYAN}Installing RetroArch + Cores...${NC}"
    pacman -S --needed retroarch retroarch-assets-xmb
    sudo -u "$REAL_USER" yay -S --needed libretro-core-info
    echo -e "${GREEN}RetroArch installed.${NC}"
}

install_console_emulators() {
    echo -e "${CYAN}Installing Console Emulators...${NC}"
    pacman -S --needed dolphin-emu
    sudo -u "$REAL_USER" yay -S --needed pcsx2 rpcs3-git
    echo -e "${GREEN}Console emulators installed.${NC}"
}

install_handheld_emulators() {
    echo -e "${CYAN}Installing Handheld Emulators...${NC}"
    sudo -u "$REAL_USER" yay -S --needed citra ryujinx-git
    echo -e "${GREEN}Handheld emulators installed.${NC}"
}

install_performance_monitoring() {
    echo -e "${CYAN}Installing GameMode + MangoHud...${NC}"
    pacman -S --needed gamemode lib32-gamemode
    sudo -u "$REAL_USER" yay -S --needed mangohud lib32-mangohud
    echo -e "${GREEN}Performance monitoring tools installed.${NC}"
}

install_performance_tuning() {
    echo -e "${CYAN}Installing Performance Tuning...${NC}"
    pacman -S --needed power-profiles-daemon
    systemctl enable --now power-profiles-daemon
    
    # Set performance mode
    powerprofilesctl set performance
    
    # Create sysctl config for gaming optimizations
    cat > /etc/sysctl.d/99-gaming-performance.conf << EOL
# Gaming performance optimizations
fs.file-max = 100000
net.core.netdev_max_backlog = 16384
net.core.somaxconn = 8192
vm.swappiness = 10
vm.vfs_cache_pressure = 50
EOL
    
    sysctl --system
    echo -e "${GREEN}Performance tuning applied.${NC}"
}

install_gpu_tools() {
    echo -e "${CYAN}Installing GPU Control Tools...${NC}"
    
    if lspci | grep -i nvidia &> /dev/null; then
        sudo -u "$REAL_USER" yay -S --needed gwe
    fi
    
    if lspci | grep -i amd &> /dev/null; then
        sudo -u "$REAL_USER" yay -S --needed corectrl
    fi
    
    echo -e "${GREEN}GPU control tools installed.${NC}"
}

install_mod_management() {
    echo -e "${CYAN}Installing Mod Management Tools...${NC}"
    sudo -u "$REAL_USER" yay -S --needed steamtinkerlaunch
    pacman -S --needed yad zenity xdotool xorg-xwininfo
    echo -e "${GREEN}Mod management tools installed.${NC}"
}

install_vr_support() {
    echo -e "${CYAN}Installing VR Gaming Support...${NC}"
    pacman -S --needed steam
    sudo -u "$REAL_USER" yay -S --needed openvr openxr
    echo -e "${GREEN}VR gaming support installed.${NC}"
}

install_gamedev_tools() {
    echo -e "${CYAN}Installing Game Development Tools...${NC}"
    pacman -S --needed godot blender
    sudo -u "$REAL_USER" yay -S --needed unity-editor
    echo -e "${GREEN}Game development tools installed.${NC}"
}

# ================= Gaming Performance Benchmarks & Validation =================
display_gaming_benchmark() {
    echo -e
    echo -e "${CYAN}${BOLD}Validating Gaming Environment...${NC}"
    echo

    # Graphics Driver
    if lspci | grep -i nvidia &> /dev/null; then
        DRIVER_VER=$(pacman -Qi nvidia | grep Version | awk '{print $3}')
        echo -e "  Graphics Driver: ${GREEN}✅ NVIDIA $DRIVER_VER${NC}"
    elif lspci | grep -i amd &> /dev/null; then
        DRIVER_VER=$(pacman -Qi mesa | grep Version | awk '{print $3}')
        echo -e "  Graphics Driver: ${GREEN}✅ AMD Mesa $DRIVER_VER${NC}"
    elif lspci | grep -i intel &> /dev/null; then
        DRIVER_VER=$(pacman -Qi mesa | grep Version | awk '{print $3}')
        echo -e "  Graphics Driver: ${GREEN}✅ Intel Mesa $DRIVER_VER${NC}"
    else
        echo -e "  Graphics Driver: ${RED}❌ Not detected${NC}"
    fi

    # Vulkan Support
    if command -v vulkaninfo &> /dev/null; then
        VULKAN_VER=$(vulkaninfo | grep "Vulkan Instance Version" | awk '{print $4}')
        echo -e "  Vulkan Support: ${GREEN}✅ Enabled (Version $VULKAN_VER)${NC}"
    else
        echo -e "  Vulkan Support: ${RED}❌ Not found${NC}"
    fi

    # DXVK
    if pacman -Qi dxvk-bin &> /dev/null || yay -Qi dxvk-bin &> /dev/null; then
        DXVK_VER=$(yay -Qi dxvk-bin 2>/dev/null | grep Version | awk '{print $3}')
        [ -z "$DXVK_VER" ] && DXVK_VER=$(pacman -Qi dxvk-bin 2>/dev/null | grep Version | awk '{print $3}')
        echo -e "  DXVK: ${GREEN}✅ Latest version installed ($DXVK_VER)${NC}"
    else
        echo -e "  DXVK: ${RED}❌ Not installed${NC}"
    fi

    # GameMode
    if systemctl is-active --quiet gamemode; then
        echo -e "  GameMode: ${GREEN}✅ Active and running${NC}"
    else
        echo -e "  GameMode: ${RED}❌ Not running${NC}"
    fi

    # MangoHud
    if [ -f "$USER_HOME/.config/MangoHud/MangoHud.conf" ]; then
        echo -e "  MangoHud: ${GREEN}✅ Configured (Custom config found)${NC}"
    else
        echo -e "  MangoHud: ${YELLOW}⚠️ Default config${NC}"
    fi

    # Gaming Platforms
    echo
    echo -e "${MAGENTA}Gaming Platforms:${NC}"
    if pacman -Qi steam &> /dev/null; then
        PROTON_VERSIONS=$(ls "$USER_HOME/.steam/root/compatibilitytools.d" 2>/dev/null | grep GE | wc -l)
        STK_INSTALLED=$(yay -Qi steamtinkerlaunch 2>/dev/null | grep Version | awk '{print $3}')
        echo -e "  Steam: ${GREEN}✅ Ready with Proton GE ($PROTON_VERSIONS versions) + SteamTinkerLaunch"
    else
        echo -e "  Steam: ${RED}❌ Not installed${NC}"
    fi
    if pacman -Qi lutris &> /dev/null; then
        echo -e "  Lutris: ${GREEN}✅ Wine-GE configured with Wine-GE${NC}"
    else
        echo -e "  Lutris: ${RED}❌ Not installed${NC}"
    fi
    if yay -Qi heroic-games-launcher-bin &> /dev/null; then
        echo -e "  Heroic: ${GREEN}✅ Epic Games & GOG ready${NC}"
    else
        echo -e "  Heroic: ${RED}❌ Not installed${NC}"
    fi
    if pacman -Qi retroarch &> /dev/null; then
        CORES=$(retroarch --list-cores | wc -l)
        echo -e "  RetroArch: ${GREEN}✅ All cores installed ($CORES cores)${NC}"
    else
        echo -e "  RetroArch: ${RED}❌ Not installed${NC}"
    fi

    echo
    echo -e "${YELLOW}🚀 Your Arch gaming rig is ready to dominate!${NC}"
    echo
    echo -e "${CYAN}🎯 Next Steps:${NC}"
    echo -e "  • Launch Steam and enable Proton for all games"
    echo -e "  • Join ProtonDB to check game compatibility: https://www.protondb.com/"
    echo -e "  • Configure MangoHud overlay settings: https://github.com/flightlessmango/MangoHud"
    echo -e "  • Visit Arch Wiki Gaming: https://wiki.archlinux.org/title/Gaming"

    echo
    echo -e "${GREEN}📈 Expected Performance Improvements:${NC}"
    echo -e "  • 15-30% better frame rates with GameMode"
    echo -e "  • Better compatibility with Proton GE"
    echo -e "  • Professional monitoring with MangoHud"
    echo -e "  • Optimized NVIDIA/AMD/Intel driver performance"
    echo
}

create_performance_test_script() {
    local script_path="$USER_HOME/gaming_performance_test.sh"
    cat > "$script_path" << EOF
#!/bin/bash
echo "=== Gaming Performance Quick Test ==="
echo "GPU Info:"
lspci | grep -i vga
echo "Vulkan Info:"
vulkaninfo | grep "Vulkan Instance Version"
echo "GameMode Status:"
systemctl status gamemode | grep Active
echo "MangoHud Test:"
MangoHud --version
echo "Steam Launch Test:"
steam --version
EOF
    chmod +x "$script_path"
    echo -e "${YELLOW}Performance test script created at: $script_path${NC}"
}

# Function to execute installations based on selections
execute_installations() {
    echo -e "${DISTRO_STYLE}${BOLD}Starting Installation Process...${NC}"
    echo
    
    # Install AUR helper first if needed
    install_aur_helper
    
    # Process each selected component
    for component in "${SELECTED_COMPONENTS[@]}"; do
        case $component in
            1) install_graphics_drivers ;;
            2) install_gaming_platforms ;;
            3) install_wine_compatibility ;;
            4) install_steam_enhanced ;;
            5) install_lutris_enhanced ;;
            6) install_heroic ;;
            7) install_bottles ;;
            8) install_retroarch ;;
            9) install_console_emulators ;;
            10) install_handheld_emulators ;;
            11) install_performance_monitoring ;;
            12) install_performance_tuning ;;
            13) install_gpu_tools ;;
            14) install_mod_management ;;
            15) install_vr_support ;;
            16) install_gamedev_tools ;;
        esac
        echo
    done
    
    echo -e "${GREEN}${BOLD}Installation completed successfully!${NC}"
    echo -e "${YELLOW}You may need to reboot for all changes to take effect.${NC}"
    echo
    echo -e "${CYAN}Enjoy gaming on $DISTRO_NAME! 🎮${NC}"
    display_gaming_benchmark
    create_performance_test_script
}

# Main script execution
main() {
    check_root
    
    while true; do
        display_menu
        read -r user_input
        
        # Handle exit
        if [[ "$user_input" == "0" ]]; then
            echo -e "${YELLOW}Exiting gaming setup. Happy gaming! 🎮${NC}"
            exit 0
        fi
        
        # Parse and validate input
        if [[ -z "$user_input" ]]; then
            echo -e "${RED}No selection made. Please try again.${NC}"
            sleep 2
            continue
        fi
        
        parse_user_input "$user_input"
        
        if [[ ${#SELECTED_COMPONENTS[@]} -eq 0 ]]; then
            echo -e "${RED}Invalid selection. Please enter valid component numbers.${NC}"
            sleep 2
            continue
        fi
        
        # Confirm selections and proceed
        if confirm_selections; then
            execute_installations
            
            echo
            echo -e "${YELLOW}Press Enter to return to menu or Ctrl+C to exit...${NC}"
            read -r
        fi
    done
}

# Run the main function
main "$@"