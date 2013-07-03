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

Sublime Text 2 でも使えるようにする方法。

### 1. `<root>`の下に、以下のように`<appdef>...</appdef>`を追加する。

```
<root>
  <appdef>
    <appname>SUBLIMETEXT</appname>
    <equal>com.sublimetext.2</equal>
  </appdef>

  <item>
  ...
  </item>
</root>
```

### 2. `<only>TERMINAL, VI</only>`を`<only>TERMINAL, VI, SUBLIMETEXT</only>`に変更する。
