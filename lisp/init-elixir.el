(use-package elixir-mode
  :ensure t
  :mode (("\\.ex[s]\\'" . elixir-mode)
         ("\\.elixir[2]\\'" . elixir-mode))
  :config
  (add-to-list 'elixir-mode-hook
             (defun auto-activate-ruby-end-mode-for-elixir-mode ()
               (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                    "\\(?:^\\|\\s-+\\)\\(?:do\\)")
               (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
               (ruby-end-mode +1)))

  (add-hook 'elixir-mode-hook #'company-mode)

  ;; NO FLYCHECK YET
  ;; (add-hook 'elixir-mode-hook #'flycheck-mode)

  (use-package alchemist
    :ensure t
    :config
    (add-hook 'elixir-mode-hook #'alchemist-mode)))

(provide 'init-elixir)
