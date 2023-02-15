;; -*- lexical-binding: t; -*-

(defconst my:saved-file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)
(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq file-name-handler-alist my:saved-file-name-handler-alist)))

(setq frame-inhibit-implied-resize t)

(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq inhibit-redisplay t)
(setq inhibit-message t)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq inhibit-redisplay nil)
            (setq inhibit-message nil)
            (redisplay)))

(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(provide 'early-init)
;;; early-init.el ends here
