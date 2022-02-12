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

(info "(modus-themes) Customization Options")
;;;;;;;;;;;;;;;;;;
;; LIGHT MODE
;;;;;;;;;;;;;;;;;;

(use-package modus-themes
  :ensure t
  :init
  ;; Add all your customizations prior to loading the themes
     (setq modus-themes-italic-constructs t
           modus-themes-bold-constructs nil
           modus-themes-mixed-fonts nil
           modus-themes-subtle-line-numbers nil
           modus-themes-deuteranopia t
           modus-themes-tabs-accented t
           modus-themes-variable-pitch-ui nil
           modus-themes-inhibit-reload t ; only applies to `customize-set-variable' and related

           modus-themes-fringes nil ; {nil,'subtle,'intense}

           ;; Options for `modus-themes-lang-checkers' are either nil (the
           ;; default), or a list of properties that may include any of those
           ;; symbols: `straight-underline', `text-also', `background',
           ;; `intense' OR `faint'.
           modus-themes-lang-checkers nil

           ;; Options for `modus-themes-mode-line' are either nil, or a list
           ;; that can combine any of `3d' OR `moody', `borderless',
           ;; `accented', and a natural number for extra padding
           modus-themes-mode-line '(4 accented borderless)

           ;; Options for `modus-themes-markup' are either nil, or a list
           ;; that can combine any of `bold', `italic', `background',
           ;; `intense'.
           modus-themes-markup '(background italic)

           ;; Options for `modus-themes-syntax' are either nil (the default),
           ;; or a list of properties that may include any of those symbols:
           ;; `faint', `yellow-comments', `green-strings', `alt-syntax'
           modus-themes-syntax nil

           ;; Options for `modus-themes-hl-line' are either nil (the default),
           ;; or a list of properties that may include any of those symbols:
           ;; `accented', `underline', `intense'
           modus-themes-hl-line '(underline accented)

           ;; Options for `modus-themes-paren-match' are either nil (the
           ;; default), or a list of properties that may include any of those
           ;; symbols: `bold', `intense', `underline'
           modus-themes-paren-match '(bold intense)

           ;; Options for `modus-themes-links' are either nil (the default),
           ;; or a list of properties that may include any of those symbols:
           ;; `neutral-underline' OR `no-underline', `faint' OR `no-color',
           ;; `bold', `italic', `background'
           modus-themes-links '(neutral-underline background)

           ;; Options for `modus-themes-prompts' are either nil (the
           ;; default), or a list of properties that may include any of those
           ;; symbols: `background', `bold', `gray', `intense', `italic'
           modus-themes-prompts '(intense bold)

           modus-themes-completions 'moderate ; {nil,'moderate,'opinionated}

           modus-themes-mail-citations nil ; {nil,'intense,'faint,'monochrome}

           ;; Options for `modus-themes-region' are either nil (the default),
           ;; or a list of properties that may include any of those symbols:
           ;; `no-extend', `bg-only', `accented'
           modus-themes-region '(bg-only no-extend)

           ;; Options for `modus-themes-diffs': nil, 'desaturated, 'bg-only
           modus-themes-diffs 'desaturated

           modus-themes-org-blocks 'gray-background ; {nil,'gray-background,'tinted-background}

           modus-themes-org-agenda ; this is an alist: read the manual or its doc string
           '((header-block . (variable-pitch 1.3))
             (header-date . (grayscale workaholic bold-today 1.1))
             (event . (accented varied))
             (scheduled . uniform)
             (habit . traffic-light))

           modus-themes-headings ; this is an alist: read the manual or its doc string
           '((1 . (overline background variable-pitch 1.3))
             (2 . (rainbow overline 1.1))
             (t . (semibold))))

  ;; Load the theme files before enabling a theme (else you get an error).
  (modus-themes-load-themes)
  :config
  ;; Load the theme of your choice:
  ;; (modus-themes-load-operandi) ;; light
  (modus-themes-load-vivendi) ;; dark
  :bind ("<f5>" . modus-themes-toggle)
  )



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
