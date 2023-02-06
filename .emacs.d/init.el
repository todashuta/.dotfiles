;;; init.el --- My init.el  -*- lexical-binding: t; -*-

(eval-and-compile
  (customize-set-variable
   'package-archives '(("org" . "https://orgmode.org/elpa/")
		       ("melpa" . "https://melpa.org/packages/")
		       ("gnu" . "https://elpa.gnu.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf el-get :ensure t)
    (leaf blackout :ensure t)

    :config
    (leaf-keywords-init)))

(leaf cus-edit
  :doc "tools for customizing Emacs and Lisp packages"
  :tag "builtin" "faces" "help"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf cus-start
  :custom (
	   (truncate-lines . t)
	   (tool-bar-mode . nil)
	   (scroll-bar-mode . nil)
	   (inhibit-startup-message . t)
	   ;(menu-bar-mode . nil)
	   )
  :config
  (custom-set-faces '(default ((t (:family "UDEV Gothic JPDOC" :foundry "outline" :slant normal :weight normal :height 113 :width normal)))))
  (custom-set-faces '(mode-line ((t (:family "UDEV Gothic JPDOC" :foundry "outline" :slant normal :weight bold :height 113 :width normal)))))
  ;(set-fontset-font t 'japanese-jisx0208 (font-spec :family "BIZ UD明朝"))

  (when window-system (set-frame-size (selected-frame) 120 35))
  )

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
	     (imenu-list-position . 'left))))

(leaf go-mode
  :ensure t)

(leaf web-mode
  :ensure t
  :mode "\\.json\\'"
  :config
  ;(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
  ;(add-hook 'web-mode-hook 'lsp)
  )

(leaf company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(leaf lsp-mode
  :ensure t
  :require t
  :custom ((lsp-keymap-prefix . "C-c l"))
  :config
  (add-hook 'go-mode-hook #'lsp)
  )

(leaf afternoon-theme
 :ensure t
 :config
 (load-theme 'afternoon t))

;; (leaf highlight-indent-guides
;;   :ensure t
;;   :config
;;   (custom-set-variables
;;    '(highlight-indent-guides-method (quote fill))
;;    '(highlight-indent-guides-responsive (quote top)))
;;   (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(leaf paren
  :custom
  ((show-paren-style . 'mixed))
  :hook
  (emacs-startup-hook . show-paren-mode))

(leaf line-number-mode
  :custom
  ((linum-format . "%5d ")))

(leaf magit
  :ensure t
  :require t)

(leaf git-gutter
  :ensure t
  :require t
  :config
  ;(global-git-gutter-mode t)
  )

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(setq backup-directory-alist
      '((".*" . "~/var/emacs/backup")))
(setq auto-save-file-name-transforms
      '((".*" "~/var/emacs/autosave/" t)))  ;; 末尾のスラッシュ必要
(setq create-lockfiles nil)

;(setq custom-file "~/.emacs.d/custom.el")
;(load custom-file t)

(unless window-system
  (menu-bar-mode -1))

;(global-set-key "\C-h" 'delete-backward-char)

;(load-theme 'wombat t)

(provide 'init)

;;; vim: set ts=8:
;;; init.el ends here
