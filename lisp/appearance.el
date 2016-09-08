
(set-default-font "Source Code Pro" nil t)

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
   (sml/setup))

(use-package smart-mode-line-powerline-theme
  :ensure t
  :after smart-mode-line
  :config
  (setq sml/theme 'powerline))


(when (eq system-type 'darwin)
  (setq mac-allow-anti-aliasing t)  ;; nice fonts in OS X
  (set-face-attribute 'default nil :height 135))

(when (eq system-type 'gnu/linux)
  (set-face-attribute 'default nil :height 116))

(print system-type)
(setq-default truncate-lines 1)  ;; no word wrap
(setq-default line-spacing 4)

(provide 'appearance)
