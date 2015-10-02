; Make sure we always use UTF-8.
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(load-library "iso-transl")

;; Make the selection work like most people expect.
(delete-selection-mode t)
(transient-mark-mode t)

;; Automatically update unmodified buffers whose files have changed.
(global-auto-revert-mode 1)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'ag)
(setq ag-reuse-buffers 't)

(require 'smex)
(global-set-key (kbd "C-t") 'smex)

;;MAC OS keys -> cmd is meta
(when (eq system-type 'darwin)
  (setq mac-option-key-is-meta nil
        mac-command-key-is-meta t
        mac-command-modifier 'meta
        mac-option-modifier 'none))

(setq make-backup-files nil)
(setq column-number-mode t)
(setq create-lockfiles nil)


(require 'discover-my-major)
(global-set-key (kbd "C-h C-m") 'discover-my-major)


;; Display incremental search stats in modeline.
(require 'anzu)
(global-anzu-mode 1)
(global-set-key (kbd "C-x a") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)


(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

(provide 'general)
