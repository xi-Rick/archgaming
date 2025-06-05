#!/bin/bash

# Arch Gaming Setup Script
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
            echo -e "                        G A M I N G  S E T U P                                             "
            echo -e "${NC}"
            ;;
        "endeavouros")
            echo -e "${PURPLE}"
            echo -e "  ______  _   _____  ______   ___    _______  __  __  ______   ____   _____"
            echo -e " / ____// | / / __ \\/ ____/  /   |  / ____/ |/ / / / / / __ \\ / __ \\ / ___/"
            echo -e "/ __/  /  |/ / / / / __/    / /| | / __/  |   / / / / / /_/ // /_/ /\\__ \\ "
            echo -e "/ /___ / /|  / /_/ / /___   / ___ |/ /___ /   | / /_/ / _, _/ \\____/___/ / "
            echo -e "/_____//_/ |_/_____/_____/ /_/  |_/_____//_/|_| \\____/_/ |_|      /____/  "
            echo -e "                      G A M I N G  S E T U P                               "
            echo -e "${NC}"
            ;;
        "manjaro")
            echo -e "${GREEN}"
            echo -e " _____ _____ _____ _____ _____ _____ _____ "
            echo -e "|     |  _  |   | |     |  _  |     |     |"
            echo -e "| | | |     | | | |  |  |     |  |  |  |  |"
            echo -e "|_|_|_|__|__|_|___|_____|__|__|_____|_____|"
            echo -e "           G A M I N G  S E T U P          "
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
            echo -e "    G A M I N G  S E T U P     "
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
            echo -e "        G A M I N G  S E T U P        "
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
            echo -e "              G A M I N G  S E T U P                   "
            echo -e "${NC}"
            ;;
    esac
}

# Function to detect distribution
detect_distribution() {
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
            # For any other Arch-based distro
            DISTRO="arch-based"
            DISTRO_STYLE="${LIGHT_CYAN}"
        fi
    else
        DISTRO="unknown"
        DISTRO_NAME="Unknown Distribution"
        DISTRO_STYLE="${NC}"
    fi
}

# Function to check if running as root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "${RED}Please run this script as root or with sudo -E.${NC}"
        exit 1
    fi
}

# Function to pause script execution and wait for user input
pause() {
    echo
    echo -e "${YELLOW}Press Enter to continue...${NC}"
    read -r
}

# Function to confirm action
confirm_action() {
    local message=$1
    local default_answer=${2:-"n"}

    echo -e "${CYAN}$message [y/n] (default: $default_answer)${NC}"
    read -r choice

    if [[ -z "$choice" ]]; then
        choice="$default_answer"
    fi

    if [[ "$choice" =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

# Function to display header with detected distro
display_header() {
    clear
    detect_distribution
    display_ascii_art "$DISTRO"

    echo -e "${DISTRO_STYLE}============================================${NC}"
    echo -e "${DISTRO_STYLE}${BOLD}     $DISTRO_NAME Gaming Setup Script${NC}"
    echo -e "${DISTRO_STYLE}============================================${NC}"
    echo -e "${YELLOW}This script will help you set up your $DISTRO_NAME system for gaming.${NC}"
    echo
    pause
}

# Function to check system info
check_system_info() {
    echo -e "${DISTRO_STYLE}Checking system information...${NC}"
    echo -e "${MAGENTA}Distribution:${NC} $DISTRO_NAME"
    echo -e "${MAGENTA}Kernel version:${NC} $(uname -r)"
    echo -e "${MAGENTA}CPU:${NC} $(grep "model name" /proc/cpuinfo | head -1 | cut -d ':' -f2 | sed 's/^[ \t]*//')"

    echo -e "${MAGENTA}GPU information:${NC}"
    lspci | grep -E 'VGA|3D|Display' | sed 's/^/  /'

    echo -e "${MAGENTA}Installed graphics drivers:${NC}"
    pacman -Q | grep -E 'nvidia|mesa|amdgpu|intel-media-driver|xf86-video' | sed 's/^/  /'
    echo

    # Display distribution-specific info
    case "$DISTRO" in
        "cachyos")
            echo -e "${CYAN}CachyOS-specific information:${NC}"
            echo -e "  - Kernel type: $(uname -r | grep -o "cachyos\|linux")"
            echo -e "  - Scheduler: $(cat /sys/block/$(lsblk -d | grep -o "sd[a-z]\|nvme[0-9]n[0-9]" | head -1)/queue/scheduler | tr -d '[]')"
            ;;
        "manjaro")
            echo -e "${GREEN}Manjaro-specific information:${NC}"
            echo -e "  - Branch: $(pacman-mirrors -G 2>/dev/null || echo "Unknown")"
            ;;
        "garuda")
            echo -e "${RED}Garuda-specific information:${NC}"
            echo -e "  - Edition: $(grep "EDITION" /etc/garuda/garuda-release 2>/dev/null || echo "Unknown")"
            ;;
    esac

    pause
}

