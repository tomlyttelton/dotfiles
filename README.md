# Dotfiles

Instructions for setting up a personal Linux environment.

- **Shell**: `.bashrc`, `.gitconfig`
- **Window manager**: i3 + i3blocks
- **Editors**: Cursor and VS Code

---

## Install Dependencies

```bash

sudo apt-get install \
  curl stow vim nemo imagemagick libnotify-bin \
  i3 i3lock i3status suckless-tools xss-lock x11-xserver-utils \
  nitrogen pulseaudio pulseaudio-utils alsa-utils \
  network-manager network-manager-gnome nm-tray \
  x11-utils x11-xkb-utils fonts-dejavu-core \
  gnome-keyring git net-tools
````


### Optional extras

```bash
sudo apt-get install arandr lxappearance feh
```

---

## Install Additional Applications

These are expected by keybindings or common workflows:

* [Google Chrome](https://www.google.com/chrome/)
* [Spotify](https://www.spotify.com/)
* [Signal](https://signal.org/)
* [Sublime Text](https://www.sublimetext.com/)
* [VS Code](https://code.visualstudio.com/)
* [Cursor](https://cursor.sh/)

For Cursor:

1. Place the AppImage at `~/bin/Cursor.AppImage`.

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

---

## License

MIT
