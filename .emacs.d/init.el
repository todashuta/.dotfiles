(if (version<= "29.1" emacs-version)
    (progn
      (org-babel-load-file
       (expand-file-name (concat user-emacs-directory "README.org"))))
  (error "init.el requires an Emacs version 29.1 or newer"))
