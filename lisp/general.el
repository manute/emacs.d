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
  :config
  (global-set-key (kbd "C-t") 'smex)
  (global-set-key (kbd "M-x") (lambda ()
			      (interactive)
			      (or (boundp 'smex-cache)
				 (smex-initialize))
			      (global-set-key (kbd "M-x") 'smex)
			      (smex)))
  (global-set-key (kbd "M-X") (lambda ()
                                (interactive)
                                (or (boundp 'smex-cache)
                                    (smex-initialize))
                                (global-set-key (kbd "M-X") 'smex-major-mode-commands)
                                (smex-major-mode-commands))))

(use-package ido
  :ensure t
  :config
  (ido-mode)
  (ido-everywhere)
  (setq ido-enable-flex-matching t))

(use-package ido-ubiquitous
  :ensure t
  :config (ido-ubiquitous-mode))

(use-package ido-vertical-mode
  :ensure t
  :config (ido-vertical-mode))

; Buffers
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)


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

(use-package popwin
  :ensure t
  :config (popwin-mode 1))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (global-set-key (kbd "C-c C-f") 'projectile-find-file))

(use-package warnings
  :ensure t
  :config (setq warning-suppress-types '(undo discard-info)))

(use-package rainbow-delimiters
  :ensure t
  :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

; Show empty lines
(toggle-indicate-empty-lines)

; Increase/Decrease font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; Whitespace
(set-default 'indent-tabs-mode nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq sentence-end-double-space nil)

;; Always indent after a newline.
(define-key global-map (kbd "RET") 'newline-and-indent)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode))

;;--------------------
;THANKS TO BODIL -> https://github.com/bodil/ohai-emacs/blob/master/modules/ohai-appearance.el
;;--------------------

;; Don't defer screen updates when performing operations.
(setq redisplay-dont-pause t)

(setq inhibit-splash-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode '(4 . 0))

;; Show line numbers in buffers.
;;(global-linum-mode t)
;;(setq linum-format (if (not window-system) "%2d" "%4d"))

;; Show column numbers in modeline.
(setq column-number-mode t)


(provide 'general)
