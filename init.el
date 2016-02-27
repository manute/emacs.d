(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;; (add-to-list 'load-path "~/.emacs.d/lisp")
;; (add-to-list 'load-path "~/projects/gorepl-mode")


;; ACTIVATE BENCHMARKS
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;; SHOWING BENCHMARKS
;; (benchmark-init/show-durations-tabulated)
;; (benchmark-init/show-durations-tree)

(setq use-package-verbose t)

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config  (exec-path-from-shell-initialize)
           (exec-path-from-shell-copy-env "GOPATH")
           (exec-path-from-shell-copy-env "GOROOT"))

(use-package general
  :load-path "lisp/")

(use-package appearance
  :load-path "lisp/")
;; (require) 'enhancements)

;; (require 'init-autocomplete)
;; (require 'custom-org)
;; (require 'init-flycheck)
;; (require 'lisps-parenthesis-enhancements)

;; (require 'documentation)
;; (require 'custom-md)

;; (require 'init-editing)
;; (require 'init-html)
;; (require 'init-dired)
;; (require 'init-ido)
;(require 'init-eshell)

;;Init config PLs
;; (require 'init-js)
;; (require 'init-clojure)
;; (require 'init-python)
;(require 'init-scala)
;(require 'init-racket)
;(require 'init-haskell)
;(require 'init-groovy)
;(require 'init-ruby)
;; (require 'init-golang)
;; (require 'init-rust)

;;Load server for emacsclient
;; (require 'init-load-server)
