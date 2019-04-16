;; Fira Code enabled
;; https://github.com/tonsky/FiraCode/wiki/Setting-up-Emacs
(set-default-font "Fira Code" nil t)

(use-package memoize
  :ensure t)

(use-package base16-theme
  :ensure t
  :if (not window-system)
  :config
  (load-theme 'base16-onedark t))

;; Install all the fonts located in root emacs folder 'fonts'.
;; This package installs also all-the-icons.
;; https://github.com/NicolasPetton/zerodark-theme
(use-package zerodark-theme
  :ensure t
  :if window-system
  :config
  (zerodark-setup-modeline-format)
  (zerodark--active-window-p)
  ;; (setq zerodark-use-paddings-in-mode-line nil)
  (zerodark-modeline-flycheck-status)
  )

(use-package ns-auto-titlebar
  :ensure t
  :if window-system
  :config (ns-auto-titlebar-mode))


;; (use-package powerline
;;   :ensure t)

;; (use-package spaceline
;;   :if window-system
;;   :ensure t
;;   :after powerline
;;   :config
;;   (require 'spaceline-config)
;;   (setq powerline-default-separator (quote arrow))
;;   (setq powerline-height 20)
;;   (spaceline-emacs-theme)
;;   (spaceline-helm-mode 1))

;; (use-package spaceline-all-the-icons
;;   :ensure t
;;   :after spaceline
;;   :init (setq-default spaceline-all-the-icons-separator-type 'arrow)
;;   :config
;;   (spaceline-all-the-icons--setup-package-updates)
;;   (spaceline-all-the-icons--setup-git-ahead)
;;   (spaceline-all-the-icons--height 25)
;;   ;; (spaceline-all-the-icons--flycheck-status-slim)
;;   (spaceline-all-the-icons-theme))

(when (eq system-type 'darwin)
  (setq mac-allow-anti-aliasing t)  ;; nice fonts in OS X
  (if (window-system)
      (set-face-attribute 'default nil :height 140)
    (set-face-attribute 'default nil :height 125)))

(defun manu/set-font-height (h)
  (set-face-attribute 'default nil :height h))

(when (eq system-type 'gnu/linux)
  (set-face-attribute 'default nil :height 116))


;; Fira Code ligatures
;; https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
(let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
               (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
               (36 . ".\\(?:>\\)")
               (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
               (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
               (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
               (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
               (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
               ;; (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)") ;; comment in error CIDER
               (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
               (48 . ".\\(?:x[a-zA-Z]\\)")
               (58 . ".\\(?:::\\|[:=]\\)")
               (59 . ".\\(?:;;\\|;\\)")
               (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
               (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
               (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
               (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
               (91 . ".\\(?:]\\)")
               (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
               (94 . ".\\(?:=\\)")
               (119 . ".\\(?:ww\\)")
               (123 . ".\\(?:-\\)")
               (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
               (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
               )))
  (dolist (char-regexp alist)
    (set-char-table-range composition-function-table (car char-regexp)
                          `([,(cdr char-regexp) 0 font-shape-gstring]))))

(setq-default truncate-lines 1)  ;; no word wrap
(setq-default line-spacing 4)

(provide 'appearance)
