;; emacs settings

;; == Window ==========================
(if window-system (progn
   (set-frame-parameter nil 'alpha '(82 55))  ;; 透明度(アクティブ 非アクティブ)
   (set-background-color "Black")  ;; 背景色
   (set-foreground-color "LightGray")  ;; 前景色
   (set-cursor-color "Yellow")  ;; Gray,Yellow など
   (blink-cursor-mode 0)  ;; カーソルの点滅を止める
   (tool-bar-mode nil)  ;; ツールバーなし
   (set-scroll-bar-mode 'right)  ;; スクロールバー右側
;   (set-default 'line-spacing 7)  ;; 表示の行間を拡げる
   ))

;; == Window size =====================
;; 初期フレームの設定
(setq initial-frame-alist
      '((width . 80)    ; フレーム幅(文字数)
        (height . 32)   ; フレーム高(文字数)
;        (top . 22)
;        (left . 3)
        ))

;; 新規フレームのデフォルト設定
(setq default-frame-alist
      '((width . 80)    ; フレーム幅(文字数)
        (height . 24))  ; フレーム高(文字数)
        )

;; == For Mac (Carbon Emacs) ==========
;; フォントの変更 (fixed-width-fontset: carbon-font)
;; 使えるフォント："hiramaru" "hirakaku_w3" "hirakaku_w6" "hirakaku_w8" "hiramin_w3" "hiramin_w6" "osaka"
;; 使えるサイズ：7, 8, 9, 10, 12, 14, 16, 18, 20, 24
(when (eq window-system 'mac)
  (require 'carbon-font)
  (fixed-width-set-fontset "hiramaru" 14))

;; その他Mac用設定
(when (eq window-system 'mac)
  (setq mac-allow-anti-aliasing t)  ;; Quartz 2D のアンチエイリアスを利用する
;  (mac-key-mode 1)  ;; Macのキーバインドを使う
;  (setq mac-option-modifier 'meta)  ;; optionをメタキーにする(通常はCommandキーorESCキー)
  )

;; == フォント設定 for Ubuntu =========
(when (eq system-type 'gnu/linux)
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "Black"
  :foreground "LightGray" :inverse-video nil :box nil :strike-through nil
  :overline nil :underline nil :slant normal :weight normal :height 120
  :width normal :foundry "unknown" :family "Ricty"))))))

;; == For Windows =====================
(when (eq system-type 'windows-nt)
(setq default-directory "C:/Users/SHU/")  ;; 初期ディレクトリの設定
(custom-set-faces
 '(default ((t (:inherit nil :stipple nil :background "Black"
  :foreground "LightGray" :inverse-video nil :box nil :strike-through nil
  :overline nil :underline nil :slant normal :weight normal :height 143
  :width normal :foundry "outline" :family "Ricty"))))))

;; == solarized =======================
;; color-theme を使う方式
;(add-to-list 'load-path "~/.emacs.d/site-lisp")
;(require 'color-theme)  ;; color-theme呼び出し
;(require 'color-theme-solarized)

;; "enable-theme"を使う方式
;(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-color-theme-solarized")
;(enable-theme 'solarized-dark)

;; end  of file
