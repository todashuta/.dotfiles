;;; init.el

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

(setq backup-directory-alist
      '((".*" . "~/var/emacs/backup")))
(setq auto-save-file-name-transforms
      '((".*" "~/var/emacs/autosave/" t)))  ;; 末尾のスラッシュ必要
(setq create-lockfiles nil)

(setq custom-file "~/.emacs.d/custom.el")
;(load custom-file t)

(setq inhibit-startup-message t)
(unless window-system
  (menu-bar-mode -1))

;(global-set-key "\C-h" 'delete-backward-char)

;(load-theme 'wombat t)

(provide 'init)

;;; init.el ends here
