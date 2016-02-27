(use-package company
  :ensure t
  :config
  (global-company-mode)
  (setq company-global-modes '(not term-mode))
  (setq company-tooltip-limit 20)                    ; bigger popup window
  (setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                          ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (setq company-tooltip-align-annotations t)

  ;; Sort completion candidates that already occur in the current
  ;; buffer at the top of the candidate list.
  (setq company-transformers '(company-sort-by-occurrence))

  (use-package company-quickhelp
    :ensure t
    :config
    (setq company-quickhelp-delay 1)
    (company-quickhelp-mode 1))

  :bind ("TAB" . company-indent-or-complete-common)
  :defer t)

(provide 'init-autocomplete)
