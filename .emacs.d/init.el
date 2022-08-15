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

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
	     (imenu-list-position . 'left))))

(leaf go-mode
  :ensure t)

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

(setq inhibit-startup-message t)
(unless window-system
  (menu-bar-mode -1))

;(global-set-key "\C-h" 'delete-backward-char)

;(load-theme 'wombat t)

(provide 'init)

;;; init.el ends here
