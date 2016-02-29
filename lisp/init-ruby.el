(require 'ruby-mode)

(add-to-list 'auto-mode-alist
             '("Rakefile\\'" "\\.rake\\'" "\\.rxml\\'"
               "\\.rjs\\'" "\\.irbrc\\'" "\\.pryrc\\'"
               "\\.builder\\'" "\\.ru\\'" "\\.gemspec\\'"
               "Gemfile\\'"
               . ruby-mode))

(setq ruby-use-encoding-map nil)

(use-package robe
  :ensure t
  :config  (add-hook 'ruby-mode-hook 'robe-mode))

(use-package rbenv
  :ensure t
  :config   (setq rbenv-installation-dir "~/rbenv"))

(provide 'init-ruby)
