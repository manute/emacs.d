(use-package atom-one-dark-theme
  :if window-system
  :ensure t
  :config (load-theme 'atom-one-dark t))

(use-package color-theme-tomorrow
  :if (not window-system)
  :load-path "~/.emacs.d/themes/"
  :config (color-theme-tomorrow--define-theme night))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/no-confirm-load-theme t)
  (sml/setup)
  (setq sml/theme 'respectful))

(when (eq system-type 'darwin)
  (set-face-attribute 'default nil :height 150 :family "consolas")
  (setq mac-allow-anti-aliasing t))  ;; nice fonts in OS X

(setq-default truncate-lines 1)  ;; no word wrap
(setq-default line-spacing 4)

(provide 'appearance)