# Function to update system based on detected distro
update_system() {
    if confirm_action "Would you like to update your system before proceeding?"; then
        echo -e "${DISTRO_STYLE}Updating system...${NC}"

        case "$DISTRO" in
            "manjaro")
                pacman -Syyu 
                ;;
            "garuda")
                garuda-update || pacman -Syyu 
                ;;
            *)
                # Default for Arch and other Arch-based distros
                pacman -Syu 
                ;;
        esac

        echo -e "${GREEN}System update completed.${NC}"
        pause
    fi
}

# Function to install AUR helper based on detected distro
install_aur_helper() {
    local aur_helper="yay"

    # Some distros might prefer different AUR helpers
    case "$DISTRO" in
        "garuda"|"endeavouros")
            # These distros have yay pre-installed, but let's check anyway
            if command -v yay &> /dev/null; then
                echo -e "${GREEN}AUR helper (yay) is already installed.${NC}"
                return
            fi
            ;;
        "manjaro")
            if command -v pamac &> /dev/null; then
                echo -e "${GREEN}AUR helper (pamac) is already installed.${NC}"
                aur_helper="pamac"
                return
            elif command -v yay &> /dev/null; then
                echo -e "${GREEN}AUR helper (yay) is already installed.${NC}"
                return
            fi
            ;;
        *)
            if command -v yay &> /dev/null; then
                echo -e "${GREEN}AUR helper (yay) is already installed.${NC}"
                return
            elif command -v paru &> /dev/null; then
                echo -e "${GREEN}AUR helper (paru) is already installed.${NC}"
                aur_helper="paru"
                return
            fi
            ;;
    esac

    # Install yay if no AUR helper is installed
    echo -e "${YELLOW}Installing yay AUR helper...${NC}"
    pacman -S --needed  git base-devel
    sudo -u "$REAL_USER" git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay || exit
    sudo -u "$REAL_USER" makepkg -si 
    cd - || exit
    rm -rf /tmp/yay
    echo -e "${GREEN}yay installed successfully.${NC}"
    pause
}

# Function to install graphics drivers
install_graphics_drivers() {
    echo -e "${DISTRO_STYLE}Detecting graphics hardware for driver installation...${NC}"

    if lspci | grep -i nvidia &> /dev/null; then
        echo -e "${YELLOW}NVIDIA GPU detected.${NC}"
        if confirm_action "Would you like to install/update NVIDIA drivers?"; then
            echo -e "${GREEN}Installing NVIDIA drivers...${NC}"

            case "$DISTRO" in
                "manjaro")
                    # Manjaro uses its own driver manager
                    pacman -S --needed  manjaro-settings-manager
                    echo -e "${YELLOW}Please use Manjaro Settings Manager > Hardware Configuration to install the proper NVIDIA drivers.${NC}"
                    echo -e "${YELLOW}Alternatively, we can install them now. Continuing with installation...${NC}"
                    pacman -S --needed  nvidia-utils lib32-nvidia-utils nvidia
                    ;;
                "garuda")
                    # Garuda might use their own nvidia installer
                    pacman -S --needed  nvidia-dkms nvidia-utils lib32-nvidia-utils
                    ;;
                *)
                    # Default for most Arch-based distributions
                    pacman -S --needed  nvidia-dkms nvidia-utils lib32-nvidia-utils
                    ;;
            esac

            echo -e "${GREEN}NVIDIA drivers installed.${NC}"
        fi
    fi

    if lspci | grep -i amd &> /dev/null; then
        echo -e "${YELLOW}AMD GPU detected.${NC}"
        if confirm_action "Would you like to install/update AMD drivers?"; then
            echo -e "${GREEN}Installing AMD drivers...${NC}"

            case "$DISTRO" in
                "manjaro")
                    pacman -S --needed  mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon xf86-video-amdgpu
                    ;;
                *)
                    pacman -S --needed  mesa vulkan-radeon lib32-mesa lib32-vulkan-radeon
                    ;;
            esac

            echo -e "${GREEN}AMD drivers installed.${NC}"
        fi
    fi

    if lspci | grep -i intel &> /dev/null; then
        echo -e "${YELLOW}Intel GPU detected.${NC}"
        if confirm_action "Would you like to install/update Intel drivers?"; then
            echo -e "${GREEN}Installing Intel drivers...${NC}"
            pacman -S --needed  mesa vulkan-intel lib32-mesa lib32-vulkan-intel intel-media-driver
            echo -e "${GREEN}Intel drivers installed.${NC}"
        fi
    fi

    echo -e "${GREEN}Graphics driver installation completed.${NC}"
    pause
}

