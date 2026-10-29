# Dotfiles

Current Fish, Kitty, Noctalia and Niri configuration snapshots live under `.config/`.

To restore, copy each directory into `~/.config/` after installing the corresponding applications. Check paths and commands that are specific to CachyOS before using these files on NixOS.

Fish loads private environment variables from `~/.local/state/fish/private.fish`. This file is intentionally outside this directory. Restore secrets separately through an encrypted backup and rotate the existing MINERU token before migration.

Kitty `current-theme.conf` is a relative symlink to `themes/noctalia.conf`; preserve symlinks when copying. Old `.bak` and `.backup` files from Kitty and Niri are omitted.

Noctalia v5's effective settings were exported to `.config/noctalia/config.toml` and validated with `noctalia config validate`. The existing `settings.json` and `plugins/` tree belong primarily to the separately installed legacy v4 shell. Restore the v5 TOML when migrating; review legacy files before reusing them with a newer release.
