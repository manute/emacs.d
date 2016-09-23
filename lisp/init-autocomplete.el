;; THANKS to lunaryorn https://github.com/lunaryorn/.emacs.d/blob/master/init.el
(use-package company
  :ensure t
  :defer t
  :diminish company-mode
  :init
  ;; (setq completion-at-point-functions '(company-complete-common))
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-global-modes '(not term-mode))
  (setq company-minimum-prefix-length 2
        company-selection-wrap-around t
        company-show-numbers t
        company-tooltip-align-annotations t
        company-require-match nil))

(use-package company-quickhelp          ; Show help in tooltip
  :ensure t
  :after company
  :config (company-quickhelp-mode))

(use-package company-statistics         ; Sort company candidates by statistics
  :ensure t
  :after company
  :config (company-statistics-mode))

(use-package company-math               ; Completion for Math symbols
  :ensure t
  :after company
  :config
  ;; Add backends for math characters
  (add-to-list 'company-backends 'company-math-symbols-unicode)
  (add-to-list 'company-backends 'company-math-symbols-latex))

(use-package company-emoji              ; Emojis completion like Github/Slack
  :ensure t
  :after company
  :config (add-to-list 'company-backends 'company-emoji))


(provide 'init-autocomplete)
