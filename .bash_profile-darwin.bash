## bash_profile for macOS

# Homebrew
PATH=/usr/local/bin:/usr/local/sbin:$PATH

export PATH

# If running interactively, load `~/.bashrc'
case $- in
    *i*)  [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc" || : ;;
    *)    : Nop ;;
esac