# Function to install gaming meta packages based on distribution
install_gaming_meta_packages() {
    echo -e "${DISTRO_STYLE}Installing gaming meta packages for $DISTRO_NAME...${NC}"

    case "$DISTRO" in
        "cachyos")
            if confirm_action "Would you like to install CachyOS gaming meta packages?"; then
                pacman -S --needed  cachyos-gaming-meta cachyos-gaming-applications
                echo -e "${GREEN}CachyOS gaming packages installed successfully.${NC}"
            fi
            ;;
        "garuda")
            if confirm_action "Would you like to install Garuda gaming packages?"; then
                pacman -S --needed  garuda-gaming
                echo -e "${GREEN}Garuda gaming packages installed successfully.${NC}"
            fi
            ;;
        "manjaro")
            if confirm_action "Would you like to install gaming packages?"; then
                pacman -S --needed  steam lutris wine-staging gamemode lib32-gamemode
                echo -e "${GREEN}Gaming packages installed successfully.${NC}"
            fi
            ;;
        "endeavouros")
            if confirm_action "Would you like to install gaming packages?"; then
                pacman -S --needed  steam lutris wine-staging gamemode lib32-gamemode
                echo -e "${GREEN}Gaming packages installed successfully.${NC}"
            fi
            ;;
        *)
            # Default for Arch and other derivatives
            if confirm_action "Would you like to install basic gaming packages?"; then
                pacman -S --needed  steam lutris wine-staging gamemode lib32-gamemode
                echo -e "${GREEN}Basic gaming packages installed successfully.${NC}"
            fi
            ;;
    esac

    pause
}

# Function to prompt user for installation
prompt_installation() {
    local package_name=$1
    local prompt_message=$2
    local install_command=$3

    if confirm_action "$prompt_message"; then
        echo -e "${GREEN}Installing $package_name...${NC}"
        eval "$install_command"
        echo -e "${GREEN}$package_name installation completed.${NC}"
        pause
    else
        echo -e "${YELLOW}$package_name installation skipped.${NC}"
    fi
}

