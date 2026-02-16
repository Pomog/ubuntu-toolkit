System requirements
2 GHz dual-core processor or better
4 GB system memory
25 GB of free hard drive space
Either a USB port or a DVD drive for the installer media
Internet access is helpful

1. get your Windows ProductKey, and save in safely
wmic path softwarelicensingservice get OA3xOriginalProductKey

2. laucnh cmd as admin and check the BitLocker Status, and disable it, 
manage-bde -status
manage-bde -protectors -disable C:

3. You can create a bootable USB stick using Rufus, a free and open source USB stick writing tool.
If you’ve already tried Rufus and the USB stick failed to boot on your system, change Partitioning scheme to GPT and check that Target system is set to UEFI (non CSM). This works on modern systems that disable legacy compatibility.

4. If the previous applications didn’t work or you have a special use case, we also suggest the following multi-platform image writers.
Ventoy
balenaEtcher
WonderISO

5. Congratulations! You now have Ubuntu on a USB stick, bootable and ready to go.
To use it you need to insert the stick into your target PC or laptop and reboot the device. It should recognize the installation media automatically during startup but you may need to hold down a specific key (usually F12) to bring up the boot menu and choose to boot from USB.

SetUP
1. Updating
sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y

2. bashrc

cat >> ~/.bashrc <<'EOF'
# --- BEGIN CUSTOM PS1 ---
# Fast prompt without external commands (no tput calls)
__PS1_RESET='\[\e[0m\]'
__PS1_GREEN='\[\e[38;5;10m\]'
__PS1_ORANGE='\[\e[38;5;214m\]'
__PS1_RED='\[\e[38;5;196m\]'
__PS1_BLUE='\[\e[38;5;33m\]'

export PS1="${__PS1_RESET}-[${__PS1_GREEN}\d${__PS1_RESET}-${__PS1_GREEN}\t${__PS1_RESET}]-[${__PS1_ORANGE}\u${__PS1_RESET}@${__PS1_RED}\h${__PS1_RESET}]-\n-[${__PS1_BLUE}\w${__PS1_RESET}]\\$ ${__PS1_RESET}"
# --- END CUSTOM PS1 ---
EOF

3. Install software
in progress
