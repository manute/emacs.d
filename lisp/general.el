;; No splash screen please
(setq inhibit-startup-message t)

;; Make sure we always use UTF-8.
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
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

;; Always newline-and-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Spaces Indent
(set-default 'indent-tabs-mode nil)

;; Show empty lines
(toggle-indicate-empty-lines)

; Increase/Decrease font size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq
 redisplay-dont-pause t ;; Don't defer screen updates when performing operations.
 inhibit-splash-screen t
 sentence-end-double-space nil
 make-backup-files nil
 auto-save-default nil
 create-lockfiles nil
 ring-bell-function 'ignore
 column-number-mode t ;; Show column numbers in modeline
 )


(use-package smex
  :ensure t
  :defer t
  :config
  (global-set-key (kd b"C-t") 'smex)
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
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t)
  (ido-mode 1))


(use-package ido-vertical-mode
  :ensure t
  :config (ido-vertical-mode))

; Buffers
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)


;; MAC OS keys -> cmd is meta
(defun manu/osx-laptop-keyboard ()
  "change command key to meta for mac os"
  (interactive)
  (setq mac-option-key-is-meta nil
        mac-command-key-is-meta t
        mac-command-modifier 'meta
        mac-option-modifier 'none))


(global-set-key (kbd "C-c k l") 'manu/osx-laptop-keyboard)

;; ITERM2 MOUSE SUPPORT
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (defun track-mouse (e))
  (setq mouse-sel-mode t))

(use-package anzu
  :ensure t
  :diminish anzu-mode
  :bind (("C-x a" . anzu-query-replace)
         ("C-M-%" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode 1))


(use-package popwin
  :ensure t
  :defer t
  :config (popwin-mode 1))

;; This is to prevent not needed folders slip into projectile known projects
(defun projectile-ignore-folders (project-name)
  (or (s-contains? "vendor" project-name)
      (s-contains? "npm" project-name)
      ))

(defun custom/find-go-dir (dir)
  (if (equal dir "/") nil
    (if (member "go.mod" (directory-files dir)) dir
      (custom/find-go-dir (file-name-directory (string-trim-right dir "/"))))))

(use-package projectile
  :ensure t
  :bind  (("C-c C-f" . projectile-find-file)
          ("C-c p p" . projectile-switch-project))
  :config
  (projectile-global-mode)
  (setq projectile-ignored-project-function 'projectile-ignore-folders)
  (add-to-list 'projectile-project-root-files-functions 'custom/find-go-dir)
  ;; multiple projects in a repo
  ;; (setq projectile-project-root-functions
  ;;       '(projectile-root-local
  ;;         projectile-root-top-down
  ;;         projectile-root-bottom-up
  ;;         projectile-root-top-down-recurring))
  )


(use-package grep
  :config
  ;; js ignore folders
  (add-to-list 'grep-find-ignored-directories "dist")
  (add-to-list 'grep-find-ignored-directories "node_modules")
  (add-to-list 'grep-find-ignored-directories "bower_components")

  ;; golang ignore folders
  (add-to-list 'grep-find-ignored-directories "vendor"))


(use-package ripgrep
  :if (executable-find "rg")
  :commands (ripgrep-regexp)
  :ensure t
  :bind (:map ripgrep-search-mode-map
              ("n" . next-error-no-select)
              ("p" . previous-error-no-select)))

(use-package projectile-ripgrep
  :if (executable-find "rg")
  :ensure t
  :after (projectile)
  :commands (projectile-ripgrep)
  :bind (:map projectile-mode-map
              ("C-c p s r" . projectile-ripgrep)))


(use-package warnings
  :ensure t
  :defer t
  :config (setq warning-suppress-types '(undo discard-info)))


;; ==========================
;; VTerm + vterm-toggle setup
;; ==========================

(use-package vterm
  :ensure t
  :config
  (setq vterm-disable-bold-font t
        vterm-max-scrollback 5000
        comp-deferred-compilation t
        fast-but-imprecise-scrolling t
        redisplay-skip-fontification-on-input t
        inhibit-compacting-font-caches t)

  (add-hook 'vterm-mode-hook
            (lambda ()
              (display-line-numbers-mode -1)
              (setq-local global-hl-line-mode nil)
              (setq-local bidi-display-reordering nil)
              (setq-local bidi-inhibit-bpa t)))

  ;; Auto-named vterms: vterm-1, vterm-2, ...
  (defvar my/vterm-buffer-counter 0
    "Counter for naming vterm buffers.")

  (defun my/vterm-new (&optional name)
    "Create a new vterm buffer with a unique name or given NAME."
    (interactive)
    (setq my/vterm-buffer-counter (1+ my/vterm-buffer-counter))
    (let ((buffer-name (or name (format "vterm-%d" my/vterm-buffer-counter))))
      (vterm buffer-name)))

  ;; Open vterm in split
  (defun my/vterm-split-below ()
    "Open a new vterm in a horizontal split."
    (interactive)
    (split-window-below)
    (other-window 1)
    (my/vterm-new))

  (defun my/vterm-split-right ()
    "Open a new vterm in a vertical split."
    (interactive)
    (split-window-right)
    (other-window 1)
    (my/vterm-new))

  ;; Project-root vterm
  (defun my/vterm-project ()
    "Open a vterm in the current project's root."
    (interactive)
    (let ((default-directory (if (fboundp 'project-root)
                                 (project-root (project-current t))
                               default-directory)))
      (my/vterm-new))))

;; ==========================
;; VTerm buffer cycling
;; ==========================

(defun my/vterm-buffers ()
  "Return a list of all vterm buffers."
  (seq-filter (lambda (b)
                (string-prefix-p "vterm-" (buffer-name b)))
              (buffer-list)))

(defun my/vterm-next ()
  "Switch to the next vterm buffer."
  (interactive)
  (let* ((buffers (my/vterm-buffers))
         (current (current-buffer))
         (pos (cl-position current buffers)))
    (if pos
        (switch-to-buffer (nth (mod (1+ pos) (length buffers)) buffers))
      (when buffers
        (switch-to-buffer (car buffers))))))

(defun my/vterm-prev ()
  "Switch to the previous vterm buffer."
  (interactive)
  (let* ((buffers (my/vterm-buffers))
         (current (current-buffer))
         (pos (cl-position current buffers)))
    (if pos
        (switch-to-buffer (nth (mod (1- pos) (length buffers)) buffers))
      (when buffers
        (switch-to-buffer (car buffers))))))

;; ==========================
;; vterm-toggle
;; ==========================

(use-package vterm-toggle
  :ensure t
  :bind (("C-`" . vterm-toggle))
  :config
  (setq vterm-toggle-fullscreen-p nil)  ;; toggle in split, not fullscreen
  (setq vterm-toggle-scope 'project)   ;; separate per project
  (setq vterm-toggle-cd-auto-create-buffer t))  ;; auto-name buffer

;; ==========================
;; Keybindings for manual control
;; ==========================

(global-set-key (kbd "C-c t n") 'my/vterm-new)          ;; new vterm
(global-set-key (kbd "C-c t b") 'my/vterm-split-below)  ;; split below
(global-set-key (kbd "C-c t r") 'my/vterm-split-right)  ;; split right
(global-set-key (kbd "C-c t p") 'my/vterm-project)      ;; project root vterm
(global-set-key (kbd "C-c t <right>") 'my/vterm-next)   ;; next vterm
(global-set-key (kbd "C-c t <left>") 'my/vterm-prev)    ;; previous vterm


(use-package which-key
  :ensure t
  :diminish which-key-mode
  :config (which-key-mode))

;; https://github.com/patrickt/emacs
;; (use-package undo-tree
;;   :ensure t
;;   :init (global-undo-tree-mode)
;;   :diminish
;;   :bind (("C-c /" . undo-tree-visualize)))


(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode '(4 . 0))

(when (display-graphic-p)
  (global-unset-key "\C-z"))

(show-paren-mode 1)


(provide 'general)
