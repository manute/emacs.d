(defun js-add-breakpoint ()
  "Add a break point"
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent)
  (insert "debugger")
  (highlight-lines-matching-regexp "^[ ]*debugger"))

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(define-key js2-mode-map (kbd "C-c C-b") 'js-add-breakpoint)

(provide 'init-js)
