(require 'paren)
(require 'rainbow-delimiters)
(require 'smartparens-config)
(require 'smartparens)

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))

; Less nasty face for pair-overlay
(set-face-attribute 'sp-pair-overlay-face nil :background "#443152")

(defvar mode-hooks '(clojure-mode-hook
		     emacs-lisp-mode-hook
		     scheme-mode-hook
		     lisp-mode-hook
                     racket-mode-hook
                     clojurescript-mode-hook))

(dolist (mode-hook mode-hooks)
  (add-hook mode-hook
            (lambda ()
              (smartparens-mode)
              (rainbow-delimiters-mode)
              (electric-pair-mode t)
              (show-paren-mode)
              (setq show-paren-style 'expression))))



(provide 'lisps-parenthesis-enhancements)
