# CLAUDE.md

Guidance for working in this repo (Daniel's cross-platform dotfiles).

## What this is

A single dotfiles repo shared across machines. Each machine links only the
configs it needs; the OS is detected at link time via `uname`.

## Layout

- `common/` — linked on **every** machine (`.zshrc`, `.tmux.conf`, `.gitconfig`,
  `.vimrc`, `.p10k.zsh`, `nvim/`, `doom/`, `scripts/`, `fonts/`).
- `linux/` — linked only on Linux (`.i3/`, plus the Nerd Font on Linux).
- `macos/` — linked only on macOS (`aerospace/`).
- `.oh-my-zsh/` — git **submodule** at the repo root (vendored dependency, not a
  dotfile). Linked to `~/.oh-my-zsh`. Do not move it into `common/`.

## Bootstrap a new machine

```sh
git clone --recurse-submodules https://github.com/daniel-iliesh/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install_deps.sh          # macOS: brew bundle (Brewfile) | Linux: pacman
./link_dotfiles.sh         # OS-aware symlinks, backs up existing files
./install_zsh_plugins.sh   # powerlevel10k theme + zsh plugins via zpm
```

## Key conventions

- **link_dotfiles.sh** holds three maps: `COMMON_MAP`, `MACOS_MAP`, `LINUX_MAP`
  (each entry is `source_relative_to_repo:target_absolute_path`). To add a
  dotfile, add an entry to the right map — don't hardcode paths elsewhere.
  Existing targets are backed up to `*.bak.<timestamp>` before linking.
- **Cross-platform, not machine-specific.** Keep configs OS-portable: gate
  OS-specific behavior inside the file (e.g. `.tmux.conf` uses `if-shell` for
  pbcopy vs xclip; `.zshrc` guards the Homebrew `shellenv`). Never hardcode a
  username or absolute home path — use `$HOME`.
- **Dependencies:** macOS deps go in `Brewfile`; Linux deps in `packages`
  (pacman) and the `install_deps.sh` Linux branch. Keep the two in sync.
- **oh-my-zsh custom plugins/themes** (powerlevel10k, zsh-vi-mode, etc.) are
  cloned into `~/.oh-my-zsh/custom/...` by `install_zsh_plugins.sh`, NOT tracked
  in this repo (they live inside the submodule's gitignored `custom/`).
- **Fonts:** symlinked on Linux; on macOS installed via Homebrew
  (`font-fira-code-nerd-font`), not symlinked.

## AeroSpace (macOS)

`macos/aerospace/aerospace.toml` links to `~/.config/aerospace/aerospace.toml`.
After editing, apply with `aerospace reload-config`. Modifier is Alt (Cmd is
reserved by macOS). Note: Terminal.app exposes each tab as a separate window, so
opening a tab splits the tiling layout — this is a known Terminal.app limitation
and is intentionally left unaddressed.

## Commits

End commit messages with:
`Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>`
