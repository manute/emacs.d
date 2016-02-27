(defvar mode-hooks '(clojure-mode-hook
		     emacs-lisp-mode-hook
		     scheme-mode-hook
		     lisp-mode-hook
                     racket-mode-hook
                     clojurescript-mode-hook))


(use-package paren
  :ensure t
  :config
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook
              (lambda ()
                (show-paren-mode)
                (setq show-paren-style 'expression)
                (electric-pair-mode t)))))


(use-package rainbow-delimiters
  :ensure t
  :config
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook rainbow-delimiters-mode)))


(use-package smartparens
  :ensure t
  :config
  (dolist (mode-hook mode-hooks)
    (add-hook mode-hook smartparens-mode)))


(provide 'lisps-parenthesis-enhancements)
