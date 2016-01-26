
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
;; (add-to-list 'load-path "~/projects/gorepl-mode")

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
;; (require 'init-eshell)

;; Init config PLs
(require 'init-js)
(require 'init-clojure)
(require 'init-python)
;;(require 'init-scala)
;;(require 'init-racket)
;;(require 'init-haskell)
;;(require 'init-groovy)
;;(require 'init-ruby)
(require 'init-golang)
(require 'init-rust)

;;Load server for emacsclient
(require 'init-load-server)
