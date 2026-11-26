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
(setq-default indent-tabs-mode nil)  ;; use spaces instead of tabs
(setq-default tab-width 4)           ;; width of tab if it exists

(setq tab-bar-show t) ;; show only the current tab

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

(defun projectile-ignore-folders (project-root)
  "Ignore projects containing specific folders."
  (or (string-match-p "vendor" project-root)
      (string-match-p "npm" project-root)
      (string-match-p "org-persist" project-root)))

(defun custom/find-go-dir (dir)
  "Find the Go project root by looking for go.mod."
  (locate-dominating-file dir "go.mod"))

(use-package projectile
  :ensure t
  :bind  (("C-c C-f" . projectile-find-file)
          ("C-c p p" . projectile-switch-project))
  :config
  (projectile-mode +1)
  ;; Tell Projectile where your code lives!
  ;; (Change "~/Projects" to your actual coding directory)
  (setq projectile-project-search-path '("~/Projects" "~/go/src/github.com/"))
  (setq projectile-ignored-project-function #'projectile-ignore-folders)
  (add-to-list 'projectile-project-root-functions #'custom/find-go-dir))

(use-package grep
  :config
  ;; js ignore folders
  (add-to-list 'grep-find-ignored-directories "dist")
  (add-to-list 'grep-find-ignored-directories "node_modules")
  (add-to-list 'grep-find-ignored-directories "bower_components")

  ;; golang ignore folders
  (add-to-list 'grep-find-ignored-directories "vendor"))


;; (use-package ripgrep
;;   :if (executable-find "rg")
;;   :commands (ripgrep-regexp)
;;   :ensure t
;;   :bind (:map ripgrep-search-mode-map
;;               ("n" . next-error-no-select)
;;               ("p" . previous-error-no-select)))

;; (use-package projectile-ripgrep
;;   :if (executable-find "rg")
;;   :ensure t
;;   :after (projectile)
;;   :commands (projectile-ripgrep)
;;   :bind (:map projectile-mode-map
;;               ("C-c p s r" . projectile-ripgrep)))


(use-package rg
  :ensure t
  :defer t
  :config
  ;; Enables a fantastic default keybinding map under the "C-c s" prefix.
  ;; For example, C-c s p searches the project, C-c s d searches a directory.
  (rg-enable-default-bindings)

  :bind
  ;; Keeps your exact Projectile muscle memory intact!
  ;; rg-project automatically detects the root of your current project.
  (("C-c p s r" . rg-project)))


(use-package warnings
  :defer t
  :config (setq warning-suppress-types '((undo) (discard-info) (files))))

;; ==========================
;; VTerm + vterm-toggle setup
;; ==========================

(defvar my/vterm-font "SF Mono"
  "Monospace font for vterm buffers; ligatures/icons are unnecessary overhead.")

(defvar my/vterm-buffer-counter 0
  "Counter for naming vterm buffers.")

(defun my/vterm-mac-key-fixes ()
  "Force vterm to send the correct delete signal for macOS keys."
  (local-set-key (kbd "<delete>") #'vterm-send-delete)
  (local-set-key [delete] #'vterm-send-delete)
  (local-set-key (kbd "<kp-delete>") #'vterm-send-delete))

(defun my/vterm-mode-setup ()
  "Strip UI overhead from vterm buffers for typing and flood output."
  (display-line-numbers-mode -1)
  (setq-local line-spacing 0)
  (setq-local global-hl-line-mode nil)
  (setq-local bidi-display-reordering nil)
  (setq-local bidi-inhibit-bpa t)
  (setq-local auto-composition-mode nil)
  ;; Reduce GC pauses during large build/log output.
  (setq-local gc-cons-threshold (* 128 1024 1024))
  (when (featurep 'doom-modeline)
    (doom-modeline-mode -1))
  (when (member my/vterm-font (font-family-list))
    (set-face-attribute 'default nil
                        :font my/vterm-font
                        :height my-font-size)))

(use-package vterm
  :ensure t
  :defer t
  :config
  (setq vterm-disable-bold-font t
        vterm-disable-underline t
        vterm-disable-inverse-video t
        vterm-max-scrollback 1500
        vterm-clear-scrollback-when-clearing t
        ;; Low delay keeps typing/echo snappy; raise to 0.15–0.2 if flood output stutters.
        vterm-timer-delay 0.08
        comp-deferred-compilation t
        fast-but-imprecise-scrolling t
        redisplay-skip-fontification-on-input t
        inhibit-compacting-font-caches t)

  ;; (add-hook 'vterm-mode-hook #'my/vterm-mode-setup)
  (add-hook 'vterm-mode-hook #'my/vterm-mac-key-fixes)

  (defun my/vterm-new (&optional name)
    "Create a new vterm buffer with a unique name or given NAME."
    (interactive)
    (setq my/vterm-buffer-counter (1+ my/vterm-buffer-counter))
    (let ((buffer-name (or name (format "vterm-%d" my/vterm-buffer-counter))))
      (vterm buffer-name)))

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

  (defun my/vterm-project ()
    "Open a vterm in the current project's root."
    (interactive)
    (let ((default-directory (if (fboundp 'project-root)
                                 (project-root (project-current t))
                               default-directory)))
      (my/vterm-new)))

  :bind (("C-c t n" . my/vterm-new)
         ("C-c t b" . my/vterm-split-below)
         ("C-c t r" . my/vterm-split-right)
         ("C-c t p" . my/vterm-project)))

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
  :after vterm
  :defer t
  :bind (("C-`" . vterm-toggle))
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (setq vterm-toggle-cd-auto-create-buffer t))

(global-set-key (kbd "C-c t <right>") #'my/vterm-next)
(global-set-key (kbd "C-c t <left>") #'my/vterm-prev)


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


(use-package yaml-mode
  :ensure t
  :mode (("\\.yml\\'" . yaml-mode)
         ("\\.yaml\\'" . yaml-mode)
         ("\\.yaml.tmpl\\'" . yaml-mode))
  :init
  ;; Set the indent size (usually 2 spaces for YAML)
  (setq yaml-indent-offset 2)
  :hook (yaml-mode . (lambda ()
                       ;; 1. Disable "Electric Indent" locally
                       ;; This stops Emacs from automatically indenting new lines
                       ;; when you press Enter, giving you full manual control.
                       (electric-indent-local-mode -1)

                       ;; 2. Ensure NO format-on-save hooks run in this buffer
                       ;; (These lines protect you if you have global formatters enabled)
                       (remove-hook 'before-save-hook 'lsp-format-buffer t)
                       (remove-hook 'before-save-hook 'eglot-format-buffer t)
                       (remove-hook 'before-save-hook 'apheleia-format-buffer-hook t)
                       (remove-hook 'before-save-hook 'prettier-js-mode-save-hook t))))


;; (use-package copilot
;;   ;; :ensure t
;;   :vc (:url "https://github.com/copilot-emacs/copilot.el"
;;             :rev :newest
;;             :branch "main")
;;   :hook (prog-mode . copilot-mode)
;;   :bind (:map copilot-completion-map
;;               ("<tab>" . copilot-accept-completion)
;;               ("TAB" . copilot-accept-completion)
;;               ("C-<tab>" . copilot-accept-completion-by-word)
;;               ("C-TAB" . copilot-accept-completion-by-word)
;;               ("C-n" . copilot-next-completion)
;;               ("C-p" . copilot-previous-completion)))

(provide 'general)
