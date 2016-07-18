
(defun manu/my-elixir-do-end-close-action (id action context)
  (when (eq action 'insert)
    (newline-and-indent)
    (forward-line -1)
    (indent-according-to-mode)))


(use-package elixir-mode
  :ensure t
  :mode (("\\.ex[s]\\'" . elixir-mode)
         ("\\.elixir[2]\\'" . elixir-mode))
  :config

  ;; NOT YET FLYCHECK
  ;; (add-hook 'elixir-mode-hook #'flycheck-mode)

  (sp-with-modes '(elixir-mode)
    (sp-local-pair "->" "end"
                   :when '(("RET"))
                   :post-handlers '(:add my-elixir-do-end-close-action)
                   :actions '(insert)))

  (sp-with-modes '(elixir-mode)
    (sp-local-pair "do" "end"
                   :when '(("SPC" "RET"))
                   :post-handlers '(:add my-elixir-do-end-close-action)
                   :actions '(insert))))

(use-package alchemist
  :after elixir-mode
  :ensure t
  :config
  (add-hook 'elixir-mode-hook #'alchemist-mode))

(provide 'init-elixir)
