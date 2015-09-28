(require 'paren)
(require 'rainbow-delimiters)
(require 'smartparens-config)

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

(defvar mode-hooks '(clojure-mode-hook
		     emacs-lisp-mode-hook
		     scheme-mode-hook
		     lisp-mode-hook
                     racket-mode-hook))

(dolist (mode-hook mode-hooks)
  (add-hook mode-hook (lambda ()
                                        ;(paredit-mode)
                        (smartparens-mode)
			(rainbow-delimiters-mode)
                        (electric-pair-mode t)
			(show-paren-mode)
			(setq show-paren-style 'expression))))


(provide 'lisps-parenthesis-enhancements)
