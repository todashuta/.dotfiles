;;; init.el - Emacs configuration file.


;; 言語を日本語にする
(set-language-environment 'japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; linum
(when (require 'linum nil 'noerror)
  (require 'linum)
  (global-linum-mode t)
  (if window-system
    (setq linum-format "%4d")
    (setq linum-format "%3d ")))

;; hl-line-mode
(if window-system
  (global-hl-line-mode 1)
  (global-hl-line-mode -1))

;; Disable menu bar on CUI.
(if window-system
  (menu-bar-mode 1)
  (menu-bar-mode -1))

;; Disable tool bar.
(when window-system
  (tool-bar-mode -1))

;; Disable scrollbar.
(when window-system
  (scroll-bar-mode -1))

;; Disable bell.
(setq ring-bell-function 'ignore)

;; Disable startup message.
(setq inhibit-startup-message t)
;; Remove scratch buffer's initial message.
(setq initial-scratch-message "")


;; Key mappings.
(global-set-key "\C-h" 'delete-backward-char)
;(global-set-key "\M-g" 'goto-line)

;; cua-mode. (cuiではC-RET使えない)
(cua-mode t)
(setq cua-enable-cua-keys nil)


;; Use a mouse on the terminal.
;; unless: if !**  => if !has('gui_runnning') のようなもの
(unless window-system
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1))))


;; __END__


;;
;; el-get (master branch)
;;
(setq el-get-dir "~/.emacs.d/el-get")  ;; default
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync 'auto-complete)
(el-get 'sync 'anything)
(el-get 'sync 'helm)
(el-get 'sync 'git-gutter)
(el-get 'sync 'evil)
(el-get 'sync 'quickrun)
(el-get 'sync 'color-theme-tomorrow)
(el-get 'sync 'color-theme-solarized)
;(el-get 'sync 'color-theme-desert)
(el-get 'sync)

;;
;; auto-complete
;;
(when (require 'auto-complete-config nil 'noerror)
  (require 'auto-complete-config)
  (add-to-list 'ac-dictionary-directories
               "~/.emacs.d/el-get/auto-complete/dict")
  (ac-config-default)
  (setq ac-use-menu-map t)
  (when ac-use-menu-map
    (define-key ac-menu-map "\C-n" 'ac-next)
    (define-key ac-menu-map "\C-p" 'ac-previous))
  (define-key ac-mode-map [backtab] 'ac-previous)
  (setq ac-auto-start t)  ;; 自動的に作動させるか (t or nil)
  (unless ac-auto-start
    (ac-set-trigger-key "TAB")))  ;; 補完を作動させるキー(非自動スタート時)

;;
;; color-theme-tomorrow
;;
;(when (require 'color-theme-tomorrow nil 'noerror)
;  (require 'color-theme-tomorrow)
;  (color-theme-tomorrow-night)
;  (global-hl-line-mode 1))

;;
;; color-theme-desert
;;
;(when (require 'color-theme-desert nil 'noerror)
;  (require 'color-theme-desert)
;  (color-theme-desert))

;; カーソルの場所を保存する
(when (require 'saveplace nil 'noerror)
  (require 'saveplace)
  (setq-default save-place t))

;; ファイルメニューに最近使ったファイルを表示
(when (require 'recentf nil 'noerror)
  (require 'recentf)
  (recentf-mode 1))

;; "yes or no"を"y or n"に
(fset 'yes-or-no-p 'y-or-n-p)

;; *~ バックアップファイルを作らない(変更前のファイル)
(setq make-backup-files nil)
;; #* バックアップファイルを作らない(作業中ファイル)
(setq auto-save-default nil)

;; font
(when window-system
  ;; Mac OS
  (when (eq system-type 'darwin)
    (create-fontset-from-ascii-font
      "Inconsolata-16:weight=normal:slant=normal" nil "rictyinconsolata")
    (set-fontset-font "fontset-rictyinconsolata"
                      'unicode
                      (font-spec
                        :family "Ricty InvisibleZWS"
                        :size 16)
                      nil
                      'append)
    (add-to-list 'default-frame-alist '(font . "fontset-rictyinconsolata")))
  ;; Linux
  (when (eq system-type 'gnu/linux)
    (custom-set-faces
      '(default ((t (:weight normal
                     :height 120
                     :width normal
                     :family "Ricty"))))))
  ;; Windows
  (when (eq system-type 'windows-nt)
    (custom-set-faces
      '(default ((t (:weight normal
                     :height 120
                     :width normal
                     :family "Ricty")))))))

;; 初期ディレクトリの設定 (Windows)
(when (eq system-type 'windows-nt)
  (setq default-directory "~/"))

;; GUI関連 (Mac)
(when (and window-system (eq system-type 'darwin))
  ;; Quartz 2D のアンチエイリアスを利用する
  (setq mac-allow-anti-aliasing t))
