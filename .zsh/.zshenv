## .zshenv
## https://github.com/todashuta/profiles


## Initialize {{{

# ZDOTDIR
# zsh 関連設定ファイルをこれにまとめる
export ZDOTDIR="${HOME}/.zsh"

# LANG
export LANG='ja_JP.UTF-8'

# }}}


## PATH {{{

# 重複したパスを登録しない
typeset -U path

path=(  # {{{
    # For Homebrew
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)

    # For MacPorts
    /opt/local/bin(N-/)
    /opt/local/sbin(N-/)

    # X11 (XQuartz)
    /opt/X11/bin(N-/)

    # Use MacVim on Terminal.
    #/Applications/MacVim.app/Contents/MacOS(N-/)

    # Use coreutils without the prefix "g".
    #/usr/local/opt/coreutils/libexec/gnubin

    # My shell scripts.
    ${HOME}/bin(N-/)
    # prefix=${HOME}/local でインストールしたものの場所
    ${HOME}/local/bin(N-/)

    ${path}  # システムのデフォルトのパス
)  # }}}

# }}}


## Environment variables {{{

# Memo:
# (( $+commands[foo] )) は `which(もしくは type) foo >/dev/null 2>&1`
# と同じようなことをを zsh らしく行ったもの。

# MacPorts
if (( $+commands[port] )); then
    export DISPLAY=:0
fi

# Android SDK
if (( $+commands[android] )); then
    # ANDROID_HOME
    if [[ -e '/usr/local/opt/android-sdk' ]]; then
        export ANDROID_HOME='/usr/local/opt/android-sdk'
    fi
fi

# node.js
if (( $+commands[node] )); then
    # npm
    path=(${path} /usr/local/share/npm/bin(N-/))

    # NODE_PATH
    if [[ -e '/usr/local/share/npm/lib/node_modules' ]]; then
        export NODE_PATH='/usr/local/share/npm/lib/node_modules'
    fi
fi

# Golang
if (( $+commands[go] )); then
    # GOPATH
    export GOPATH="${HOME}/local/go"

    # go installed binaries.
    path=(${path} ${GOPATH}/bin(N-/))
fi

# }}}


## rbenv {{{

if (( $+commands[rbenv] )); then
    # For Homebrew installed rbenv.
    eval "$(rbenv init -)"
elif [[ -x "${HOME}/.rbenv/bin/rbenv" ]]; then
    # For git-cloned rbenv.
    path=(${HOME}/.rbenv/bin(N-/) ${path})
    eval "$(rbenv init -)"
fi

# }}}


## pyenv {{{

if (( $+commands[pyenv] )); then
    # For Homebrew installed pyenv.
    eval "$(pyenv init -)"
elif [[ -x "${HOME}/.pyenv/bin/pyenv" ]]; then
    # For git-cloned pyenv.
    export PYENV_ROOT="${HOME}/.pyenv"
    path=(${PYENV_ROOT}/bin(N-/) ${path})
    eval "$(pyenv init -)"
fi

#}}}


## MANPATH {{{

# 重複したパスを登録しない
typeset -U manpath

manpath=(
    # MANPATH of the Coreutils - GNU core utilities.
    #/usr/local/opt/coreutils/libexec/gnuman(N-/)

    ${manpath}  # システムのデフォルトのパス
)

# }}}


## PAGER {{{

# lv を優先して lv がなかったら less を使用する
export PAGER='more'  # fallback
(( $+commands[less] )) && export PAGER='less'
(( $+commands[lv] )) && export PAGER='lv'

# lv の設定
if (( $+commands[lv] )); then
    export LV='-c -l'
fi

# less の設定
if (( $+commands[less] )); then
    function() {  # {{{
        # $LESS
        local -a opt_less
        opt_less=(  # {{{
            '-gj10'  # 検索時、フォーカスがある語のみハイライトする
            '--no-init'  # less 終了後にプロンプトを上に移動させない
            '--quit-if-one-screen'  # スクロールが不要なときは出力後すぐ終了
            '--RAW-CONTROL-CHARS'  # 色付きの出力を可能にする
            '--LONG-PROMPT'
        )  # }}}
        # (e): Perform single-word shell expansions.
        #export LESS="${(e)opt_less}"
        # (j:string:): string で結合する
        #export LESS="${(j: :)opt_less}"
        export LESS="${opt_less[*]}"

        # less と Source-highlight でソースコードに色付けする (lesspipe)
        local -a source_highlight_paths
        source_highlight_paths=(
            '/usr/local/bin/src-hilite-lesspipe.sh'
            '/usr/share/source-highlight/src-hilite-lesspipe.sh'
        )
        local path
        for path in ${source_highlight_paths}; do
            if [[ -x "${path}" ]]; then
                export LESSOPEN="| ${path} %s"
                break
            fi
        done
    }  # }}}
fi

# }}}


## EDITOR {{{

(( $+commands[vi] )) && export EDITOR='vi'
(( $+commands[vim] )) && export EDITOR='vim'

# }}}


## Misc {{{

# ls colors
export LSCOLORS='gxfxcxdxbxegedabagacad'
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=36;40:tw=30;42:ow=30;43'

# What is ZLS_COLORS?? lol
export ZLS_COLORS="${LS_COLORS}"

# }}}


# __END__
# vim: set fdm=marker ts=4 sw=4 sts=4 et:
