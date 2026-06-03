# Dotfiles

Config for **Sway** (WM), **Waybar**, **swaync**, **swaylock**, **Neovim** (LazyVim), **tmux**, and **Kitty**.

```
dotfiles/
├── sway/           → ~/.config/sway/
│   ├── config
│   └── scripts/
│       ├── screenshot.sh
│       └── lock.sh
├── waybar/         → ~/.config/waybar/
│   ├── config
│   └── style.css
├── swaync/         → ~/.config/swaync/
│   ├── config.json
│   └── style.css
├── swaylock/       → ~/.config/swaylock/
│   └── config
├── nvim/           → ~/.config/nvim/
├── tmux/           → ~/.config/tmux/ (or ~/.tmux.conf)
└── kitty/          → ~/.config/kitty/
```

---

## 1. Install Dependencies

### Arch / CachyOS

```bash
# Core WM stack
sudo pacman -S sway swaybg swayidle swaylock waybar swaync \
               fuzzel kitty

# Wayland utilities
sudo pacman -S grim slurp wl-clipboard cliphist \
               xdg-desktop-portal xdg-desktop-portal-gtk \
               imagemagick brightnessctl

# System integration
sudo pacman -S polkit-gnome pipewire wireplumber \
               pavucontrol blueman

# Terminal / editor
sudo pacman -S neovim tmux
```

### Font

All configs use **JetBrainsMono Nerd Font**:

```bash
sudo pacman -S ttf-jetbrains-mono-nerd
```

---

## 2. Apply the Config

```bash
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Back up existing configs
for d in sway waybar swaync swaylock nvim kitty; do
    [ -d ~/.config/$d ] && mv ~/.config/$d ~/.config/$d.bak
done

# Sway
cp -r sway ~/.config/sway
chmod +x ~/.config/sway/scripts/*.sh

# Waybar
cp -r waybar ~/.config/waybar

# swaync (notification / control center)
cp -r swaync ~/.config/swaync

# swaylock
cp -r swaylock ~/.config/swaylock

# Neovim
cp -r nvim ~/.config/nvim

# Kitty
cp -r kitty ~/.config/kitty

# tmux
cp tmux/tmux.conf ~/.tmux.conf
```

> **Wallpaper** — the config expects `~/Downloads/creation_of_adam.jpeg`.
> Change the `output * bg` line in `sway/config` to point at your own image.

---

## 3. Key Bindings (Sway)

Direction keys are **vim-style** (`h j k l`).

| Key | Action |
|-----|--------|
| `$mod+Return` | Terminal (kitty) |
| `$mod+d` | App launcher (fuzzel) |
| `$mod+Shift+q` | Close window |
| `$mod+ctrl+l` | Lock screen |
| `$mod+Shift+n` | Toggle notification / control center |
| `$mod+Shift+v` | Clipboard history picker |
| `$mod+Shift+c` | Reload Sway config |
| `$mod+r` | Resize mode |
| `$mod+f` | Fullscreen |
| `$mod+Shift+space` | Toggle floating |
| `Print` | Region screenshot → file |
| `Shift+Print` | Region screenshot → clipboard |
| `Ctrl+Print` | Full screen → file |
| `Ctrl+Shift+Print` | Full screen → clipboard |

Screenshots save to `~/Pictures/Screenshots/` with a timestamp and a swaync toast notification.

---

## 4. Waybar

Floating pill bar at the top. Modules:

- **Left** — workspaces (numbers), mode indicator, focused window title
- **Center** — clock + date (`HH:MM — Day DD Mon`)
- **Right** — CPU, RAM, audio, network, battery, notification bell, tray

Left-click the bell to open the control center. Right-click to toggle Do Not Disturb.

---

## 5. swaync Control Center

macOS-style slide-out panel. Open with `$mod+Shift+n` or the waybar bell.

Contains: Do Not Disturb toggle · Volume slider · Brightness slider · Quick-action buttons (Network, Bluetooth, Display, Lock, Suspend, Logout) · Media player · Notification history.

---

## 6. Screen Lock

`$mod+ctrl+l` or auto after **5 min** idle. The lock script takes a blurred screenshot as background (requires `grim` + `imagemagick`). Display turns off after **10 min**; locks before sleep.

---

## 7. First Launch Checklist

- [ ] Sway starts without errors (`sway` from a TTY)
- [ ] Waybar visible with clock showing
- [ ] `$mod+Shift+n` opens the swaync panel
- [ ] `Print` captures a region and saves to `~/Pictures/Screenshots/`
- [ ] `$mod+ctrl+l` locks with blurred background
- [ ] Neovim plugins installed (lazy.nvim auto-runs on first open)
- [ ] No errors in `:checkhealth`
