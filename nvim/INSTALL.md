# Dotfiles

Config for **Neovim** (LazyVim), **tmux**, and **Kitty**.

```
dotfiles/
├── nvim/       → ~/.config/nvim/
├── tmux/       → ~/.config/tmux/ (or ~/.tmux.conf)
└── kitty/      → ~/.config/kitty/
```

---

## 1. Install Dependencies

### All platforms — install these first:

| Tool | Purpose | Ubuntu/Debian | Arch | macOS |
|------|---------|--------------|------|-------|
| `git` | Required by everything | `apt install git` | `pacman -S git` | built-in |
| `ripgrep` | Live grep (Neovim) | `apt install ripgrep` | `pacman -S ripgrep` | `brew install ripgrep` |
| `fd` | File finder (Neovim) | `apt install fd-find` | `pacman -S fd` | `brew install fd` |
| `node` + `npm` | LSPs via Mason | `apt install nodejs npm` | `pacman -S nodejs npm` | `brew install node` |
| `gcc` + `make` | Treesitter parsers | `apt install gcc make` | `pacman -S gcc make` | Xcode CLT |
| `python3` | Some LSPs/plugins | `apt install python3` | `pacman -S python` | built-in |
| Nerd Font | Icons in terminal | see below | see below | see below |

---

## 2. Install Neovim

**Ubuntu/Debian** (system repo is often outdated):
```bash
# AppImage — easiest, always latest stable
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
```

**Arch:**
```bash
sudo pacman -S neovim
```

**macOS:**
```bash
brew install neovim
```

---

## 3. Install tmux

**Ubuntu/Debian:**
```bash
sudo apt install tmux
```

**Arch:**
```bash
sudo pacman -S tmux
```

**macOS:**
```bash
brew install tmux
```

---

## 4. Install Kitty

**Linux:**
```bash
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

**macOS:**
```bash
brew install --cask kitty
```

---

## 5. Install a Nerd Font

Icons in Neovim and tmux won't render without a Nerd Font in your terminal.

1. Download from https://www.nerdfonts.com/font-downloads (JetBrainsMono or FiraCode recommended)
2. Install the font and set it in your terminal emulator settings

---

## 6. Apply This Config

```bash
# Back up anything existing
mv ~/.config/nvim   ~/.config/nvim.bak   2>/dev/null
mv ~/.config/kitty  ~/.config/kitty.bak  2>/dev/null
mv ~/.tmux.conf     ~/.tmux.conf.bak     2>/dev/null

# Unzip everything
unzip dotfiles.zip -d /tmp/dotfiles

# Neovim
cp -r /tmp/dotfiles/nvim ~/.config/nvim

# Kitty
cp -r /tmp/dotfiles/kitty ~/.config/kitty

# tmux (stored as tmux.conf, goes to home dir)
cp /tmp/dotfiles/tmux/tmux.conf ~/.tmux.conf

# Open Neovim — plugins install automatically (~1-2 min, needs internet)
nvim
```

---

## 7. First Launch Checklist

- [ ] Neovim plugins installed (lazy.nvim auto-runs on first open)
- [ ] No errors in `:checkhealth`
- [ ] LSPs working — `:LspInfo` inside a code file (Mason auto-installs on file open)
- [ ] Icons rendering (if broken, check terminal font setting)
- [ ] tmux loads without errors — `tmux new`
- [ ] Kitty opens with correct theme and font
