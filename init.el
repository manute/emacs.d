;; package-refresh-contents if fails
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

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

(setq use-package-verbose t)

;; DEBUG errors
;; (setq max-specpdl-size 5)
;; (setq max-lisp-eval-depth 10000)
;; (setq debug-on-error nil)

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


(use-package dired+
  :ensure t
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
  :disabled t
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
  :disabled t
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
  :load-path "lisp/")

(use-package init-elm
  :load-path "lisp/")


(use-package perl-mode
  :mode (("\\.pl\\'" . perl-mode)
         ("\\.perl\\'" . perl-mode)
         ("\\.pm\\'" . perl-mode))
  :config
  (add-hook 'perl-mode-hook #'company-mode))


;; FILES MODE

(use-package adoc-mode
  :ensure t
  :mode ("\\.asciidoc\\'" . adoc-mode))

(use-package web-server
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("CONTRIBUTING\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package markdown-preview-mode
  :ensure t
  :after markdown-mode
  :bind (("C-c m p" . markdown-preview-mode);;
         ("C-c m o" . markdown-preview-open-browser))
  :config
  (add-hook 'markdown-mode-hook (lambda () ( markdown-preview-mode 1 )))
  (add-hook 'gfm-mode-hook (lambda () ( markdown-preview-mode 1 ))))

(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))

(use-package yaml-mode
  :ensure t
  :mode ("\\.yml\\'" . yaml-mode))

(use-package json-mode
  :ensure t
  :mode (("\\.json\\'" . json-mode)
         ("\\.tmpl\\'" . json-mode)))

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


;; INIT DAEMON SERVER
(require 'server)
(unless (server-running-p)
  (server-start))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (markdown-preview-mode mustache-mode jade zerodark-theme elpy yaml-mode whole-line-or-region which-key web-mode virtualenvwrapper use-package toml-mode smex smartparens smart-mode-line-powerline-theme rustfmt rainbow-delimiters racer projectile popwin org-bullets org-beautify-theme magit key-chord json-mode ido-vertical-mode htmlize gorepl-mode go-eldoc flycheck-rust flycheck-elm flycheck-color-mode-line exec-path-from-shell elm-mode dockerfile-mode dired+ company-statistics company-racer company-quickhelp company-math company-go company-emoji clj-refactor cl-generic auto-package-update atom-one-dark-theme anzu alchemist adoc-mode ac-js2))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
