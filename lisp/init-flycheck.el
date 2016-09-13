(use-package flycheck
  :ensure t
  :defer t
  ;; :bind ("C-," . global-flycheck-mode)
  :init
  (add-hook 'after-init-hook 'global-flycheck-mode)
  :config
  (setq flycheck-global-modes '(not emacs-lisp-mode lisp-mode magit-mode sql-mode))
  ;; Jump between current errors with M-n and M-p.
  (global-set-key (kbd "M-n") 'next-error)
  (global-set-key (kbd "M-p") 'previous-error))

(use-package flycheck-color-mode-line
  :ensure t
  :after flycheck
  :config
  (setq flycheck-highlighting-mode 'symbols)
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  (set-face-background 'flycheck-error "#660000")
  (set-face-foreground 'flycheck-error nil)
  (set-face-background 'flycheck-warning "#331800")
  (set-face-foreground 'flycheck-warning nil)
  (set-face-background 'flycheck-color-mode-line-error-face "#440000")
  (set-face-background 'flycheck-color-mode-line-warning-face "#553300")
  (set-face-background 'flycheck-color-mode-line-info-face nil)
  (set-face-foreground 'flycheck-color-mode-line-error-face "#ffffff")
  (set-face-foreground 'flycheck-color-mode-line-warning-face "#ffffff")
  (set-face-foreground 'flycheck-color-mode-line-info-face nil))

(provide 'init-flycheck)
