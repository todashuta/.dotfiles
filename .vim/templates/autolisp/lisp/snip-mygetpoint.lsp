(defun c:mygetpoint (/)
  (progn
    (prompt "ポイントを選択してください\n")
    (mapcar '(lambda (x) (acet-str-format "%1" (/ x 1000.0))) (getpoint))))
