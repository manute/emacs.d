(require 'flycheck)

;;THANKS BODIL -> https://github.com/bodil/ohai-emacs/blob/73e1ab0c4fd3dc11a1717d311ae8858d084fd581/modules/ohai-flycheck.el
;; Start it automatically for all modes except ELisp mode,
;; where the linter is just designed to make you mad.
(add-hook 'find-file-hook
          (lambda ()
            (when (not (equal 'emacs-lisp-mode major-mode))
              (flycheck-mode))))

;; Jump between current errors with M-n and M-p.
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)

;; Turn the modeline red when Flycheck has errors.
(require 'flycheck-color-mode-line)

;; Configure the theme.

(with-eval-after-load "flycheck"
  (setq flycheck-highlighting-mode 'symbols)
  (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)
  (set-face-background 'flycheck-error "#660000")
  (set-face-foreground 'flycheck-error nil)
  (set-face-background 'flycheck-warning "#331800")
  (set-face-foreground 'flycheck-warning nil)
  (set-face-background 'flycheck-color-mode-line-error-face "#440000")
  (set-face-background 'flycheck-color-mode-line-warning-face "#553300")
  (set-face-background 'flycheck-color-mode-line-info-face nil)
  (set-face-foreground 'flycheck-color-mode-line-error-face "#ffffff")
  (set-face-foreground 'flycheck-color-mode-line-warning-face "#ffffff")
  (set-face-foreground 'flycheck-color-mode-line-info-face nil))

(provide 'init-flycheck)
