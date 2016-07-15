;; THANKS TO http://www.lambdacat.com/post-modern-emacs-setup-for-elm/
(use-package elm-mode
  :ensure t
  :mode ("\\.elm\\'" . elm-mode)
  :config
  (add-hook 'elm-mode-hook
          (lambda ()
            (setq company-backends '(company-elm)))))

(use-package flycheck-elm
  :ensure t
  :after elm-mode
  :config
  (add-hook 'flycheck-mode-hook 'flycheck-elm-setup))



(provide 'init-elm)
