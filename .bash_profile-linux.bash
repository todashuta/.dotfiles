## bash_profile for linux

export LANG='ja_JP.UTF-8'
export EDITOR=vim

append_path_once() {
    [ -d "$1" ] || return 1
    case ":$PATH:" in
    *":$1:"*)
        :  # Do nothing
        ;;
    *)
        PATH="$PATH:$1"
        ;;
    esac
}

prepend_path_once() {
    [ -d "$1" ] || return 1
    case ":$PATH:" in
    *":$1:"*)
        :  # Do nothing
        ;;
    *)
        PATH="$1:$PATH"
        ;;
    esac
}

prepend_path_once "$HOME/bin"
prepend_path_once "$HOME/.plenv/bin"
prepend_path_once "$HOME/.plenv/shims"

export PATH

# If running interactively, load `~/.bashrc'
case $- in
    *i*)  [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc" || : ;;
    *)    : Nop ;;
esac
