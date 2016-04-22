(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :config

  (use-package smartparens
    :ensure t
    :config  (add-hook 'js2-mode-hook 'smartparens-mode))

  (use-package company-go
    :ensure t
    :config
    (add-hook 'js2-mode-hook 'company-mode)))

(provide 'init-js)
