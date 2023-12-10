(require 'org)
(let* ((safe-local-variable-values '((org-src-preserve-indentation . t))))
  (org-babel-load-file
   (expand-file-name (concat user-emacs-directory "README.org"))))
