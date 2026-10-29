source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

function fish_greeting
    set img (shuf -n 1 -e ~/Pictures/Dr0/*)
     fastfetch \
            --logo $img \
            --logo-type kitty \
            --logo-width 30 \
            --logo-height 13 \
            --logo-padding-top 8 \
            --logo-padding-left 2 
end

# pnpm
set -gx PNPM_HOME "/home/saleri/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# alias
alias vi nvim
alias vim nvim
alias ww 'cd /mnt/e/workSpace/'

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/saleri/.ghcup/bin $PATH # ghcup-env

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

starship init fish | source

set -gx EDITOR nvim
set -gx VISUAL nvim

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

# init source
pyenv init - | source
fnm env | source
zoxide init fish --cmd cd | source
# 同时保留 z/zi；cd 仍然调用 zoxide，真实路径仍可直接进入
alias z __zoxide_z
alias zi __zoxide_zi
# 现在输入 cd 即调用 zoxide：真实路径走普通 cd，否则按历史跳转；cdi/zi 为交互式选择

# Hermes Agent — ensure ~/.local/bin is on PATH
fish_add_path "$HOME/.local/bin"


fish_add_path /home/saleri/.cache/scalacli/local-repo/bin/scala-cli
fish_add_path /home/saleri/.local/share/coursier/bin

set -gx NPC_HOME (realpath ~/workSpace/ysyx-workbench/npc)
set -gx NVBOARD_HOME (realpath ~/workSpace/ysyx-workbench/nvboard/)
# Private environment variables stay outside the dotfile directory.
if test -f "$HOME/.local/state/fish/private.fish"
    source "$HOME/.local/state/fish/private.fish"
end
