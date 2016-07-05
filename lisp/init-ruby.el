(use-package ruby-mode
  :mode (("Rakefile\\'" . ruby-mode)
         (".rake\\'" . ruby-mode)
         ("\\.rb\\'" . ruby-mode)
         ("\\.builder\\'" . ruby-mode)
         ("\\.ru\\'" . ruby-mode)
         ("\\.gemspec\\'" . ruby-mode)
         ("Gemfile\\'" . ruby-mode))
  :config
  (setq ruby-use-encoding-map nil))

(use-package robe
  :after ruby-mode
  :ensure t
  :config  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package rbenv
    :after ruby-mode
    :ensure t
    :config   (setq rbenv-installation-dir "~/rbenv"))

(provide 'init-ruby)
