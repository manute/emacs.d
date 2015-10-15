
;; Pop-up windows
(require 'popwin)
(popwin-mode 1)

;; Projects
(require 'projectile)
(projectile-global-mode)
;; Use C-c C-f to find a file anywhere in the current project.
(global-set-key (kbd "C-c C-f") 'projectile-find-file)

;; Warnings
(require 'warnings)
(setq warning-suppress-types '(undo discard-info))

;; Rainbow Parenthesis
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

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

;; Show current function in modeline.
(which-function-mode)

;; Ensure linum-mode is disabled in certain major modes.
(setq linum-disabled-modes
      '(term-mode slime-repl-mode magit-status-mode help-mode nrepl-mode))


;;unset C-z for stopped in console
(unless window-system
  (global-unset-key (kbd "C-z")))


(provide 'enhancements)
