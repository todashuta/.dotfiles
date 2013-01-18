# private.xml

[KeyRemap4MacBook](http://pqrs.org/macosx/keyremap4macbook/index.html.ja)用カスタム設定 for Vimmer

- Leave Insert Mode with EISUU on Terminal
	- `Escape` to `EISUU + Escape`
	- `Control + C` to `EISUU + Control + C`
	- `Control + [` to `EISUU + Control + [`

GUI版MacVimでは、挿入モードから抜けるときに自動で日本語入力のオフができるが、ターミナルでVimを使うときにも同じ事を実現したい。

`Escape`を`EISUU + Escape`にする設定は元から用意されていた。しかし、MacBook Air の`Escape`キーが小さくて使いづらいので、Vimで挿入モードから抜けるときはほとんど`Control + [`を使っている。というわけでオリジナルの設定が必要になった。

とりあえずググってみたところ`Control + C`を`EISUU + Control + C`にする設定を書いてる記事を見つけたが、一番求めている`Control + [`を`EISUU + Control + [`にする設定は発見できなかったので追加で作ってまとめた。

## Appendix

この private.xml では Sublime Text 2 でも使えるように設定をいくつか追加している。  
単にターミナル上のVimだけで使えるようにしたいだけであれば、以下のとおり。

	<?xml version="1.0"?>
	<root>
	  <item>
	    <name>Leave Insert Mode with EISUU on Terminal</name>
	    <appendix>Escape to EISUU+Escape</appendix>
	    <appendix>Control+C to EISUU+Control+C</appendix>
	    <appendix>Control+[ to EISUU+Control+[</appendix>
	    <identifier>private.app_terminal_esc_with_eisuu</identifier>
	    <only>TERMINAL, VI</only>
	    <autogen>--KeyToKey-- KeyCode::BRACKET_LEFT, VK_CONTROL, KeyCode::BRACKET_LEFT, VK_CONTROL, KeyCode::JIS_EISUU</autogen>
	    <autogen>--KeyToKey-- KeyCode::C, VK_CONTROL, KeyCode::C, VK_CONTROL, KeyCode::JIS_EISUU</autogen>
	    <autogen>--KeyToKey-- KeyCode::ESCAPE, KeyCode::ESCAPE, KeyCode::JIS_EISUU</autogen>
	  </item>
	</root>

既に private.xml に設定を記述していて追加する場合は`<item>…(省略)…</item>`を追加する。
