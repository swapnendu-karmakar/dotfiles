#!/usr/bin/env bash
set -euo pipefail

if [ "$EUID" -eq 0 ]; then
  echo "Do not run this script as root."
  exit 1
fi

if ! command -v paru &> /dev/null; then
  echo "paru not found. Install it first."
  exit 1
fi

DOTFILES_DIR="$HOME/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  git clone https://github.com/swapnendu-karmakar/dotfiles "$DOTFILES_DIR"
fi

update () {
  sudo pacman -Syu --noconfirm
}

pause() {
  sleep 3
}

install_base () {
  sudo pacman -S --needed --noconfirm niri xwayland-satellite xdg-desktop-portal-gnome xdg-desktop-portal-gtk alacritty quickshell-git base-devel
  paru -S --needed dms-shell-bin matugen cava qt6-multimedia-ffmpeg dsearch-bin
}

install_aur_pkgs () {
  paru -S --needed greetd-dms-greeter-git python-pywalfox visual-studio-code-bin
}

install_pkgs () {
  sudo pacman -S --needed --noconfirm  cliphist wl-clipboard dgop accountsservice kitty i2c-tools \
  greetd fzf eza wev blueman bluez bluez-tools bluez-utils fprintd khal kimageformats discord jdk-openjdk openjdk-doc openjdk-src nvtop breeze-cursors zoxide \
  gnome-keyring zathura zathura-pdf-poppler zathura-djvu zathura-cb zathura-ps ristretto nodejs npm meld adw-gtk-theme gparted network-manager-applet tela-circle-icon-theme-all \
  qt6ct qt5ct flatpak nwg-look neovim gnome-disk-utility curl wget vlc mpv fastfetch git \
  thunar thunar-archive-plugin thunar-media-tags-plugin thunar-shares-plugin thunar-vcs-plugin thunar-volman pcmanfm xorg-xhost
}

applying_dots () {
  dms setup
  sleep 3
  cd "$DOTFILES_DIR"
  cp -r DankMaterialShell ~/.config/
  cp niri/config.kdl ~/.config/niri/config.kdl
  cp niri/dms/binds.kdl ~/.config/niri/dms/binds.kdl
  cp starship.toml ~/.config/starship.toml
  cp .zshrc ~/.zshrc
  cp -r gtk-3.0 ~/.config/
  cp -r gtk-4.0 ~/.config/
  cp -r qt5ct ~/.config/
  cp -r qt6ct ~/.config/
  cp -r nvim ~/.config/
  sudo cp greetd/config.toml /etc/greetd/config.toml
  sudo systemctl enable greetd
  dms greeter sync
}

install_zsh () {
  sudo pacman -S --needed zsh starship
  chsh -s $(which zsh)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  sleep 3
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

section() {
  local color="\033[1;36m"
  local reset="\033[0m"

  echo
  echo -e "${color}###########################"
  printf "# %-23s #\n" "$1"
  echo -e "###########################${reset}"
}

section_bold() {
  local color="\033[1;31m"
  local reset="\033[0m"

  echo
  echo -e "${color}###########################"
  printf "# %-23s #\n" "$1"
  echo -e "###########################${reset}"
}

main () {
  section "UPDATING SYSTEM"
  update
  pause

  section "INSTALLING BASE"
  install_base
  pause

  section "INSTALLING PACKAGES"
  install_pkgs
  pause

  section "INSTALLING AUR PACKAGES"
  install_aur_pkgs
  pause

  section "INSTALLING ZSH"
  install_zsh
  pause

  section "APPLYING DOTS"
  applying_dots
  pause

  section "INSTALLATION COMPLETE"
  section_bold "RESTART BEFORE USING"
  read -rp "Reboot now? [y/N]: " choice
  [[ "$choice" =~ ^[Yy]$ ]] && sudo reboot
}

main