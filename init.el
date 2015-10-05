
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")

;;Load Cask packages first
(require 'packages)


;; ACTIVATE BENCHMARKS
;; (require 'benchmark-init)
;; (benchmark-init/activate)

;; SHOWING BENCHMARKS
;; (benchmark-init/show-durations-tabulated)
;; (benchmark-init/show-durations-tree)


(require 'mypath)

(require 'general)
(require 'appearance)
(require 'enhancements)

(require 'init-autocomplete)
(require 'custom-org)
(require 'init-flycheck)
(require 'lisps-parenthesis-enhancements)

(require 'documentation)
(require 'custom-md)

(require 'init-editing)
(require 'init-html)
(require 'init-dired)
(require 'init-ido)
;(require 'init-eshell)

;;Init config PLs
(require 'init-js)
(require 'init-clojure)
(require 'init-python)
;(require 'init-scala)
;(require 'init-racket)
;(require 'init-haskell)
;(require 'init-groovy)
;(require 'init-ruby)
(require 'init-golang)
(require 'init-rust)

(require 'init-load-server)
