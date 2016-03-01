(use-package racket-mode
  :disabled t
  :mode ("\\.rkt\\'" . racket-mode)
  :config
  ;;(setq racket-racket-program /usr/local/bin/racket)
  ;;(setq racket-raco-program /usr/local/bin/raco)
  (add-hook 'racket-mode-hook
            (lambda ()
              (define-key racket-mode-map (kbd "C-c r") 'racket-run)))

 (use-package paren
    :ensure t
    :config
    (show-paren-mode)
    (setq show-paren-style 'expression)
    (electric-pair-mode t))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'racket-mode-hook #'rainbow-delimiters-mode))

  (use-package smartparens
    :ensure t
    :config
    (add-hook 'racket-mode-hook #'smartparens-mode)))

(provide 'init-racket)
