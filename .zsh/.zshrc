# .zshrc
# https://github.com/todashuta/profiles

DOTFILES_DIR=
if [[ -d "$HOME/dotfiles" ]]; then
    DOTFILES_DIR="$HOME/dotfiles"
elif [[ -d "$HOME/.dotfiles" ]]; then
    DOTFILES_DIR="$HOME/.dotfiles"
elif [[ -d "$HOME/.profiles.d" ]]; then
    DOTFILES_DIR="$HOME/.profiles.d"
fi
export DOTFILES_DIR

if [[ -n "$DOTFILES_DIR" ]]; then
    source "$DOTFILES_DIR/functions"
    path=(${DOTFILES_DIR}/bin(N-/^W) $path)
fi

## General {{{

# Emacs like keybind
bindkey -e

## zcompile
#zcompile "${ZDOTDIR}/.zshrc"

# }}}

## fpathの設定 {{{
#
# Memo: fpathは'compinit'より前に記述しないと機能しないらしい。
# Memo: 'compinit'より後に記述してたとき機能したものの起動が遅くなった。

# 重複したパスを登録しない
typeset -U fpath
# パスの設定
fpath=(  # {{{
    # See: http://blog.n-z.jp/blog/2013-12-12-zsh-cleanup-path.html
    #
    # allow directories only (-/)
    # reject world-writable directories (^W)

    # My functions.
    ${ZDOTDIR}/functions(N-/^W)

    # Homebrew installed zsh-completions.
    /usr/local/share/zsh-completions(N-/^W)
    # git-cloned zsh-completions.
    ${HOME}/.repos/zsh-completions/src(N-/^W)

    ${fpath}  # デフォルトの fpath
)  # }}}

# }}}

## Prompt {{{

# プロンプト内で変数展開・コマンド置換・算術演算を実行する
setopt prompt_subst
# プロンプト内で「%」で始まる置換機能を有効にする
setopt prompt_percent
# コピペしやすいようにコマンド実行後は右プロンプトを消す
setopt transient_rprompt

# colors
autoload -Uz colors; colors

# add-zsh-hook
autoload -Uz add-zsh-hook

