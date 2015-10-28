(require 'rust-mode)
(require 'racer)
(require 'company-racer)
(require 'flycheck-rust)


; Set path to racer binary
(setq racer-cmd "/usr/local/bin/racer")

;; Set path to rust src directory
(setq racer-rust-src-path "/usr/local/src/rust/src")

(add-hook 'rust-mode-hook #'racer-mode)

(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(global-set-key (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)

(provide 'init-rust)
