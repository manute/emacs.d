;; No splash screen please
(setq inhibit-startup-message t)

;; Make sure we always use UTF-8.
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

(use-package ag
  :ensure t
  :config (setq ag-reuse-buffers 't))

(use-package smex
  :ensure t
  :config (global-set-key (kbd "C-t") 'smex))
 
;;MAC OS keys -> cmd is meta
(when (eq system-type 'darwin)
  (setq mac-option-key-is-meta nil
        mac-command-key-is-meta t
        mac-command-modifier 'meta
        mac-option-modifier 'none))

(setq make-backup-files nil)
(setq column-number-mode t)
(setq create-lockfiles nil)

(use-package discover-my-major
  :ensure t
  :config (global-set-key (kbd "C-h C-m") 'discover-my-major))

(use-package anzu
  :ensure t
  :diminish anzu-mode
  :config
  (global-anzu-mode 1)
  (global-set-key (kbd "C-x a") 'anzu-query-replace)
  (global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp))

(use-package magit
  :ensure t
  :config (global-set-key (kbd "C-x g") 'magit-status))

(provide 'general)
