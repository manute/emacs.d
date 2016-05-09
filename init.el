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
  (setq auto-package-update-delete-old-versions t)
  (auto-package-update-at-time "03:00"))

;; ACTIVATE BENCHMARKS
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;; SHOWING BENCHMARKS
;; (benchmark-init/show-durations-tabulated)
;; (benchmark-init/show-durations-tree)

(setq use-package-verbose t)

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

(use-package custom-org
  :load-path "lisp/")

(use-package web-mode
  :ensure t
  :mode (("\\.phtml\\'" . web-mode)
         ("\\.erb\\'" . web-mode)
         ("\\.mustache\\'" . web-mode)
         ("\\.djhtml\\'" . web-mode)
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
  :load-path "lisp/")

(use-package init-js
  :load-path "lisp/")

(use-package init-python
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


;; FILES MODES

(use-package adoc-mode
  :ensure t
  :mode ("\\.asciidoc\\'" . adoc-mode))

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.text\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)))

(use-package toml-mode
  :ensure t
  :mode ("\\.toml\\'" . toml-mode))


(use-package javascript-mode
  :mode (("\\.json\\'" . javascript-mode)
         ("\\.tmpl\\'" . javascript-mode))
  :config

  (use-package json-reformat
    :ensure t
    :bind (("C-c r" . json-reformat-region))))


;; INIT DAEMON SERVER
(require 'server)
(unless (server-running-p)
  (server-start))
