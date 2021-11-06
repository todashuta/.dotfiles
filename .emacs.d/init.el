;;; init.el

(setq backup-directory-alist
      '((".*" . "~/var/emacs/backup")))
(setq auto-save-file-name-transforms
      '((".*" "~/var/emacs/autosave/" t)))  ;; 末尾のスラッシュ必要
(setq create-lockfiles nil)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file t)

;;; init.el ends here
