(require 'company)

;;Disable autocomplete in favor of company
(global-auto-complete-mode -1)

(global-company-mode)
(global-set-key (kbd "C-c a") 'company-complete)

(setq company-global-modes '(not term-mode))


;; (setq company-minimum-prefix-length 2
;;       company-selection-wrap-around t
;;       company-show-numbers t
;;       company-tooltip-align-annotations t
;;       company-require-match nil
;;       company-dabbrev-downcase nil
;;       company-dabbrev-ignore-case nil)

(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
(setq company-echo-delay 0)                          ; remove annoying blinking
(setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing


;; Sort completion candidates that already occur in the current
;; buffer at the top of the candidate list.
(setq company-transformers '(company-sort-by-occurrence))

;; Show documentation where available for selected completion
;; after a short delay.
(require 'company-quickhelp)
(setq company-quickhelp-delay 1)
(company-quickhelp-mode 1)

(provide 'init-autocomplete)
