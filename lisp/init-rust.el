(defun font-lock-replace-symbol (mode reg sym)
  (font-lock-add-keywords
   mode `((,reg
           (0 (progn (compose-region (match-beginning 1) (match-end 1)
                                     ,sym 'decompose-region)))))))


;; Use Unicode arrows in place of ugly ASCII arrows
(defun manu/setup-rust-arrows (mode mode-map)
  (font-lock-replace-symbol mode "\\(->\\)" "→")
  (font-lock-replace-symbol mode "\\(<-\\)" "←")
  (font-lock-replace-symbol mode "\\(=>\\)" "⇒")

  (define-key mode-map (kbd "→") (lambda () (interactive) (insert "->")))
  (define-key mode-map (kbd "←") (lambda () (interactive) (insert "<-")))
  (define-key mode-map (kbd "⇒") (lambda () (interactive) (insert "=>"))))


(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  :diminish eldoc-mode
  :config
  (setq company-tooltip-align-annotations t)
  '(manu/setup-rust-arrows 'rust-mode rust-mode-map)

  (use-package racer
    :ensure t
    :config
    ;; Set path to racer binary
    (setq racer-cmd "~/.cargo/bin/racer")
    ;; Set path to rust src directory
    (setq racer-rust-src-path "~/rust/1.6/src")
    (add-hook 'rust-mode-hook #'racer-mode)
    (add-hook 'racer-mode-hook #'eldoc-mode)
    (add-hook 'racer-mode-hook #'company-mode))

  (use-package flycheck-rust
    :ensure t
    :config
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

  (use-package rustfmt
    :ensure t
    :config (add-hook 'rust-mode-hook #'rustfmt-enable-on-save))

  (use-package company-racer
    :ensure t
    :config (add-to-list 'company-backends 'company-racer)))

(provide 'init-rust)
