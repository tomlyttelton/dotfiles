# Dotfiles

Instructions for setting up a personal Linux environment.

- **Shell**: Bash (`.bashrc`), Git (`.gitconfig`)
- **Window manager**: Sway
- **Display management**: kanshi
- **Status bar**: Waybar
- **Terminal**: Foot
- **Editors**: Sublime Text, Cursor and VS Code

## Install Dependencies

```bash
sudo apt update
sudo apt install \
  curl wget gnupg ca-certificates stow \
  vim nemo imagemagick libnotify-bin \
  sway swaylock swayidle kanshi waybar wofi foot brightnessctl \
  pipewire pipewire-pulse wireplumber pulseaudio-utils alsa-utils \
  xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  network-manager network-manager-gnome \
  fonts-dejavu-core fonts-inter \
  git gh gnome-keyring net-tools \
  rclone
```

PipeWire provides audio services, while `pipewire-pulse` allows applications and existing `pactl` commands to use the PulseAudio-compatible interface.

The desktop portals support Wayland screen sharing, file selection and other desktop integration features.

## Install Additional Applications

These are expected by keybindings or common workflows.

### [Google Chrome](https://www.google.com/chrome/)

```bash
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
```

### [Sublime Text](https://www.sublimetext.com/)

```bash
sudo mkdir -p /etc/apt/keyrings

wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
  | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null

printf 'Types: deb\nURIs: https://download.sublimetext.com/\nSuites: apt/stable/\nSigned-By: /etc/apt/keyrings/sublimehq-pub.asc\n' \
  | sudo tee /etc/apt/sources.list.d/sublime-text.sources

sudo apt update
sudo apt install sublime-text
```

Set Sublime Text as the default plain-text editor:

```bash
xdg-mime default sublime_text.desktop text/plain
```

### Languages

Install Java, Go and Python:

```bash
sudo apt install default-jdk golang-go python3
```

#### Node.js

Install [nvm](https://github.com/nvm-sh/nvm) without modifying the shell configuration. `core/.bashrc` already loads it.

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | PROFILE=/dev/null bash
```

Load nvm and install the latest LTS release:

```bash
source ~/.nvm/nvm.sh
nvm install --lts
nvm alias default 'lts/*'
```

This avoids maintaining a separate system installation of Node.js and npm.

#### Rust

Install [rustup](https://rustup.rs/). `core/.bashrc` already loads `~/.cargo/env`.

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### [Spotify](https://www.spotify.com/)

```bash
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://download.spotify.com/debian/pubkey_C85668DF69375001.gpg \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/spotify.gpg > /dev/null

echo 'deb [signed-by=/etc/apt/keyrings/spotify.gpg] https://repository.spotify.com stable non-free' \
  | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update
sudo apt install spotify-client
```

### [Signal](https://signal.org/)

```bash
wget -qO- https://updates.signal.org/desktop/apt/keys.asc \
  | gpg --dearmor \
  | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' \
  | sudo tee /etc/apt/sources.list.d/signal-xenial.list

sudo apt update
sudo apt install signal-desktop
```

### [VS Code](https://code.visualstudio.com/)

Download the Linux `.deb` package from the official website.

Install using:

```bash
sudo apt install ./Downloads/code_*.deb
```

### [Cursor](https://cursor.com/download)

Install from the official Cursor APT repository:

```bash
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://downloads.cursor.com/keys/anysphere.asc \
  | gpg --dearmor \
  | sudo tee /etc/apt/keyrings/cursor.gpg > /dev/null

echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/cursor.gpg] https://downloads.cursor.com/aptrepo stable main' \
  | sudo tee /etc/apt/sources.list.d/cursor.list > /dev/null

sudo apt update
sudo apt install cursor
```

This allows Cursor to receive updates through APT.

## Install Configuration

Clone the repository:

```bash
<<<<<<< HEAD
git clone https://github.com/tomlyttelton/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
=======
<<<<<<< HEAD
git clone https://github.com/tomlyttelton/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
=======
git clone https://github.com/tomlyttelton/dotfiles.git ~/workspace/dotfiles
cd ~/workspace/dotfiles
>>>>>>> 7acc29d (Preparation to upgrade to Ubuntu 26.04 LTS)
>>>>>>> e4c218a (Preparation to upgrade to Ubuntu 26.04 LTS)
```

Each directory mirrors the structure expected in `$HOME` or `~/.config/`:

- `core/` – Bash and Git settings
- `sway/` – Sway, kanshi and Waybar configuration
- `gtk/` – GTK appearance settings
- `vscode/` – VS Code settings
- `cursor/` – Cursor settings

Symlink the configurations using [GNU Stow](https://www.gnu.org/software/stow/).

Preview the changes:

```bash
<<<<<<< HEAD
stow -n -v -t ~ core sway gtk vscode cursor
=======
<<<<<<< HEAD
stow -n -v -t ~ core sway gtk vscode cursor
=======
stow -n -v -R -t "$HOME" core sway gtk vscode cursor
>>>>>>> 7acc29d (Preparation to upgrade to Ubuntu 26.04 LTS)
>>>>>>> e4c218a (Preparation to upgrade to Ubuntu 26.04 LTS)
```

Install:

```bash
<<<<<<< HEAD
stow -t ~ core sway gtk vscode cursor
=======
<<<<<<< HEAD
stow -t ~ core sway gtk vscode cursor
=======
stow -R -t "$HOME" core sway gtk vscode cursor
>>>>>>> 7acc29d (Preparation to upgrade to Ubuntu 26.04 LTS)
>>>>>>> e4c218a (Preparation to upgrade to Ubuntu 26.04 LTS)
```

GNU Stow creates symlinks from the repository into your home directory. For example, `core/.bashrc` becomes accessible as `~/.bashrc`.

Existing regular files may cause conflicts. Review and back up conflicting files before replacing them.

Rerun `stow` when adding new configuration files or directories. Changes to existing linked files are reflected automatically.

## Setup Compass

Retrieve `rclone.conf` from secrets and place it at:

```bash
mkdir -p ~/.config/rclone
cp /path/to/rclone.conf ~/.config/rclone/rclone.conf
chmod 600 ~/.config/rclone/rclone.conf
```

Do not commit `rclone.conf` to Git.

Create the local Compass directory:

```bash
mkdir -p ~/compass
compass-pull
```

This populates `~/compass` with the contents of the Drive-based Compass folder.

> **Important:** `rclone sync` is directional.
>
> `compass-push` will overwrite files in Drive to match the **local** folder, including deleting remote files that are absent locally.
>
> If unsure, run `compass-status` or use `rclone copy` for a no-delete upload.

## Verification

### Sway

Validate the configuration:

```bash
sway -C -c ~/.config/sway/config
```

### Displays

Within Sway, inspect detected outputs:

```bash
swaymsg -t get_outputs
```

Kanshi is responsible for selecting monitor layouts as displays are connected or disconnected.

### Audio

Verify the active audio server:

```bash
pactl info
```

When using PipeWire, the server should identify itself as PulseAudio-compatible PipeWire.

### Status bar

Check the Waybar version:

```bash
waybar --version
```

The Waybar configuration is located in `~/.config/waybar/`.

## Notes

- Customize workspace names and keybindings in `sway/.config/sway/config`.
- `$mod+Return` launches Foot. Change `$term` to use another terminal.
- Cursor and VS Code settings can be shared, but extension and version differences may require local adjustments.
- Machine-specific configuration and credentials should remain outside version control.
- If camera or screen sharing fails, inspect PipeWire and desktop portal services before removing any packages.

## License

MIT
