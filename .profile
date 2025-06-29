# profile

LANG="ja_JP.UTF-8"
export LANG

EDITOR="vim"
export EDITOR
VISUAL="$EDITOR"
export VISUAL

PAGER="less"
export PAGER

if [ -n "$WSL_DISTRO_NAME" ] ; then
    SCREENDIR="$HOME/.screen"
    export SCREENDIR
fi

#GOROOT="$HOME/opt/go"
#export GOROOT
GOPATH="$HOME/go"
export GOPATH

if [ -z "$LOADED_DOTPROFILE" ] ; then
    if [ -z "$PATH" ] ; then
        PATH="/usr/sbin:/usr/bin:/sbin:/bin"
    fi

    #if [ -d "$GOROOT/bin" ] ; then
    #    PATH="$PATH:$GOROOT/bin"
    #fi
    if [ -d "$GOPATH/bin" ] ; then
        PATH="$PATH:$GOPATH/bin"
    fi

    if [ -d "$HOME/.cargo/bin" ] ; then
        PATH="$PATH:$HOME/.cargo/bin"
    fi

    if [ -d "$HOME/local/bin" ] ; then
        PATH="$HOME/local/bin:$PATH"
    fi

    if [ -d "$HOME/bin" ] ; then
        PATH="$HOME/bin:$PATH"
    fi

    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    if [ -d "$HOME/.dotfiles/bin" ] ; then
        PATH="$HOME/.dotfiles/bin:$PATH"
    fi

    if [ -d "$HOME/.rbenv/bin" ] ; then
        PATH="$HOME/.rbenv/bin:$PATH"
    fi

    if [ -d "$HOME/.plenv/bin" ] ; then
        PATH="$HOME/.plenv/bin:$PATH"
    fi

    export PATH

    LOADED_DOTPROFILE=true
    export LOADED_DOTPROFILE
fi

# vim: set et ts=4 sts=4 sw=4:
# end of profile
