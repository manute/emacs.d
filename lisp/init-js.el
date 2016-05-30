
;; npm install -g eslint babel-eslint eslint-plugin-react
;; file ~/.eslintrc with these rules -> ;; http://codewinds.com/blog/2015-04-02-emacs-flycheck-eslint-jsx.html

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode)
  :config

  (add-hook 'js2-mode-hook #'company-mode)
  (setq flycheck-disable-checker '(javascript-jshint))
  (add-hook 'js2-mode-hook #'smartparens-mode))

(provide 'init-js)
