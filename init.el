;; package-refresh-contents if fails
(require 'package)
;; (setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository

;; DEBUG errors
;;(setq max-specpdl-size 5)
;;(setq max-lisp-eval-depth 10000)
;;(setq debug-on-error t)
;;(toggle-debug-on-quit t)


(package-initialize)

(setq package-check-signature nil)

(setq tramp-default-method "ssh")

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

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-copy-envs
   '("PATH"
     "GOPATH" "GO111MODULE" "GOPROXY" ;; golang
     "LC_ALL" "LANG" "LC_TYPE"
     "SSH_AGENT_PID" "SSH_AUTH_SOCK" ;; ssh
     "SHELL"
     "GPG_TTY" ;; gpg session
     "NVM_BIN" ;; npm
     ;; Using x11 the .bashrc or .zshrc could have not been sourcered yet
     ;; so it may need this symlink:
     ;; ln -s /home/manu/.nvm/versions/node/v17.5.0/bin/node /usr/bin/node
     ))
  (exec-path-from-shell-initialize))

(use-package auto-package-update
  :ensure t
  :bind ("C-x P" . auto-package-update-now)
  :config
  (setq auto-package-update-delete-old-versions t))

;; ACTIVATE BENCHMARKS
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;; SHOWING BENCHMARKS
;; (benchmark-init/show-durations-tabulated)
;; (benchmark-init/show-durations-tree)

;; general vars
(setq gc-cons-threshold 100000000 ;; performance
      read-process-output-max (* 1024 1024) ;; 1mb
      use-package-verbose t
      explicit-shell-file-name "/bin/zsh")

;; Restore after startup
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 1000000)
            (message "gc-cons-threshold restored to %S"
                     gc-cons-threshold)))

(eval-after-load "term"
  '(define-key term-raw-map (kbd "C-c C-y") 'term-paste))


;; Automatically bury the *Warnings* buffer so it doesn't pop up
(defun my/bury-warnings-buffer ()
  (when (get-buffer "*Warnings*")
    (bury-buffer "*Warnings*")))

(add-hook 'emacs-startup-hook #'my/bury-warnings-buffer)

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
  :diminish magit-auto-revert-mode
  :diminish auto-revert-mode
  :bind (("C-x g" . #'magit-status))
  :config
  ;; perfomance tips
  (setq magit-commit-show-diff nil)
  (setq magit-refresh-status-buffer nil)
  (setq magit-git-executable "/usr/bin/git"))

;; M-x package-install RET xclip RET
;; (xclip-mode 1)

;; TODO: fix something with the build and the file libegit2.dylib
;; (use-package libgit
;;   :ensure t)

;; (use-package magit-libgit
;;   :ensure t
;;   :after (magit libgit))

;; (use-package forge
;;   :ensure t
;;   :after magit)

(use-package restclient
  :ensure t
  :mode ("\\.restclient$" . restclient-mode))

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
  :config (smartparens-global-mode 1)
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

;; https://emacs.stackexchange.com/questions/38553/dired-missing-from-melpa
;; (use-package dired+
;;   :ensure t
;;   :defer t
;;   :config
;;   (setq diredp-hide-details-initially-flag nil)
;;   (set-face-foreground 'diredp-file-name nil)
;;   ;; Keep dired buffers updated when the file system changes.
;;   (setq global-auto-revert-non-file-buffers t)
;;   (setq auto-revert-verbose nil))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define-global "--" "_"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Init config PLs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package init-lsp
 :load-path "lisp/")

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
  :mode  ("\\.md\\'" . markdown-mode))

;; go install github.com/chrishrb/go-grip@latest
(use-package grip-mode
  :ensure t
  :bind (:map markdown-mode-command-map
         ("g" . grip-mode))
  :init
  (setq grip-update-after-change t)     ;; auto-refresh
  (setq grip-preview-use-webkit nil)    ;; nil = use EWW, t = use external browser
  :config (setq grip-command 'go-grip)) ;; auto, grip, go-grip or mdopen


(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))


(use-package mustache-mode
  :ensure t
  :mode ("\\.mustache\\'" . mustache-mode))


(use-package rego-mode
  :ensure t
  :mode ("\\.rego\\'" . rego-mode))


(use-package protobuf-mode
  :ensure t
  :mode ("\\.proto\\'" . protobuf-mode))


(use-package quelpa :ensure t)

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

;; AI https://github.com/karthink/gptel
(use-package gptel
  :quelpa (gptel :fetcher github :repo "karthink/gptel"))

;; INIT DAEMON SERVER
(require 'server)
(unless (server-running-p)
  (server-start))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-ui-doc-background ((t (:background "lightyellow")))))
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(add-node-modules-path adoc-mode anzu auto-package-update company-box
                           company-emoji company-quickhelp
                           company-statistics dockerfile-mode
                           doom-modeline exec-path-from-shell
                           eyebrowse flycheck-color-mode-line go-eldoc
                           gotest gptel graphql-mode grip-mode
                           groovy-mode htmlize hydra ido-vertical-mode
                           java-mode json-mode json-reformat
                           jsonnet-mode key-chord keychain-environment
                           lsp-java lsp-ui magit memoize mustache-mode
                           ns-auto-titlebar org-beautify-theme
                           org-bullets org-roam popwin
                           projectile-ripgrep protobuf-mode
                           python-mode quelpa quelpa-use-package
                           rainbow-delimiters rego-mode restclient
                           rjsx-mode rust-mode smartparens smex
                           terraform-mode toml-mode typescript-mode
                           vterm-toggle web-mode web-server
                           whole-line-or-region yaml-mode yasnippet
                           zerodark-theme))
 '(safe-local-variable-values
   '((setq projectile-project-root-functions
           '(projectile-root-local projectile-root-top-down
                                   projectile-root-top-down-recurring
                                   projectile-root-bottom-up))))
 '(warning-suppress-types '((comp) (comp) (comp) undo discard-info)))
