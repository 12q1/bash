Retired setups, kept for nostalgia rather than use. None of this is maintained, and none of it
should be assumed to still work on current OS/tool versions — treat it as a historical record
of past machines, not a starting point for a new one.

- **`linux_aliases/`** — the very first version of this repo (2020): a generic Ubuntu/Debian
  `.bash_aliases` plus a script that appends it to `~/.bash_aliases`. Predates the per-OS
  `fresh_install`-style layout below.
- **`debian_10/`** — Docker setup script for Debian 10.
- **`ubuntu_18.04/`** — basic app install, Docker setup, nvm installer, and a theme script for
  Ubuntu 18.04.
- **`ubuntu_24.04/`** — a later WSL setup attempt (aliases, starship config, two setup scripts)
  for Ubuntu 24.04. Newer than the others but superseded before it saw real day-to-day use.
- **`fonts/`** — Nerd Font builds (RobotoMono, Terminess) bundled for offline install on the
  older setups above.

If a Linux/WSL profile gets actively rebuilt again, it'll live under `../profiles/`, not here —
these folders stay frozen as-is.
