#!/usr/bin/env bash
set -euo pipefail

SNAP_LIST="${1:-lists/snap.txt}"

log() { printf "\n\033[1m==> %s\033[0m\n" "$*"; }

install_chrome_deb() {
  log "Install Google Chrome (.deb)"
  if command -v google-chrome >/dev/null 2>&1; then
    echo "Google Chrome already installed"
    return 0
  fi

  sudo apt install -y wget
  tmp_deb="/tmp/google-chrome-stable_current_amd64.deb"

  wget -O "$tmp_deb" "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  sudo apt install -y "$tmp_deb"
}

install_snap_line() {
  local line="$1"
  local name="$(awk '{print $1}' <<<"$line")"

  if snap list 2>/dev/null | awk '{print $1}' | grep -qx "$name"; then
    echo "Snap already installed: $name"
  else
    log "Installing snap: $line"
    sudo snap install $line
  fi
}

read_list() {
  local file="$1"
  [[ -f "$file" ]] || { echo "Missing file: $file"; exit 1; }
  grep -vE '^\s*($|#)' "$file"
}

ensure_snapd() {
  # Ensure snap is available on Ubuntu
  if ! command -v snap >/dev/null 2>&1; then
    log "Installing snapd"
    sudo apt update
    sudo apt install -y snapd
  fi
}

install_snap() {
  ensure_snapd

  log "Installing snaps from $SNAP_LIST"
  while IFS= read -r line; do
    install_snap_line "$line"
  done < <(read_list "$SNAP_LIST")

  log "Done"
}

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean -y
sudo snap install android-studio --classic
sudo snap install --classic code

sudo add-apt-repository multiverse
sudo apt install steam
