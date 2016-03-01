(use-package scheme-mode
  :config
  (use-package paren
    :ensure t
    :config
    (show-paren-mode)
    (setq show-paren-style 'expression)
    (electric-pair-mode t))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'scheme-mode-hook #'rainbow-delimiters-mode))

  (use-package smartparens
    :ensure t
    :config
    (add-hook 'scheme-mode-hook #'smartparens-mode)))

(use-package emacs-lisp-mode
  :config
  (use-package paren
    :ensure t
    :config
    (show-paren-mode)
    (setq show-paren-style 'expression)
    (electric-pair-mode t))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode))

  (use-package smartparens
    :ensure t
    :config
    (add-hook 'emacs-lisp--mode-hook #'smartparens-mode)))

(use-package lisp-mode
  :config
  (use-package paren
    :ensure t
    :config
    (show-paren-mode)
    (setq show-paren-style 'expression)
    (electric-pair-mode t))

  (use-package rainbow-delimiters
    :ensure t
    :config
    (add-hook 'lisp-mode-hook #'rainbow-delimiters-mode))

  (use-package smartparens
    :ensure t
    :config
    (add-hook 'lisp--mode-hook #'smartparens-mode)))

(provide 'init-lisp)
