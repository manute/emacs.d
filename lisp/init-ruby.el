;; Basic ruby setup
(require 'rbenv)
(require 'ruby-mode)
(require 'inf-ruby)
(require 'ac-inf-ruby)
(require 'robe)
(require 'ruby-compilation)

;;Rbenv
(setq rbenv-installation-dir "~/rbenv")

(add-to-list 'auto-mode-alist
             '("Rakefile\\'" "\\.rake\\'" "\\.rxml\\'"
               "\\.rjs\\'" "\\.irbrc\\'" "\\.pryrc\\'"
               "\\.builder\\'" "\\.ru\\'" "\\.gemspec\\'"
               "Gemfile\\'"
               . ruby-mode))

(add-hook 'ruby-mode-hook 'robe-mode)

(setq ruby-use-encoding-map nil)

(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(provide 'init-ruby)
