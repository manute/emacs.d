(when (eq system-type 'darwin)
  (setq mac-allow-anti-aliasing t)  ;; nice fonts in OS X
  ;; Emoji
  (set-fontset-font t 'symbol (font-spec :family "Apple Symbols") nil 'prepend)
  (set-fontset-font t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))

;; On Linux
;; Download from: https://www.nerdfonts.com/font-downloads
;; Install one (e.g., FiraCode Nerd Font).
;; Restart Emacs after selecting it as your font.

;; On Macos
;; brew tap homebrew/cask-fonts
;; brew install --cask font-fira-code-nerd-font

(when (member "FiraCode Nerd Font" (font-family-list))
  (add-to-list 'initial-frame-alist '(font . "FiraCode Nerd Font-11"))
  (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-11")))

;; (if (display-graphic-p)
;;     (set-face-attribute 'default nil :height 120)
;; (set-face-attribute 'default nil :height 120))
;; (ignore-errors (set-frame-font "Menlo-14"))

(use-package memoize
  :ensure t)

;; Install all the fonts located in root emacs folder 'fonts'.
;; This package installs also all-the-icons.
;; https://github.com/NicolasPetton/zerodark-theme
;; Load Zerodark theme first
(use-package zerodark-theme
  :ensure t
  :config
  (load-theme 'zerodark t))

(use-package nerd-icons
  :ensure t)

;; Doom modeline integrated with Zerodark
(use-package doom-modeline
  :ensure t
  :after zerodark-theme
  :init
  (doom-modeline-mode 1)
  (setq doom-modeline-height 27
        doom-modeline-bar-width 3
        doom-modeline-icon t
        doom-modeline-major-mode-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-project
        doom-modeline-minor-modes nil))

;; Optional: adjust modeline faces for Zerodark
(with-eval-after-load 'doom-modeline
  (set-face-attribute 'mode-line nil
                      :background (face-attribute 'default :background)
                      :foreground (face-attribute 'default :foreground)
                      :box nil)
  (set-face-attribute 'mode-line-inactive nil
                      :background (face-attribute 'default :background)
                      :foreground "gray40"
                      :box nil))

(use-package ns-auto-titlebar
  :ensure t
  :if (display-graphic-p)
  :config (ns-auto-titlebar-mode))

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
(set-face-attribute 'default nil :height 110)
(setq nerd-icons-scale-factor 1.0)  ;; adjust size globally
(setq doom-modeline-icon t)         ;; ensure icons are enabled

(provide 'appearance)
