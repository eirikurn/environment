# . ~/.zsh/config
# . ~/.zsh/aliases
# . ~/.zsh/completion

# Load additional scripts
for f in ~/.zsh/*; do . $f; done

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && .  ~/.localrc
