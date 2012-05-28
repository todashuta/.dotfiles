# .bashrc
# https://github.com/todashuta/profiles

# プロンプトのカスタマイズ
PS1='\u@\h:\w\n\$ '

# ローカル設定があれば読み込む
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# end of .bashrc
