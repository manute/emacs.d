;; https://github.com/racer-rust/emacs-racer
;; https://github.com/rust-lang-nursery/rustfmt

(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :diminish eldoc-mode
  :config
  (setq company-tooltip-align-annotations t)
  (setq rust-format-on-save t))


(use-package racer
  :ensure t
  :after rust-mode
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))

(use-package flycheck-rust
  :ensure t
  :after rust-mode
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package company-racer
  :ensure t
  :after racer-mode
  :config (add-to-list 'company-backends 'company-racer))

(provide 'init-rust)
