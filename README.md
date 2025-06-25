# Dotfiles

Instructions for setting up a personal Linux environment.

- **Shell**: `.bashrc`, `.gitconfig`
- **Window manager**: i3
- **Editors**: Cursor and VS Code

---

## Getting Started

```bash
sudo apt install git i3
```

Log into i3.

```bash
git clone https://github.com/tomlyttelton/dotfiles.git
mv dotfiles .dotfiles
```

## Install Dependencies

```bash
sudo apt install \
  arandr curl stow vim nemo imagemagick libnotify-bin \
  i3lock i3status suckless-tools xss-lock x11-xserver-utils \
  nitrogen pulseaudio pulseaudio-utils alsa-utils \
  network-manager network-manager-gnome nm-tray \
  x11-utils x11-xkb-utils fonts-dejavu-core \
  gh gnome-keyring git net-tools
````

---

## Install Additional Applications

These are expected by keybindings or common workflows:

### [Google Chrome](https://www.google.com/chrome/)

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
```

### [Sublime Text](https://www.sublimetext.com/)

```bash
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
echo -e 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc' | sudo tee /etc/apt/sources.list.d/sublime-text.sources
sudo apt-get update && sudo apt-get install sublime-text

xdg-mime default sublime_text.desktop text/plain
```

### Languages

```bash
sudo apt install default-jre golang-go npm python3

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 20
nvm use 20

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### [Spotify](https://www.spotify.com/)

```bash
curl -sS https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client
```

### [Signal](https://signal.org/)

```bash
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |\
  sudo tee /etc/apt/sources.list.d/signal-xenial.list

sudo apt update && sudo apt install signal-desktop
```

### [VS Code](https://code.visualstudio.com/)
### [Cursor](https://cursor.sh/)

```bash
sudo apt update && sudo apt install libfuse2
```

1. [Download](https://www.cursor.com) and place the AppImage at `~/bin/Cursor.AppImage`.

   ```bash
   chmod +x ~/bin/cursor.AppImage
   ```

2. (Optional) Create an AppArmor profile at `/etc/apparmor.d/cursor-appimage`:

   ```bash
   sudo nano /etc/apparmor.d/cursor-appimage
   ```

   ```apparmor
   # Allows everything; gives a named label instead of "unconfined"
   abi <abi/4.0>,
   include <tunables/global>

   profile cursor /home/*/bin/Cursor.AppImage flags=(unconfined) {
     userns,

     # Site-specific additions and overrides. See local/README for details.
     include if exists <local/cursor>
   }
   ```

3. Then reload AppArmor:

   ```bash
   sudo apparmor_parser -r /etc/apparmor.d/cursor-appimage
   ```

---

## Structure

Each directory mirrors the structure expected in `~/.config/` or `$HOME`.

* `core/` – Shell settings (`.bashrc`, `.gitconfig`)
* `i3/` – i3 configuration
* `vscode/` – VS Code settings
* `cursor/` – Cursor editor settings

---

## Installation

Clone the repository:

```bash
git clone https://github.com/tomlyttelton/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

Symlink files using [GNU Stow](https://www.gnu.org/software/stow/):

```bash
stow core window-manager vscode cursor
```

> This will symlink files like `core/.bashrc` to `~/.bashrc`.
> Rerun `stow` any time you update dotfiles.

---

## Notes

* You may need to customize workspace names or keybindings in `i3/config`.
* Cursor and VS Code settings are safe to sync, but watch for extension or version mismatches.
* `i3-sensible-terminal` uses your system default terminal unless overridden via the `$TERMINAL` environment variable.
* `sudo apt remove gstreamer1.0-pipewire` might be useful if the camera doesn't work
---

## License

MIT