# Function to install gaming platforms
install_gaming_platforms() {
    echo -e "${DISTRO_STYLE}Setting up gaming platforms...${NC}"
    pause

    # Steam (if not already installed through meta packages)
    if ! pacman -Q steam &> /dev/null; then
        prompt_installation "Steam" "Install Steam?" "pacman -S --needed  steam"
    else
        echo -e "${GREEN}Steam is already installed.${NC}"
    fi

    # Lutris (if not already installed through meta packages)
    if ! pacman -Q lutris &> /dev/null; then
        prompt_installation "Lutris" "Install Lutris?" "pacman -S --needed  lutris"
    else
        echo -e "${GREEN}Lutris is already installed.${NC}"
    fi

    # Heroic Games Launcher
    prompt_installation "Heroic Games Launcher" "Install Heroic Games Launcher (Epic Games & GOG)?" "sudo -u \"$REAL_USER\" yay -S --needed  heroic-games-launcher-bin"

    # Steam Tinker Launch block
    if confirm_action "Install Steam Tinker Launch?"; then
        echo -e "${GREEN}Installing Steam Tinker Launch from AUR...${NC}"
        sudo -u "$REAL_USER" yay -S --needed  steamtinkerlaunch-git

        echo -e "${GREEN}Installing Steam Tinker Launch dependencies...${NC}"
        pacman -S --needed  yad zenity xdotool xorg-xwininfo

        # Ensure Steam is running and loaded
        echo -e "${GREEN}Ensuring Steam is running...${NC}"
        if ! pgrep -x steam > /dev/null; then
            echo -e "${GREEN}Steam not detected, launching Steam...${NC}"
            sudo -u "$REAL_USER" -E env HOME="$USER_HOME" steam &
            echo -e "${GREEN}Waiting for Steam to load...${NC}"
            sleep 30
        else
            echo -e "${GREEN}Steam is already running.${NC}"
        fi

        # Install and launch Vortex via steamtinkerlaunch
        if confirm_action "Install and launch Vortex Mod Manager via Steam Tinker Launch?"; then
            echo -e "${GREEN}Installing Vortex Mod Manager using steamtinkerlaunch...${NC}"
            sudo -u "$REAL_USER" -E env HOME="$USER_HOME" steamtinkerlaunch vortex install
            echo -e "${GREEN}Vortex Mod Manager installation completed.${NC}"
            if confirm_action "Launch Vortex now?"; then
                echo -e "${GREEN}Launching Vortex Mod Manager...${NC}"
                sudo -u "$REAL_USER" -E env HOME="$USER_HOME" steamtinkerlaunch vortex start
                echo -e "${GREEN}Vortex launched successfully.${NC}"
            fi
            pause
        fi

        # Install and launch Mod Organizer via steamtinkerlaunch
        if confirm_action "Install and launch Mod Organizer via Steam Tinker Launch?"; then
            echo -e "${GREEN}Installing Mod Organizer using steamtinkerlaunch...${NC}"
            sudo -u "$REAL_USER" -E env HOME="$USER_HOME" steamtinkerlaunch mo2 start
            echo -e "${GREEN}Mod Organizer installation completed.${NC}"
            if confirm_action "Launch Mod Organizer now?"; then
                echo -e "${GREEN}Launching Mod Organizer...${NC}"
                sudo -u "$REAL_USER" -E env HOME="$USER_HOME" steamtinkerlaunch mo2 start
                echo -e "${GREEN}Mod Organizer launched successfully.${NC}"
            fi
            pause
        fi
    fi

    # Emulation
    if confirm_action "Would you like to install emulation platforms?"; then
        # RetroArch
        prompt_installation "RetroArch" "Install RetroArch (Multi-system emulator)?" "pacman -S --needed  retroarch retroarch-assets-xmb"

        # Cemu (Wii U Emulator)
        prompt_installation "Cemu (Wii U Emulator)" "Install Cemu (Wii U Emulator)?" "sudo -u \"$REAL_USER\" yay -S --needed  cemu-bin"

        # Dolphin (GameCube/Wii Emulator)
        prompt_installation "Dolphin (GameCube/Wii Emulator)" "Install Dolphin (GameCube/Wii Emulator)?" "pacman -S --needed  dolphin-emu"

        # PCSX2 (PS2 Emulator)
        prompt_installation "PCSX2 (PS2 Emulator)" "Install PCSX2 (PS2 Emulator)?" "pacman -S --needed  pcsx2"

        # RPCS3 (PS3 Emulator)
        prompt_installation "RPCS3 (PS3 Emulator)" "Install RPCS3 (PS3 Emulator)?" "sudo -u \"$REAL_USER\" yay -S --needed  rpcs3-git"
    fi

    # ProtonUp-Qt block for Proton GE management
    prompt_installation "ProtonUp-Qt" "Install ProtonUp-Qt for managing Proton GE?" "sudo -u \"$REAL_USER\" yay -S --needed  protonup-qt"

    echo -e "${GREEN}Gaming platform installation completed.${NC}"
    pause
}

# Function to install PlayOnLinux
install_playonlinux() {
    prompt_installation "PlayOnLinux" "Would you like to install PlayOnLinux for managing Windows games?" "sudo -u \"$REAL_USER\" yay -S --needed  playonlinux"
}

