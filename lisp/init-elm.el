;; THANKS TO
;; http://www.lambdacat.com/post-modern-emacs-setup-for-elm/
;; https://github.com/avdgaag/dotfiles/blob/master/home/.emacs.d/modules/ag-elm.el
(use-package elm-mode
  :ensure t
  :mode ("\\.elm\\'" . elm-mode)
  :init
  (add-hook 'elm-mode-hook #'elm-oracle-setup-completion)
  (setq elm-format-on-save t)
  (setq elm-indent-offset 4)
  (setq elm-tags-on-save t)
  :config
  (add-to-list 'company-backends 'company-elm))

(use-package flycheck-elm
  :ensure t
  :after elm-mode
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-elm-setup))


(provide 'init-elm)
