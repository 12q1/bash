# Windows Git Bash Dotfiles

Config for Git Bash on Windows: prompt, aliases, vim, and a handful of CLI
tools (eza, zoxide, fzf, bat, delta, lazygit, yazi, btop, starship).

## Installing

Run `install.sh` from this directory. It:

- Symlinks (`ln -sf`) each file in the table below from this repo into
  `$HOME`. **On Windows, `ln -sf` often silently falls back to a plain file
  copy instead of a real symlink** (needs Developer Mode or admin rights for
  real symlinks). If it copied instead of linking, editing `~/.bashrc`
  directly won't update this repo, and vice versa — re-run `install.sh`
  after changing files here, and manually copy the other direction if you
  edited a live file first. Check with `readlink -f ~/.bashrc`: if it prints
  the same path back, it's a copy, not a link.
- Symlinks/copies everything in `colors/` into `~/.vim/colors/`.
- Installs missing CLI tools via `winget` (see the `cli_packages` map near
  the bottom of the script — if you install something new by hand, add it
  there too or a fresh machine won't get it).
- Creates `~/.gitconfig_local` for your name/email (kept out of this repo
  on purpose — see `gitconfig` below).

| Repo file           | Installed to                 | What it is                                    |
|----------------------|-------------------------------|------------------------------------------------|
| `bashrc`             | `~/.bashrc`                   | Shell init: prompt, history, aliases, tool hooks |
| `bash_aliases`       | `~/.bash_aliases`              | All aliases + a couple of functions            |
| `bash_profile`       | `~/.bash_profile`              | Just sources `.profile` then `.bashrc`         |
| `inputrc`            | `~/.inputrc`                   | Readline behavior (tab completion, history search) |
| `vimrc`              | `~/.vimrc`                     | Vim config                                     |
| `colors/`            | `~/.vim/colors/`               | Vim colorschemes                               |
| `minttyrc`           | `~/.minttyrc`                  | mintty terminal settings (only matters if you launch Git Bash outside Windows Terminal) |
| `starship.toml`      | `~/.config/starship.toml`      | Prompt theme (Nord-colored segments)           |
| `yazi.toml`          | `~/.config/yazi/yazi.toml`     | File manager config                            |
| `gitconfig`          | `~/.gitconfig`                 | Global git config (see caveat below)           |
| `gitignore_global`   | `~/.gitignore_global`          | Global gitignore                               |
| `terminal_settings.json` | *(not auto-installed)*    | Reference copy of Windows Terminal's `settings.json` — copy by hand |
| `btop.conf`          | *(not auto-installed)*        | Reference copy of btop4win's config — copy by hand |

## Design decisions & gotchas

A few things here aren't obvious just from reading the files, so noting the
reasoning down before it's forgotten.

### vim matches bat's colors, not the terminal's

`vimrc` uses `colorscheme molokai`. This is deliberate: `bat`'s default
theme (verified empirically, not just assumed — it's undocumented which
theme is default) is **Monokai Extended**, and `molokai` is the standard,
widely-used vim port of Monokai. So `vim` and `bat` render code in roughly
the same palette.

This is a *separate* color choice from the terminal itself — Windows
Terminal's `colorScheme` and `btop.conf`'s theme are both Nord. That's
intentional, not drift: the terminal's 16 ANSI colors and bat/vim's 256-color
syntax highlighting are different color systems that don't need to match
each other.

If you ever want the reverse (make bat match vim/Nord instead), set
`--theme="Nord"` in bat's config file (`%APPDATA%\bat\config` on Windows) —
bat ships a built-in Nord theme.

### `core.autocrlf = true` + root `.gitattributes`

Windows Git Bash checks files out with CRLF but this repo (and most repos)
store LF internally. Without `core.autocrlf = true`, editing a file on
Windows and one on Linux/WSL produces noisy diffs where every line looks
changed even though only one line actually changed — this bit us directly
once (`vimrc` showed as 100% different between the live file and the repo
copy purely from line endings). `core.autocrlf = true` normalizes this
per-user; the root `.gitattributes` does the same thing more explicitly and
per-file-type (and matters more, since it's enforced for anyone who clones
the repo, not just this machine).

### Delta layout: unified by default, side-by-side on demand

`gitconfig` sets `delta.side-by-side = false` as the baseline (works at any
terminal width, closest to stock `git diff`). Rather than picking one layout
permanently, `bash_aliases` adds `gds`/`gdu` to override it per-invocation via
`git -c delta.side-by-side=<bool>` — this works for any pager-backed command
(`diff`, `show`, `log -p`, `stash show -p`), not just `diff`. Use `gds` when
you've got a wide terminal, plain `git diff`/`gl`/etc. otherwise.

### Git completion must be sourced *after* fzf, not before

`bashrc` sources `/mingw64/share/git/completion/git-completion.bash` (bundled
with Git for Windows, not something you need to download) as the very last
step. This order matters: `eval "$(fzf --bash)")` overwrites whatever
completion is registered for the bare `git` command with fzf's generic path
completion. If git-completion is sourced *before* fzf, `git <Tab>` silently
stops listing subcommands. Sourcing it after fixes this, and also lets
`__git_complete` wire branch-name completion into the `gco`/`gb`/`gp`/`gl`
aliases.

### Shell-init is cached, not re-evaluated every launch

`starship init bash`, `zoxide init bash`, and `fzf --bash` each spawn a
subprocess just to print a static shell script. Process spawn is slow on
Windows/MSYS (measured: ~350ms combined for all three), which was pushing
total shell startup past half a second — long enough that a keystroke typed
right when the window opens could land before `readline` was ready to
receive it (the "first character gets eaten" bug).

Fix: each tool's generated init script is cached to `~/.cache/shell-init/*.sh`
on first run, and sourced from there afterward — measured ~0.6s → ~0.43s
startup. Run the **`refreshinit`** alias after upgrading starship/zoxide/fzf
or editing `starship.toml`, since the cache won't invalidate itself.

Non-obvious trap if you touch this again: `starship init bash` by default
prints a *lazy-loader* one-liner (`eval "$(starship init bash --print-full-init)")`)
that just re-invokes the binary anyway — caching that verbatim buys nothing.
Had to use `starship init bash --print-full-init` to get the actual
cacheable script. `zoxide init bash` and `fzf --bash` don't have this
problem; they print the real script directly.

### `winhome` alias

`cd "$HOME"` — used to be `cd /c/Users/$USER`, but Git Bash never sets
`$USER` (only `$USERNAME`), so it silently `cd`'d to `/c/Users/` with
nothing after it. If you see other aliases/scripts using `$USER` on this
setup, they likely have the same bug.

### `gitconfig` has no `[user]` section here

`user.name`/`user.email` live in `~/.gitconfig_local` (gitignored, created
by `install.sh` on first run) via `[include] path = ~/.gitconfig_local`,
kept out of this repo since it's a public dotfiles repo and the values are
personal. If `~/.gitconfig` on a given machine has `[user]` set directly
instead, that's local drift from before this pattern existed — worth folding
into `.gitconfig_local` next time you're in there.

## Maintenance

- **Installed a new CLI tool by hand?** Add it to the `cli_packages` map in
  `install.sh` so a fresh machine gets it too.
- **Upgraded starship/zoxide/fzf, or edited `starship.toml`?** Run
  `refreshinit`.
- **Live file and repo file disagree?** Check `readlink -f` on the live file
  first (see the symlink-vs-copy caveat above) before assuming one side is
  "right" — this repo has drifted from the live machine before purely
  because `ln -sf` copied instead of linking.
