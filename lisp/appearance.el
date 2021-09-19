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

(use-package memoize
  :ensure t)


;;;;;;;;;;;;;;;;;;
;; DARK MODE
;;;;;;;;;;;;;;;;;;

;; (use-package all-the-icons
;;   :ensure t)

;; (all-the-icons-insert-icons-for 'alltheicon)

;; (use-package all-the-icons-dired
;;   :ensure t
;;   :after all-the-icons
;;   :hook (dired-mode . all-the-icons-dired-mode))


;; Install all the fonts located in root emacs folder 'fonts'.
;; This package installs also all-the-icons.
;; https://github.com/NicolasPetton/zerodark-theme
;; (use-package zerodark-theme
;;   :ensure t
;;   :config
;;   (zerodark-setup-modeline-format)
;;   (zerodark--active-window-p)
;;   (setq zerodark-use-paddings-in-mode-line nil)
;;   (zerodark-modeline-flycheck-status))

;; (load-theme 'zerodark t)
;; ;; Optionally setup the modeline
;; (zerodark-setup-modeline-format)


;;;;;;;;;;;;;;;;;;
;; LIGHT MODE
;;;;;;;;;;;;;;;;;;

(use-package modus-themes
  :ensure t
  :init
  ;; Add all your customizations prior to loading the themes
  (setq modus-themes-slanted-constructs t
        modus-themes-bold-constructs nil
        modus-themes-no-mixed-fonts nil
        modus-themes-subtle-line-numbers nil
        modus-themes-success-deuteranopia t

        modus-themes-fringes nil ; {nil,'subtle,'intense}

        ;; Options for `modus-themes-lang-checkers': nil,
        ;; 'straight-underline, 'subtle-foreground,
        ;; 'subtle-foreground-straight-underline, 'intense-foreground,
        ;; 'intense-foreground-straight-underline, 'colored-background
        modus-themes-lang-checkers nil

        ;; Options for `modus-themes-mode-line': nil, '3d, 'moody,
        ;; 'borderless, 'borderless-3d, 'borderless-moody, 'accented,
        ;; 'accented-3d, 'accented-moody
        modus-themes-mode-line '3d

        ;; Options for `modus-themes-syntax': nil, 'faint,
        ;; 'yellow-comments, 'green-strings,
        ;; 'yellow-comments-green-strings, 'alt-syntax,
        ;; 'alt-syntax-yellow-comments, 'faint-yellow-comments
        modus-themes-syntax nil

        ;; Options for `modus-themes-hl-line': nil, 'intense-background,
        ;; 'accented-background, 'underline-neutral,
        ;; 'underline-accented, 'underline-only-neutral,
        ;; 'underline-only-accented
        modus-themes-hl-line 'underline-neutral

        modus-themes-paren-match 'subtle-bold ; {nil,'subtle-bold,'intense,'intense-bold}

        ;; Options for `modus-themes-links': nil, 'faint,
        ;; 'neutral-underline, 'faint-neutral-underline, 'no-underline,
        ;; 'underline-only, 'neutral-underline-only
        modus-themes-links 'neutral-underline

        ;; Options for `modus-themes-prompts': nil, 'subtle-accented,
        ;; 'intense-accented, 'subtle-gray, 'intense-gray
        modus-themes-prompts 'subtle-gray

        modus-themes-completions 'moderate ; {nil,'moderate,'opinionated}

        ;; Options for `modus-themes-region': nil, 'no-extend, 'bg-only,
        ;; 'bg-only-no-extend, 'accent, 'accent-no-extend
        modus-themes-region 'bg-only-no-extend

        ;; Options for `modus-themes-diffs': nil, 'desaturated,
        ;; 'bg-only, 'deuteranopia, 'fg-only-deuteranopia
        modus-themes-diffs 'fg-only-deuteranopia

        modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}
        modus-themes-org-habit nil ; {nil,'simplified,'traffic-light}

        modus-themes-headings ; this is an alist: read the manual or its doc string
        '((1 . line)
          (2 . rainbow-line-no-bold)
          (t . no-bold))

        modus-themes-variable-pitch-ui nil
        modus-themes-variable-pitch-headings t
        modus-themes-scale-headings t
        modus-themes-scale-1 1.1
        modus-themes-scale-2 1.15
        modus-themes-scale-3 1.21
        modus-themes-scale-4 1.27
        modus-themes-scale-5 1.33)
  ;; Load the theme files before enabling a theme (else you get an error).
  (modus-themes-load-themes)
  :config
  ;; Load the theme of your choice:
  (modus-themes-load-operandi) ;; OR (modus-themes-load-vivendi)
  :bind ("<f5>" . modus-themes-toggle))



;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-tomorrow-day t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config))

(use-package ns-auto-titlebar
  :ensure t
  :if (display-graphic-p)
  :config (ns-auto-titlebar-mode))


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