# Function to install GameMode
install_gamemode() {
    prompt_installation "GameMode" "Would you like to install GameMode for optimizing game performance?" "pacman -S --needed  gamemode lib32-gamemode"
}

# Function to install DXVK
install_dxvk() {
    prompt_installation "DXVK" "Would you like to install DXVK for improved Direct3D performance?" "sudo -u \"$REAL_USER\" yay -S --needed  dxvk-bin"
}

# Function to install MangoHud
install_mangohud() {
    prompt_installation "MangoHud" "Would you like to install MangoHud for performance monitoring?" "sudo -u \"$REAL_USER\" yay -S --needed  mangohud lib32-mangohud"

    if confirm_action "Would you like to configure MangoHud globally?"; then
        # Create default config directory
        sudo -u "$REAL_USER" mkdir -p "$USER_HOME/.config/MangoHud"

        # Create basic config file
        cat > "$USER_HOME/.config/MangoHud/MangoHud.conf" << EOL
# MangoHud configuration file
# Created by Arch Gaming Setup Script

### Display ###
fps_limit=0
position=top-left
legacy_layout=false
gpu_stats
gpu_temp
gpu_load_change
cpu_stats
cpu_temp
cpu_load_change
ram
vram
io_read
io_write
frame_timing=1
media_player_color=FFFFFF

### Keybindings ###
toggle_hud=Shift_R+F12
toggle_logging=Shift_L+F2
reload_cfg=F4
EOL

        # Fix ownership of the file
        chown "$REAL_USER:$REAL_USER" "$USER_HOME/.config/MangoHud/MangoHud.conf"

        echo -e "${GREEN}MangoHud configured globally.${NC}"
    fi
}

# Function to set CPU performance mode
set_cpu_performance() {
    if confirm_action "Would you like to set CPU to performance mode for better gaming performance?"; then
        echo -e "${CYAN}Setting CPU to performance mode...${NC}"

        # Check for distribution-specific tools first
        case "$DISTRO" in
            "garuda")
                if command -v garuda-performance &> /dev/null; then
                    echo -e "${LIGHT_RED}Using Garuda performance utilities...${NC}"
                    garuda-performance
                    echo -e "${GREEN}Performance settings applied via Garuda tools.${NC}"
                    pause
                    return
                fi
                ;;
        esac

        # General approach for all distros
        if command -v powerprofilesctl &> /dev/null; then
            powerprofilesctl set performance
            echo -e "${GREEN}CPU set to performance mode using powerprofilesctl.${NC}"
        else
            echo -e "${YELLOW}powerprofilesctl not found, installing power-profiles-daemon...${NC}"
            pacman -S --needed  power-profiles-daemon
            systemctl enable --now power-profiles-daemon
            powerprofilesctl set performance
            echo -e "${GREEN}power-profiles-daemon installed and CPU set to performance mode.${NC}"
        fi
        pause
    fi
}

# Function to configure Wine for gaming
configure_wine() {
    if confirm_action "Would you like to configure Wine for gaming?"; then
        echo -e "${CYAN}Configuring Wine for gaming...${NC}"

        # Install Wine and dependencies
        pacman -S --needed  wine-staging wine-gecko wine-mono winetricks

        # Install common Wine dependencies
        pacman -S --needed  lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse lib32-alsa-plugins

        # Install common dependencies for Windows games
        pacman -S --needed  giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox

        # Create default Wine prefix if it doesn't exist
        if [ ! -d "$USER_HOME/.wine" ]; then
            echo -e "${YELLOW}Creating default Wine prefix...${NC}"
            sudo -u "$REAL_USER" WINEPREFIX="$USER_HOME/.wine" WINEARCH=win64 wineboot -u
        fi

        echo -e "${GREEN}Wine configured for gaming.${NC}"
        pause
    fi
}