# See: http://www.clear-code.com/blog/2011/9/5.html
# See: http://stackoverflow.com/questions/10564314/count-length-of-user-visible-string-for-zsh-prompt
# See: http://stackoverflow.com/questions/2267155/what-does-sstring-kf1-bbkf-mean
# See: http://aperiodic.net/phil/prompt/
# See: http://zsh.sourceforge.net/Guide/zshguide05.html
#
function _update_prompt() {  # {{{
    if [[ "${UID}" == 0 ]]; then
        ## root のプロンプト
        #
        # プロンプト1段目の左側: "ユーザ名 at ホスト名 in " (color: red)
        local user_info="%{$fg_bold[red]%}%n%{$reset_color%} at %{$fg_bold[red]%}%m%{$reset_color%} in "
        # プロンプト1段目の左側: "ユーザ名@ホスト名 " (color: red)
        #local user_info="%F{red}%n@%m%f "

        # 変数展開を利用して user_info が画面上を占める幅を求める。
        local zero='%([BSUbfksu]|([FB]|){*})'  # 取り除くパターン
        local user_info_size=${#${(S%%)user_info//$~zero/}}

        # 端末の横幅(COLUMNS)から user_info_size 引いた結果: パスに使える幅
        local cwd_size
        (( cwd_size = ${COLUMNS} - ${user_info_size} - 1 ))

        # プロンプト1段目右側: フルパスを表示 (color: blue)
        # cwd_size をオーバーする場合は左側(上の階層側)を...で省略
        local cwd="%{$fg_bold[blue]%}%${cwd_size}<...<%~%<<%{$reset_color%}"

        # プロンプト1段目
        local upper_prompt="${user_info}${cwd}"

        # 顔文字。直前のコマンドの成否で変化する。0: (o_o), 0以外: (@_@)
        local zsh_face="%(?.%{$fg_bold[blue]%}(o_o)%{$reset_color%}.%{$fg_bold[red]%}(@_@%)[%?]%{$reset_color%})"

        # GNU Screen 上ではウインドウ番号を表示する。
        local screen_winnr="${WINDOW:+"[${WINDOW}]"}"

        # 2段目のプロンプト: ジョブ数 顔文字 screenウインドウ番号
        local lower_prompt="jobs:%j ${zsh_face}${screen_winnr}"

        # %#: rootでは#, 一般ユーザでは%
        #
        PROMPT="${upper_prompt}"$'\n'"${lower_prompt}%# "
    else
        ## root 以外用のプロンプト
        #
        # プロンプト1段目の左側: "ユーザ名 at ホスト名 in " (color: green)
        local user_info="%{$fg_bold[green]%}%n%{$reset_color%} at %{$fg_bold[green]%}%m%{$reset_color%} in "
        # プロンプト1段目の左側: "ユーザ名@ホスト名 " (color: green)
        #local upper_left="%F{green}%n@%m%f "

        # 変数展開を利用して user_info が画面上を占める幅を求める。
        local zero='%([BSUbfksu]|([FB]|){*})'  # 取り除くパターン
        local user_info_size=${#${(S%%)user_info//$~zero/}}

        # 端末の横幅(COLUMNS)から user_info_size 引いた結果: パスに使える幅
        local cwd_size
        (( cwd_size = ${COLUMNS} - ${user_info_size} - 1 ))

        # プロンプト1段目右側: フルパスを表示 (color: yellow)
        # cwd_size をオーバーする場合は左側(上の階層側)を...で省略
        local cwd="%{$fg_bold[yellow]%}%${cwd_size}<...<%~%<<%{$reset_color%}"

        # プロンプト1段目
        local upper_prompt="${user_info}${cwd}"

        # 顔文字。直前のコマンドの成否で変化する。 0: (*'_'), 0以外: (*@_@)
        local zsh_face="%(?.%{$fg_bold[blue]%}(*'_')%{$reset_color%}.%{$fg_bold[red]%}(*@_@%)[%?]%{$reset_color%})"

        local -a env_info

        # ssh でログインされているときは [ssh] と表示する
        [[ -n "${SSH_TTY}" ]] && env_info+='[ssh]'

        # GNU Screen 上でウインドウ番号を表示する
        [[ -n "${WINDOW}" ]] && env_info+="[${WINDOW}]"

        # tmux 上でウインドウ番号とペインの番号を表示する
        [[ -n "${TMUX}" ]] && env_info+="$(command tmux display -p '[#I-#P]')"

        # vim の :shell コマンドで起動されているときは [vim] と表示する
        [[ -n "${VIMRUNTIME}" ]] && env_info+='[vim]'

        # プロンプト2段目: ジョブ数 顔文字 環境情報
        local lower_prompt="jobs:%j ${zsh_face}${(j::)env_info}"

        # MEMO:
        # $'\n': 改行
        # %h or %!: ヒストリ数
        # %*: 時刻(hh:mm:ss)
        #
        # 仕上げ: 改行で繋いで '> ' を付け加える。
        PROMPT="${upper_prompt}"$'\n'"${lower_prompt}> "

        # MEMO: パス短縮の例
        # %(5~,%-2~/.../%2~,%~)
        # See: http://0xcc.net/blog/archives/000032.html
    fi
}  # }}}
add-zsh-hook precmd _update_prompt

# コマンド訂正のプロンプト
if [[ "${UID}" == 0 ]]; then
    SPROMPT="%{$fg_bold[red]%}(o_o%)? correct '%R' to '%r' [nyae]?%{$reset_color%} "
else
    SPROMPT="%{$fg_bold[red]%}(*'_'%)? もしかして: '%r' [そう(y), ちゃう(n),a,e]:%{$reset_color%} "
fi

## 右プロンプトにVCS情報を表示 {{{

# See: http://qiita.com/items/8d5a627d773758dd8078

RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz colors

# 以下の3つのメッセージをエクスポートする
#   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
#   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
#   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git svn hg bzr
# 標準のフォーマット(git 以外で使用)
# misc(%m) は通常は空文字列に置き換えられる
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true


if is-at-least 4.3.10; then
    # git 用のフォーマット
    # git のときはステージしているかどうかを表示
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "+"    # %c で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "-"  # %u で表示する文字列
fi

# hooks 設定
if is-at-least 4.3.11; then
    # git のときはフック関数を設定する

    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    # のメッセージを設定する直前のフック関数
    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
    # 各関数が最大3回呼び出される。
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch \
                                            git-stash-count

    # フックの最初の関数
    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
    # (.git ディレクトリ内にいるときは呼び出さない)
    # .git ディレクトリ内では git status --porcelain などがエラーになるため
    function +vi-git-hook-begin() {  # {{{
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }  # +vi-git-hook-begin }}}

    ### untracked ファイル表示 ###
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {  # {{{
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "${1}" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # unstaged (%u) に追加
            hook_com[unstaged]+='?'
        fi
    }  # +vi-git-untracked }}}

    ### push していないコミットの件数表示 ###
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {  # {{{
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # master ブランチでない場合は何もしない
            return 0
        fi

        # push していないコミット数を取得する
        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "${ahead}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="(p${ahead})"
        fi
    }  # +vi-git-push-status }}}

    ### マージしていない件数表示 ###
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {  # {{{
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # master ブランチの場合は何もしない
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "${nomerged}" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
        fi
    }  # +vi-git-nomerge-branch }}}


    # stash 件数表示
    #
    # stash している場合は :SN という形式で misc (%m) に表示
    function +vi-git-stash-count() {  # {{{
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+=":S${stash}"
        fi
    }  # +vi-git-stash-count }}}

fi

function _update_vcs_info_msg() {  # {{{
    if [[ -n "$disable_rprompt" ]]; then
        RPROMPT="%F{red}--%f"
        return 0
    fi

    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z "${vcs_info_msg_0_}" ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="${prompt}"
}  # _update_vcs_info_msg }}}
add-zsh-hook precmd _update_vcs_info_msg

# }}}

# }}}

# Change the title of an xterm {{{

# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss4.1
if [[ "${TERM}" =~ '^xterm' ]]; then
    function _change_xterm_title() {
        print -Pn "\e]0;%n@%m: %~\a"
    }
    add-zsh-hook precmd _change_xterm_title
fi

# }}}

# History {{{

# 履歴を保存するファイル
HISTFILE="${ZDOTDIR}/.zsh_history"
# メモリ内の履歴の数
HISTSIZE=1000000
# 保存される履歴の数
SAVEHIST=1000000

# 履歴にコマンド実行時刻と実行時間を記録
setopt extended_history
# 同じコマンドを連続で実行したときは記録しない
setopt hist_ignore_dups
# 既にあるコマンド行は古い方を削除
setopt hist_ignore_all_dups
# コマンドラインの余計なスペースを排除
setopt hist_reduce_blanks
# 履歴ファイルを共有する
setopt share_history
# すぐに履歴ファイルに追記する
setopt inc_append_history
# 先頭に空白を入れたときは記録しない
setopt hist_ignore_space
# ヒストリを呼び出してから実行する間に一旦編集可能にする
setopt hist_verify
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 出力停止、開始にC-s/C-qを使わない
setopt no_flow_control
# 全てのヒストリを表示
function history-all() { history -E 1 }

# }}}

# Search history {{{

#autoload -Uz history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^P" history-beginning-search-backward-end
#bindkey "^N" history-beginning-search-forward-end

# カーソルがコマンドラインの上端or下端に達したときだけ履歴検索をする
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

# }}}

## setopt {{{

# Use zsh completion system!
autoload -Uz compinit
compinit -i
# compinit -u : すべての発見したファイルを使用
# compinit -i : すべての安全でないファイルとディレクトリを無視
# compinit -C : セキュリティチェック全体をスキップする

# ディレクトリ名を入力するだけで移動
setopt auto_cd
# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧表示
setopt auto_pushd

# --prefix=~/localというように「=」の後でも
#「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

# 補完時に濁点・半濁点を<3099>、<309a>のようにさせない
setopt combining_chars
# コマンド訂正
setopt correct
# 補完候補を詰めて表示する
setopt list_packed
# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep
# エイリアスを設定したコマンドでも補完機能を使えるようにする
setopt complete_aliases
# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs
# 補完候補一覧でファイルの種別をマーク表示
setopt list_types
# globを展開しないで候補の一覧から補完する。
setopt glob_complete
# 補完時にヒストリを自動的に展開
setopt hist_expand
# 補完候補がないときなどにビープ音を鳴らさない。
setopt no_beep
# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl
# Use #, ~ and ^ as regular expression
setopt extended_glob
# 明確なドットの指定なしで.から始まるファイルを補完
setopt globdots

# Don't push multiple copies of the same directory onto the directory stack.
# ディレクトリスタックに重複するものを記録しない
setopt pushd_ignore_dups

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
# C-dでログアウトしない
setopt ignore_eof
# プロンプトを表示したまま補完候補をスクロールする
setopt always_last_prompt

# }}}

## zstyle {{{

# Fuzzy match
#zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補でオプションとかの表示をするときに左右を分けてる部分の設定
zstyle ':completion:*' list-separator '-->'

# 補完候補を矢印キーなどで選択可能にする
zstyle ':completion:*' menu select

# 補完候補をLS_COLORSに合わせて色付け
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# cd ../ するときに今いるディレクトリを補完候補から外す
zstyle ':completion:*:cd:*' ignore-parents parent pwd ..

# 補完候補をキャッシュする
zstyle ':completion:*' use-cache true

# 詳細な情報を使う
zstyle ':completion:*' verbose yes

# 補完関数の表示を過剰にする
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

# 補完時のメッセージの形式
zstyle ':completion:*:descriptions' format '%F{yellow}%BCompleting%b%f %B%d%b'
#zstyle ':completion:*:messages' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}No matches for:%f %F{yellow}%d%f'
#zstyle ':completion:*:corrections' format '%F{yellow}%B%d %F{red}(errors: %e)%b%f'

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# manの補完をセクション番号別に表示させる
zstyle ':completion:*:manuals' separate-sections true

# 補完から除くパターン
zstyle ':completion:*:*files' ignored-patterns '.DS_Store'

# gitの自作サブコマンドを補完する
zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}

# }}}

# chpwd_recent_dirs (cdr) {{{

if is-at-least 4.3.11; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':chpwd:*' recent-dirs-max 512
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':completion:*' recent-dirs-insert always
    #zstyle ':chpwd:*' recent-dirs-file "${ZDOTDIR}/.chpwd-recent-dirs"
fi

# }}}

## Misc {{{

# 実行したプロセスの消費時間が3秒以上かかったら
# 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

## スラッシュを単語の一部と見なさない
## ==> C-w の単語削除時にディレクトリ単位で(スラッシュごとに)削除できる
#WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
## 「|」も単語区切りと見なす
#WORDCHARS="${WORDCHARS}|"

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# ==> / を区切りとして扱えば、^W でディレクトリ単位の削除ができる
zstyle ':zle:*' word-chars " /=;@:{},"
zstyle ':zle:*' word-style unspecified

# }}}

## Aliases {{{

# Global aliases (works only on zsh)
alias -g L="| ${PAGER}"
alias -g G='| grep'
alias -g TW='| tw --pipe'
alias -g V='| vim -'

#alias -s pdf='open -a Preview.app'
#alias -s html='vim'

alias cd-='cd -'

if [[ "$(uname)" =~ 'Darwin' ]] && (( $+commands[sw_vers] )); then
    # MacOS用
    # topコマンド (CPU使用率ソート)
    # 項目: PID,コマンド名,ユーザ,CPU使用率,メモリ,スレッド,状態,時間
    alias top='top -o cpu -stats pid,command,user,cpu,rsize,vsize,th,pstate,time'
fi

# color ls
case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color=auto'
        ;;
esac

# ls related
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -aFlrt'

# grep related
if (( $+commands[ggrep] )); then
    alias egrep='ggrep --color=auto -E'
    alias fgrep='ggrep --color=auto -F'
    alias grep='ggrep --color=auto'
else
    alias egrep='grep --color=auto -E'
    alias fgrep='grep --color=auto -F'
    alias grep='grep --color=auto'
fi

# tree コマンドで日本語を表示する
alias tree='tree -N'

# tmux のセッションがあればアタッチする
alias tmuxx='tmux a || tmux'

# Use MacVim.
if [[ -d '/Applications/MacVim.app/Contents/MacOS' ]]; then
    # Use MacVim's binary on Terminal.
    alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
    alias vimdiff='/Applications/MacVim.app/Contents/MacOS/vimdiff'
    alias view='/Applications/MacVim.app/Contents/MacOS/view'

    # Use GUI MacVim.
    alias mvim='/Applications/MacVim.app/Contents/MacOS/mvim'
    alias mvimdiff='/Applications/MacVim.app/Contents/MacOS/mvimdiff'
    alias mview='/Applications/MacVim.app/Contents/MacOS/mview'
fi

# Minimal vim for emergency
alias vi='vim -u NONE -i NONE -N'

alias v=vim
alias j='jobs -l'
alias f=fg
alias h=history
alias c='printf "\017\033c"; stty sane; reset'
alias lang-c='env LC_ALL=C LANG=C'
alias date-iso8601='LANG=C date +%Y%m%dT%H%M%S%z'

(( $+commands[xdg-open] )) && alias xo=xdg-open || :

# }}}

## chpwd {{{

# See: http://qiita.com/yuyuchu3333/items/b10542db482c3ac8b059
function ls_abbrev() {  # {{{
    if [[ ! -r "${PWD}" ]]; then
        return
    fi
    # -a : Do not ignore entries starting with ..
    # -A : Show all except . and ..
    # -C : Force multi-column output.
    # -F : Append indicator (one of */=>@|) to entries.
    local cmd_ls='ls'
    local -a opt_ls
    opt_ls=('-ACF' '--color=always' '--group-directories-first' --ignore=Icon$'\r')
    case "${OSTYPE}" in
        freebsd*|darwin*)
            if (( $+commands[gls] )); then
                cmd_ls='gls'
            else
                # -G : Enable colorized output.
                opt_ls=('-ACFG')
            fi
            ;;
    esac

    local ls_result
    ls_result=$(CLICOLOR_FORCE=1 COLUMNS="${COLUMNS}" \
        command "${cmd_ls}" "${opt_ls[@]}" | sed $'/^\e\[[0-9;]*m$/d')

    local ls_lines=$(echo "${ls_result}" | wc -l | tr -d ' ')
    local prompt_lines=$(print -P "${PROMPT}" | wc -l | tr -d ' ')
    local remaining_lines=$[LINES - (prompt_lines * 2) - 4]

    if [[ "${ls_lines}" -gt "${remaining_lines}" ]]; then
        echo "${ls_result}" | head -n $[remaining_lines / 2]
        echo '...'
        echo "${ls_result}" | tail -n $[remaining_lines / 2]
        echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist."
    else
        echo "${ls_result}"
    fi
}  # ls_abbrev }}}
#autoload -Uz ls_abbrev
add-zsh-hook chpwd ls_abbrev

