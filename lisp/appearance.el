(when (eq system-type 'darwin)
  (setq mac-allow-anti-aliasing t)  ;; nice fonts in OS X
  ;; Fira Code enabled
  ;; https://github.com/tonsky/FiraCode/wiki/Setting-up-Emacs
  (when (member "Fira Code" (font-family-list))
    (add-to-list 'initial-frame-alist '(font . "Fira Code-14"))
    (add-to-list 'default-frame-alist '(font . "Fira Code-14")))
  ;; Emoji
  (set-fontset-font t 'symbol (font-spec :family "Apple Symbols") nil 'prepend)
  (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend)
  (if (display-graphic-p)
      (set-face-attribute 'default nil :height 140)
    (set-face-attribute 'default nil :height 130)))


(ignore-errors (set-frame-font "Menlo-14"))

(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-dired
  :ensure t
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package memoize
  :ensure t)

;; Install all the fonts located in root emacs folder 'fonts'.
;; This package installs also all-the-icons.
;; https://github.com/NicolasPetton/zerodark-theme
(use-package zerodark-theme
  :ensure t
  :config
  (zerodark-setup-modeline-format)
  (zerodark--active-window-p)
  (setq zerodark-use-paddings-in-mode-line nil)
  (zerodark-modeline-flycheck-status))

(load-theme 'zerodark t)


;; use spacemacs-theme
;; (unless (package-installed-p 'spacemacs-theme)
;;   (package-install 'spacemacs-theme))


;; (use-package spaceline
;;   :ensure t
;;   :if window-system
;;   :config
;;   (load-theme 'spacemacs-light t)
;;   (require 'spaceline-config)
;;   (spaceline-emacs-theme))

(use-package ns-auto-titlebar
  :ensure t
  :if (display-graphic-p)
  :config (ns-auto-titlebar-mode))


;; (use-package powerline
;;   :ensure t)

;; (use-package spaceline
;;   :if (display-graphic-p)
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
