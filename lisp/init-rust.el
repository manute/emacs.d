(require 'rust-mode)
(require 'racer)
(require 'company-racer)
(require 'flycheck-rust)
(require 'rustfmt)


; Set path to racer binary
(setq racer-cmd "/usr/local/bin/racer")

;; Set path to rust src directory
(setq racer-rust-src-path "/usr/local/src/rust/src")

(add-hook 'rust-mode-hook #'racer-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(add-hook 'rust-mode-hook #'rustfmt-enable-on-save)

(setq company-tooltip-align-annotations t)


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

(eval-after-load "rust-mode"
  '(manu/setup-rust-arrows 'rust-mode rust-mode-map))

(provide 'init-rust)