# Function to install and configure Feral GameMode
configure_gamemode() {
    if confirm_action "Would you like to configure GameMode for optimal performance?"; then
        echo -e "${CYAN}Configuring GameMode...${NC}"

        # Install GameMode if not already installed
        pacman -S --needed  gamemode lib32-gamemode

        # Create GameMode config directory if it doesn't exist
        sudo -u "$REAL_USER" mkdir -p "$USER_HOME/.config/gamemode"

        # Create custom GameMode config
        cat > "$USER_HOME/.config/gamemode/gamemode.ini" << EOL
[general]
# GameMode configuration file

# Default is 'auto'
desiredgov=performance
# Default timer
softrealtime=auto
# Inhibit screensaver
inhibit_screensaver=1

[custom]
# Custom scripts
start=
end=

[cpu]
# CPU governor control
governor=performance
# Default behavior when entering GameMode is to disable CPU SMT
# Only valid on supported CPUs (currently Intel and AMD)
nohints=0
# Defaults to 0 (disabled)
renice=10

[gpu]
# GPU performance level control
# Set to discrete to force AMD dGPU on hybrid systems
amd_performance=high
# Set nvidia powermizer mode to preferred_mode on entering GameMode
nvidia_powermizer_mode=1

[supervisor]
# Supervisor processes disable GameMode when any of these are active
# Only works on systems with systemd as the init system
#supervisor_whitelist=

[custom]
# Custom scripts (execute on mode apply/revert)
start=
end=
EOL

        # Fix ownership of the file
        chown "$REAL_USER:$REAL_USER" "$USER_HOME/.config/gamemode/gamemode.ini"

        echo -e "${GREEN}GameMode configured for optimal performance.${NC}"
        pause
    fi
}

# Function to optimize kernel parameters for gaming
optimize_kernel_parameters() {
    if confirm_action "Would you like to optimize kernel parameters for gaming?"; then
        echo -e "${CYAN}Optimizing kernel parameters for gaming...${NC}"

        # Create sysctl config file for gaming optimizations
        cat > /etc/sysctl.d/99-gaming-performance.conf << EOL
# Kernel sysctl configuration for gaming performance
# Created by Arch Gaming Setup Script

# Increase the maximum file handles
fs.file-max = 100000

# Improve network performance
net.core.netdev_max_backlog = 16384
net.core.somaxconn = 8192
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 2000000
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 10
net.ipv4.tcp_slow_start_after_idle = 0

# Decrease swappiness for better responsiveness
vm.swappiness = 10

# Improve virtual memory handling
vm.vfs_cache_pressure = 50
EOL

        # Apply the new settings
        sysctl --system

        echo -e "${GREEN}Kernel parameters optimized for gaming.${NC}"
        pause
    fi
}

# Function to install gaming tools based on distribution
install_gaming_tools() {
    echo -e "${DISTRO_STYLE}Installing additional gaming tools...${NC}"

    install_mangohud

    # Distribution-specific tools
    case "$DISTRO" in
        "cachyos")
            prompt_installation "CoreCtrl" "Install CoreCtrl for AMD GPU controls?" "sudo -u \"$REAL_USER\" yay -S --needed  corectrl"
            prompt_installation "GreenWithEnvy" "Install GreenWithEnvy for NVIDIA GPU controls?" "sudo -u \"$REAL_USER\" yay -S --needed  gwe"
            ;;
        "garuda")
            prompt_installation "Garuda Gamer" "Install Garuda Gamer utility?" "pacman -S --needed  garuda-gamer"
            ;;
        "manjaro")
            prompt_installation "Manjaro Gaming" "Install Manjaro Gaming utilities?" "pacman -S --needed  manjaro-gaming-meta"
            ;;
        *)
            # Default tools for all distros
            prompt_installation "CoreCtrl" "Install CoreCtrl for AMD GPU controls?" "sudo -u \"$REAL_USER\" yay -S --needed  corectrl"
            prompt_installation "GreenWithEnvy" "Install GreenWithEnvy for NVIDIA GPU controls?" "sudo -u \"$REAL_USER\" yay -S --needed  gwe"
            ;;
    esac

    # Common tools for all distros
    prompt_installation "Lutris Scripts" "Install additional Lutris scripts for game installation?" "sudo -u \"$REAL_USER\" yay -S --needed  lutris-wine-meta"
    prompt_installation "Discord" "Install Discord?" "pacman -S --needed  discord"

    echo -e "${GREEN}Gaming tools installation completed.${NC}"
    pause
}

