;; package-refresh-contents if fails
(require 'package)
;; (setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; If this fails , use local version of use-package
;;
;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; This is only needed once, near the top of the file
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  ;; (add-to-list 'load-path "~/.emacs.d/local/use-package")
  (require 'use-package))

(use-package use-package-ensure-system-package
  :ensure t)

(use-package auto-package-update
  :ensure t
  :bind ("C-x P" . auto-package-update-now)
  :config
  (setq auto-package-update-delete-old-versions t))

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOROOT")
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "NPMBIN")
  (exec-path-from-shell-copy-env "LC_ALL")
  (exec-path-from-shell-copy-env "LANG")
  (exec-path-from-shell-copy-env "LC_TYPE")
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  (exec-path-from-shell-copy-env "SHELL")
  (exec-path-from-shell-copy-env "JAVA_HOME")

  )

;; ACTIVATE BENCHMARKS
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;; SHOWING BENCHMARKS
;; (benchmark-init/show-durations-tabulated)
;; (benchmark-init/show-durations-tree)

(setq use-package-verbose t)

(setq explicit-shell-file-name "/bin/zsh")

(defun manu/zsh-launch ()
  (interactive)
  (ansi-term "/bin/zsh"))

(global-set-key (kbd "C-c z") 'manu/zsh-launch)


(eval-after-load "term"
  '(define-key term-raw-map (kbd "C-c C-y") 'term-paste))

;; DEBUG errors
;; (setq max-specpdl-size 5)
;; (setq max-lisp-eval-depth 10000)
;; (setq debug-on-error t)

(use-package eyebrowse
  :ensure t
  :init (eyebrowse-mode t))

;; http://www.funtoo.org/Keychain
(use-package keychain-environment
  :ensure t
  :init (keychain-refresh-environment))

(use-package hydra
  :ensure t)

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :config
  (add-to-list 'load-path
               "~/.emacs.d/snippets")
  (yas-global-mode 1))

(use-package magit
 :ensure t
 :bind ("C-x g" . magit-status))
  ;; (setq magit-refresh-status-buffer nil))


(use-package general
  :load-path "lisp/")

(use-package tools-edit
  :load-path "lisp/"
  :bind (("C-x c" . manu/comment-or-uncomment-region-or-line)
         ("C-c d" . manu/duplicate-current-line-or-region)))

(use-package appearance
  :load-path "lisp/")

(use-package init-autocomplete
  :load-path "lisp/")

(use-package init-flycheck
  :load-path "lisp/")

(use-package smartparens
  :ensure t
  :init (smartparens-global-mode 1)
  :diminish smartparens-mode)

(use-package custom-org
  :load-path "lisp/")

(use-package web-mode
  :ensure t
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
         ("\\.tmpl\\'" . web-mode)
         ("\\.html\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t))

(use-package rainbow-delimiters
  :ensure t
  :diminish rainbow-delimiters-mode
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package dired+
  ;; :ensure t
  :defer t
  :config
  (setq diredp-hide-details-initially-flag nil)
  (set-face-foreground 'diredp-file-name nil)
  ;; Keep dired buffers updated when the file system changes.
  (setq global-auto-revert-non-file-buffers t)
  (setq auto-revert-verbose nil))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define-global "--" "_"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Init config PLs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package init-lisp
  :load-path "lisp/")

(use-package init-golang
  :load-path "lisp/")

(use-package init-rust
  :load-path "lisp/")

(use-package init-js
  :load-path "lisp/")

(use-package init-python
  :disabled t
  :load-path "lisp/")

(use-package init-scala
  :disabled t
  :load-path "lisp/")

(use-package init-clojure
  :load-path "lisp/")

(use-package init-racket
  :disabled t
  :load-path "lisp/")

(use-package init-haskell
  :disabled t
  :load-path "lisp/")

(use-package init-groovy
  :disabled t
  :load-path "lisp/")

(use-package init-ruby
  :disabled t
  :load-path "lisp/")

(use-package init-elixir
  :disabled t
  :load-path "lisp/")

(use-package init-elm
  :disabled t
  :load-path "lisp/")

(use-package perl-mode
  :mode (("\\.pl\\'" . perl-mode)
         ("\\.perl\\'" . perl-mode)
         ("\\.pm\\'" . perl-mode))
  :config
  (add-hook 'perl-mode-hook #'company-mode))

(use-package lua-mode
  :ensure t
  :mode (("\\.lua\\'" . lua-mode))
  :config
  (add-hook 'lua-mode-hook #'company-mode))


;; (use-package meghanada
;;   :mode (("\\.java\\'" . meghanada-mode))
;;   :config
;;   (smartparens-mode t)
;;   (rainbow-delimiters-mode t)
;;   (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)
;;   :commands
;;   (meghanada-mode))

;; FILES MODE

(use-package adoc-mode
  :ensure t
  :mode ("\\.asciidoc\\'" . adoc-mode))

(use-package web-server
  :ensure t
  :defer t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("CONTRIBUTING\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; (use-package markdown-preview-mode
;;   :ensure t
;;   :after markdown-mode
;;   :bind (("C-c m p" . markdown-preview-mode);;
;;          ("C-c m o" . markdown-preview-open-browser))
;;   :config
;;   (add-hook 'markdown-mode-hook (lambda () ( markdown-preview-mode 1 )))
;;   (add-hook 'gfm-mode-hook (lambda () ( markdown-preview-mode 1 ))))

(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))

(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" . yaml-mode))

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)
         ("\\.tmpl\\'" . json-mode)
         ("\\.eslintrc\\'" . json-mode))
  :config (setq-default js-indent-level 2))

(use-package graphql-mode
  :ensure t)

(use-package json-reformat
  :ensure t
  :after json-mode
  :bind (("C-c r" . json-reformat-region)))

(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" . dockerfile-mode))

(use-package mustache-mode
  :ensure t
  :mode ("\\.mustache\\'" . mustache-mode))

(use-package terraform-mode
  :ensure t
  :mode ("\\.tf\\'" . terraform-mode)
  :config
  (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode))



;; INIT DAEMON SERVER
(require 'server)
(unless (server-running-p)
  (server-start))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (go-rename go-guru use-package-ensure-system-package spacemacs-theme whole-line-or-region spaceline spaceline-config terraform-mode mustache-mode dockerfile-mode graphql-mode json-mode yaml-mode toml-mode markdown-mode web-server adoc-mode lua-mode flycheck-pos-tip flycheck-clojure flycheck-joker clj-refactor cider clojure-mode xref-js2 prettier-js add-node-modules-path js2-mode company-racer flycheck-rust racer rust-mode flycheck-golangci-lint go-tag go-eldoc gotest company-go go-mode key-chord rainbow-delimiters web-mode org-bullets org-beautify-theme htmlize smartparens flycheck-color-mode-line flycheck company-tern company-emoji company-math company-statistics company-quickhelp company ns-auto-titlebar zerodark-theme base16-theme memoize which-key projectile-ripgrep ripgrep projectile popwin anzu ido-vertical-mode smex magit yasnippet hydra keychain-environment eyebrowse exec-path-from-shell auto-package-update use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
