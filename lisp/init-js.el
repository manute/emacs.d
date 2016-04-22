
;; npm install -g eslint babel-eslint eslint-plugin-react
;; file ~/.eslintrc with rules for this url -> ;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :config

  (add-hook 'js2-mode-hook   #'company-mode)

  (add-hook 'js2-mode-hook   #'flycheck-mode)
  (setq flycheck-disable-checker '(javascript-jshint))

  (use-package smartparens
    :ensure t
    :config  (add-hook 'js2-mode-hook #'smartparens-mode)))


(provide 'init-js)
