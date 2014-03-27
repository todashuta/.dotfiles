;;; init.el (Emacs setting)
;;; https://github.com/todashuta/profiles
;      ___           ___                        ___           ___
;     /\__\         /\  \                      /\__\         /\__\
;    /:/ _/_       |::\  \      _______       /:/  /        /:/ _/_
;   /:/ /\__\      |:::\  \    /::::\  \     /:/  /        /:/ /\  \
;  /:/ /:/ _/_   __|:|\:\  \  |:^^^\:\  \   /:/  /  ___   /:/ /::\  \
; /:/ /:/ /\__\ /::::|_\:\__\ |:|  /::\__\ /:/__/  /\__\ /:/ /:/\:\__\
; \:\/:/ /:/  / \:\^^\  \/__/ |:| /:/\/__/ \:\  \ /:/  / \:\/:/ /:/  /
;  \::/ /:/  /   \:\  \       |:\/:/  /     \:\  /:/  /   \::/ /:/  /
;   \:\/:/  /     \:\  \       \::/__/       \:\/:/  /     \/_/:/  /
;    \::/  /       \:\__\       \:\__\        \::/  /        /:/  /
;     \/__/         \/__/        \/__/         \/__/         \/__/


;;; 日本語
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)


;;; Emacsのバージョンで分ける {{{

;;; Emacs version 23 以前用
(when (<= emacs-major-version 23)
  (progn
    (load (expand-file-name "~/.emacs.d/23/init.el"))
    (if window-system
      (load (expand-file-name "~/.emacs.d/23/window-system.el")))))

;;; Emacs version 24 以降用
(when (>= emacs-major-version 24)
  (progn
    (load (expand-file-name "~/.emacs.d/24/init.el"))
    (if window-system
      (load (expand-file-name "~/.emacs.d/24/window-system.el")))))

;;; }}}


;; vim: set foldmethod=marker et:
;; __END__
