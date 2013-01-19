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

;;; Emacs version 23以前用
(when (<= emacs-major-version 23)
      (load "~/.emacs.d/23/general.el")
        (if window-system
          (progn
            (load "~/.emacs.d/23/window-system.el")
)))

;;; Emacs version 24以降用
(when (>= emacs-major-version 24)
      (load "~/.emacs.d/24/general.el")
        (if (window-system)
            (progn
              (load "~/.emacs.d/24/window-system.el")
)))

;;; }}}


;; vim:foldmethod=marker
;; end  of init.el