# Function to display additional resources
display_resources() {
    echo -e "${DISTRO_STYLE}${BOLD}For more detailed guides and community support, visit:${NC}"

    case "$DISTRO" in
        "cachyos")
            echo -e "  - CachyOS Gaming Guide: https://wiki.cachyos.org/configuration/gaming/"
            echo -e "  - CachyOS Community Forums: https://www.reddit.com/r/cachyos/"
            ;;
        "endeavouros")
            echo -e "  - EndeavourOS Wiki: https://discovery.endeavouros.com/"
            echo -e "  - EndeavourOS Forums: https://forum.endeavouros.com/"
            ;;
        "manjaro")
            echo -e "  - Manjaro Gaming Guide: https://wiki.manjaro.org/index.php/Gaming"
            echo -e "  - Manjaro Forums: https://forum.manjaro.org/"
            ;;
        "garuda")
            echo -e "  - Garuda Linux Gaming Guide: https://forum.garudalinux.org/c/guides/8"
            echo -e "  - Garuda Linux Gaming Category: https://forum.garudalinux.org/c/gaming/13"
            ;;
        *)
            echo -e "  - Arch Linux Gaming Wiki: https://wiki.archlinux.org/title/Gaming"
            echo -e "  - ProtonDB: https://www.protondb.com/"
            ;;
    esac

    # Common resources for all distributions
    echo -e "  - ProtonDB (Steam game compatibility): https://www.protondb.com/"
    echo -e "  - Lutris (Gaming platform): https://lutris.net/"
    echo -e "  - Gaming on Linux (News site): https://www.gamingonlinux.com/"
    echo -e "  - r/linux_gaming: https://www.reddit.com/r/linux_gaming/"

    echo
    pause
}

# Function to display post-installation instructions
post_installation_instructions() {
    echo -e "${GREEN}${BOLD}Setup complete! Here are some steps to optimize your gaming experience:${NC}"
    echo -e "1. Configure your graphics drivers using the respective control panels."
    echo -e "2. Set up your gaming platforms (Steam, Lutris, PlayOnLinux) and add your games."
    echo -e "3. Use ProtonUp-Qt to install the latest GE-Proton for better Steam game compatibility."
    echo -e "4. Launch games with GameMode for better performance (gamemoderun %command% in Steam)."
    echo -e "5. Use MangoHud to monitor performance (mangohud %command% in Steam)."

    # Add distribution-specific instructions
    case "$DISTRO" in
        "garuda")
            echo -e "6. Use Garuda Gamer utility for additional gaming optimizations."
            ;;
        "manjaro")
            echo -e "6. Check Manjaro Settings Manager for additional driver options."
            ;;
        "cachyos")
            echo -e "6. Consider using the CachyOS custom kernel for better gaming performance."
            ;;
    esac

    echo
    pause
}

# Function to confirm before proceeding with the full script
confirm_continue() {
    echo -e "${YELLOW}This script will help set up your $DISTRO_NAME system for gaming.${NC}"
    echo -e "${YELLOW}It will install various gaming packages and drivers.${NC}"

    if ! confirm_action "Do you want to continue with the setup?"; then
        echo -e "${RED}Setup cancelled by user.${NC}"
        exit 0
    fi
}

# Main script execution
check_root
display_header
confirm_continue
check_system_info
update_system

# Install AUR helper first (needed for later steps)
install_aur_helper

install_graphics_drivers
install_gaming_meta_packages
install_gaming_platforms
install_playonlinux
install_gamemode
install_dxvk
install_mangohud
set_cpu_performance
configure_wine
configure_gamemode
optimize_kernel_parameters
install_gaming_tools
display_resources
post_installation_instructions

echo -e "${DISTRO_STYLE}${BOLD}Gaming setup complete! Enjoy your gaming experience on $DISTRO_NAME!${NC}"
echo -e "${YELLOW}You may need to reboot your system for all changes to take effect.${NC}"

if confirm_action "Would you like to reboot now?"; then
    echo -e "${GREEN}Rebooting system...${NC}"
    sleep 3
    reboot
else
    echo -e "${YELLOW}Remember to reboot later for all changes to take effect.${NC}"
fi

# Note:
# If you encounter DBus-related warnings (e.g. from yad or gamemode),
# ensure you are running these commands in a proper user session with DBUS_SESSION_BUS_ADDRESS and XDG_RUNTIME_DIR set.
# You may need to log out and back in or run these commands with the '-E' flag to preserve your environment.
