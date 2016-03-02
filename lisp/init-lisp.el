
(add-hook 'emacs-lisp-mode-hook #'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook #'turn-on-eldoc-mode)
(show-paren-mode 1)

(use-package rainbow-delimiters
  :ensure t
  :diminish rainbow-delimiters-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'lisp-interaction-mode-hook #'rainbow-delimiters-mode))

(use-package smartparens
  :ensure t
  :diminish smartparens-mode
  :config
  (add-hook 'emacs-lisp-mode-hook #'smartparens-mode)
  (add-hook 'lisp-interaction-mode-hook #'smartparens-mode))

(provide 'init-lisp)
