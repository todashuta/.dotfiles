# .zshrc
# https://github.com/todashuta/profiles

profiles=${HOME}/.profiles.d
source ${profiles}/functions

## General {{{

# Emacs like keybind
bindkey -e

## zcompile
#zcompile ${ZDOTDIR}/.zshrc

# }}}

## fpathの設定 {{{
#
# Memo: fpathは'compinit'より前に記述しないと機能しないらしい。
# Memo: 'compinit'より後に記述してたとき機能したものの起動が遅くなった。

# 重複したパスを登録しない
typeset -U fpath
# パスの設定
fpath=(
    # zsh-completions
    /usr/local/share/zsh-completions(N-/)
    ${HOME}/.repos/zsh-completions/src(N-/)

    $fpath)

# }}}

## Prompt {{{

# プロンプト内で変数展開・コマンド置換・算術演算を実行する
setopt prompt_subst
# プロンプト内で「%」で始まる置換機能を有効にする
setopt prompt_percent
# コピペしやすいようにコマンド実行後は右プロンプトを消す
setopt transient_rprompt

# colors
autoload -Uz colors && colors

# See: http://www.clear-code.com/blog/2011/9/5.html
# プロンプトが占める文字数を返す関数。
# 日本語は未対応らしいので英数字だけの User@Host をカウントするのにのみ利用。
count_prompt_characters()
{
    print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | wc -m | sed -e 's/ //g'
}

_update_prompt(){
    case ${UID} in
    0)  #### rootのプロンプト ####
        # プロンプト上段の左側: User@Host (color: red)
        local prompt_left="%F{red}%n@%m%f"

        # prompt_left が画面上を占める幅をカウントする。
        local prompt_left_length=$(count_prompt_characters "${prompt_left} ")

        # 端末の横幅から prompt_left の幅を引いた結果を求める
        # $COLUMNS: 端末の横幅
        local prompt_rest_length=$[COLUMNS - prompt_left_length]

        # プロンプト上段の右側:
        # prompt_rest_length に収まる長さのフルパス (color: blue)
        # 幅に収まらない分は左側(上の階層側)を...で省略
        local prompt_right="%F{blue}%${prompt_rest_length}<...<%~%<<%f"

        # 1段目のプロンプト: User@Host 画面幅に収まる分のフルパス。
        local first_prompt="${prompt_left} ${prompt_right}"

        # 顔文字。直前のコマンドの成否で変化する。0: (o_o), 0以外: (@_@)
        local zsh_face="%(?.%F{blue}(o_o)%f.%F{red}(@_@%)%f)"

        # GNU Screen 上ではウインドウ番号を表示する。
        local screen_winnr="${WINDOW:+"[$WINDOW]"}"

        # 2段目のプロンプト: ジョブ数 顔文字 screenウインドウ番号
        local secondary_prompt="jobs:%j ${zsh_face}${screen_winnr}"

        # %#: rootでは#, 一般ユーザでは%
        #
        PROMPT="${first_prompt}"$'\n'"${secondary_prompt}%# "

        # コマンド訂正のプロンプト
        SPROMPT="%F{red}(o_o%)? correct '%R' to '%r' [nyae]?%f "
        ;;
    *)  #### Not a root. ####
        # プロンプト上段の左側: User@Host (color: green)
        local prompt_left="%F{green}%n@%m%f"

        # prompt_left が画面上を占める幅をカウントする。
        local prompt_left_length=$(count_prompt_characters "${prompt_left} ")

        # 端末の横幅から prompt_left の幅を引いた結果を求める
        # $COLUMNS: 端末の横幅
        local prompt_rest_length=$[COLUMNS - prompt_left_length]

        # プロンプト上段の右側:
        # prompt_rest_length に収まる長さのフルパス (color: yellow)
        # 幅に収まらない分は左側(上の階層側)を...で省略
        local prompt_right="%F{yellow}%${prompt_rest_length}<...<%~%<<%f"

        # 1段目のプロンプト: User@Host 画面幅に収まる分のフルパス。
        local first_prompt="${prompt_left} ${prompt_right}"

        # 顔文字。直前のコマンドの成否で変化する。 0: (*'_'), 0以外: (*@_@)
        local zsh_face="%(?.%F{blue}(*'_')%f.%F{red}(*@_@%)%f)"

        # GNU Screen 上ではウインドウ番号を表示する。
        local screen_winnr="${WINDOW:+"[$WINDOW]"}"

        # 2段目のプロンプト: ジョブ数 顔文字 screenウインドウ番号
        local secondary_prompt="jobs:%j ${zsh_face}${screen_winnr}"

        # $'\n': 改行
        # %h or %!: ヒストリ数
        # %*: 時刻(hh:mm:ss)
        #
        # User@Host フルパス
        # ジョブ数 顔文字>
        PROMPT="${first_prompt}"$'\n'"${secondary_prompt}> "

        # パス短縮の例
        # See: http://0xcc.net/blog/archives/000032.html
        # %(5~,%-2~/.../%2~,%~)

        # コマンド訂正のプロンプト
        SPROMPT="%F{red}(*'_'%)? もしかして '%r' かな? [そう!(y), ちがう!(n),a,e]:%f "
        ;;
    esac
}
precmd_functions=($precmd_functions _update_prompt)


