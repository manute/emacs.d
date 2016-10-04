
(set-default-font "Source Code Pro" nil t)

;; Install all the fonts located in root emacs folder 'fonts'
;; https://github.com/NicolasPetton/zerodark-theme
(use-package zerodark-theme
  :ensure t
  :config
  (zerodark-setup-modeline-format)
  (zerodark-setup-modeline-format-alt))

(when (eq system-type 'darwin)
  (setq mac-allow-anti-aliasing t)  ;; nice fonts in OS X
  (set-face-attribute 'default nil :height 145))

(when (eq system-type 'gnu/linux)
  (set-face-attribute 'default nil :height 116))


(setq-default truncate-lines 1)  ;; no word wrap
(setq-default line-spacing 4)

(provide 'appearance)