# }}}

## Incremental completion on zsh {{{

# See: http://mimosa-pudica.net/zsh-incremental.html
source "${ZDOTDIR}/plugin/incr-0.2.zsh"

# }}}

## auto-fu.zsh {{{

#if [[ -f "${HOME}/auto-fu/auto-fu.zsh" ]]; then
#    source "${HOME}/auto-fu/auto-fu.zsh"
#    function zle-line-init () {
#    auto-fu-init
#}
#zle -N zle-line-init
#zstyle ':completion:*' completer _oldlist _complete
#fi

# }}}

## zaw.zsh {{{

if [[ -f "${ZDOTDIR}/zaw/zaw.zsh" ]]; then
    source "${ZDOTDIR}/zaw/zaw.zsh"
    bindkey '^R' zaw-history
fi

# }}}

## zsh-syntax-highlighting {{{
#
# See: https://github.com/zsh-users/zsh-syntax-highlighting
if [[ -f "${ZDOTDIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]
then
    source "${ZDOTDIR}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# }}}

## For GNU Screen {{{

# キャプションにディレクトリ名か実行中のコマンド名表示
# See: http://masutaka.net/chalow/cat_zsh.html
if [[ "${TERM}" == 'screen' && -n "$WINDOW" ]]; then
    function _screen_nice_caption_precmd() {
        echo -ne "\ek$(basename $(pwd))\e\\"
    }
    add-zsh-hook precmd _screen_nice_caption_precmd

    function _screen_nice_caption_preexec() {
        echo -ne "\ek#${1%% *}\e\\"
    }
    add-zsh-hook preexec _screen_nice_caption_preexec
fi

# }}}

## Misc {{{

# Tab連打で順に補完候補を自動で補完
setopt auto_menu

# Shift-Tabで補完候補を逆順に回る
bindkey "^[[Z" reverse-menu-complete

# zsh editor
autoload -Uz zed

# ztodo: simple per-directory todo list manager (+completion).
if [[ -f "$(echo ${^fpath}/ztodo(N))" ]]; then
    autoload -Uz ztodo
    add-zsh-hook chpwd ztodo
fi

# tetris (Usage: M-x tetris RET)
#autoload -Uz tetris; zle -N tetris

# 以前に実行したコマンドを入力するコマンド"r"の無効化
#disable r

for fn in $ZDOTDIR/functions/*
do
    autoload -Uz "${fn:t}"
done
unset fn

# command_not_found_handler (Ubuntu only?)
if [[ -f '/etc/zsh_command_not_found' ]]; then
    source '/etc/zsh_command_not_found'
fi

# C-lでrehashもする
# See: http://d.hatena.ne.jp/shinichiro_h/20080424/1208971521
function _clear-screen-with-rehash() {
    zle clear-screen
    rehash
    zle reset-prompt
}
zle -N _clear-screen-with-rehash
bindkey '^L' _clear-screen-with-rehash

function toggle-rprompt() {
    [[ -z "$disable_rprompt" ]] && disable_rprompt=1 || disable_rprompt=
}

# }}}

## Load local and temporary config file {{{

if [[ -f "${HOME}/.zshrc.local" ]]; then
    source "${HOME}/.zshrc.local"
fi

# }}}

# __END__
# vim: fdm=marker ts=4 sw=4 sts=4 et:
