(require 'racket-mode)


;; (setq racket-racket-program /home/manu/racket/bin/racket)
;; (setq racket-raco-program /home/manu/racket/bin/raco)

(setq tab-always-indent 'complete)

;; Bug exists in Racket company backend that opens docs in new window when
;; company-quickhelp calls it. Note hook is appendended for proper ordering.

(add-hook 'racket-mode-hook
          (lambda ()
            (define-key racket-mode-map (kbd "C-c r") 'racket-run)
            (company-quickhelp-mode -1)))

(add-hook 'racket-repl-mode-hook
          (lambda ()
            (company-quickhelp-mode -1)))


(provide 'init-racket)