## 右プロンプトにVCS情報を表示 {{{

# See: http://qiita.com/items/8d5a627d773758dd8078

RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
#autoload -Uz colors

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
    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }

    # untracked ファイル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # unstaged (%u) に追加
            hook_com[unstaged]+='?'
        fi
    }

    # push していないコミットの件数表示
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {
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

        if [[ "$ahead" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # マージしていない件数表示
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {
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

        if [[ "$nomerged" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
        fi
    }


    # stash 件数表示
    #
    # stash している場合は :SN という形式で misc (%m) に表示
    function +vi-git-stash-count() {
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
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
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

    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg

# }}}

# }}}

# Change the title of an xterm {{{

# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss4.1
case $TERM in
xterm*)
    precmd () {print -Pn "\e]0;%n@%m: %~\a"}
    ;;
esac

# }}}

# History {{{

# 履歴を保存するファイル
HISTFILE=${ZDOTDIR}/.zsh_history
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
autoload -Uz compinit && compinit -u

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
zstyle ':completion:*' list-separator '==>'

# 補完候補を矢印キーなどで選択可能にする
zstyle ':completion:*:default' menu select

# 補完候補をLS_COLORSに合わせて色付け
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# cd ../ するときに今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

# 補完候補をキャッシュする
zstyle ':completion:*' use-cache true

# 詳細な情報を使う
zstyle ':completion:*' verbose yes

# 補完関数の表示を過剰にする
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

# }}}

## Misc {{{

# 実行したプロセスの消費時間が3秒以上かかったら
# 自動的に消費時間の統計情報を表示する。
REPORTTIME=3

# スラッシュを単語の一部と見なさない
# ==> C-w の単語削除時にディレクトリ単位で(スラッシュごとに)削除できる
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# 「|」も単語区切りと見なす
WORDCHARS="${WORDCHARS}|"

# }}}

## Aliases {{{

init_aliases    # at ${profiles}/functions

# Global aliases (works only on zsh)
alias -g L="| $PAGER"
alias -g G="| grep"
alias -g TW="| tw --pipe"
alias -g V="| vim -"

#alias -s pdf="open -a Preview.app"
#alias -s html="vim"

# }}}

## chpwd {{{

function chpwd() {

    # chpwdで自動でlsをするとき、ファイル数が多ければ上下5つだけ表示する
    # See: http://zshscreenvimvimpwget.blog27.fc2.com/blog-entry-10.html
    if [ 150 -le $(ls | wc -l) ]; then
        ls | head -n 5
        echo '...'
        ls | tail -n 5
        echo "$(ls | wc -l) files exist."
    else
        ls
    fi

    # Show the number of the current directory's ToDo.
    ztodo

    # Show the directory stack.
    #dirs
}

# }}}

## Incremental completion on zsh {{{

# See: http://mimosa-pudica.net/zsh-incremental.html
source ${ZDOTDIR}/plugin/incr*.zsh

# }}}

## auto-fu.zsh {{{

#if [ -f ${HOME}/auto-fu/auto-fu.zsh ]; then
#    source ${HOME}/auto-fu/auto-fu.zsh
#    function zle-line-init () {
#    auto-fu-init
#}
#zle -N zle-line-init
#zstyle ':completion:*' completer _oldlist _complete
#fi

# }}}

## zaw.zsh {{{

if [ -f ${HOME}/zaw/zaw.zsh ]; then
    source ${HOME}/zaw/zaw.zsh
    bindkey '^R' zaw-history
fi

# }}}

## zsh-syntax-highlighting {{{

# See: https://github.com/zsh-users/zsh-syntax-highlighting
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# }}}

## For GNU Screen {{{

# キャプションにディレクトリ名か実行中のコマンド名表示
# See: http://masutaka.net/chalow/cat_zsh.html
case "$TERM" in
screen)
    preexec() {
        echo -ne "\ek#${1%% *}\e\\"
    }
    precmd() {
        echo -ne "\ek$(basename $(pwd))\e\\"
    }
    ;;
esac

# }}}

## Misc {{{

# Tab連打で順に補完候補を自動で補完
setopt auto_menu

# Shift-Tabで補完候補を逆順に回る
bindkey "^[[Z" reverse-menu-complete

# zsh editor
autoload -Uz zed

# ztodo: simple per-directory todo list manager (+completion).
autoload -Uz ztodo

# tetris (Usage: M-x tetris RET)
#autoload -Uz tetris && zle -N tetris

# 以前に実行したコマンドを入力するコマンド"r"の無効化
#disable r

# }}}

## Load local and temporary config file {{{

if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi

# }}}

# __END__
# vim: fdm=marker ts=4 sw=4 sts=4 et:
