; Better M-x
(require 'smex)
(global-set-key (kbd "M-x") (lambda ()
			      (interactive)
			      (or (boundp 'smex-cache)
				 (smex-initialize))
			      (global-set-key (kbd "M-x") 'smex)
			      (smex)))

(global-set-key (kbd "M-X") (lambda ()
			      (interactive)
			      (or (boundp 'smex-cache)
				 (smex-initialize))
			      (global-set-key (kbd "M-X") 'smex-major-mode-commands)
			      (smex-major-mode-commands)))

; Ido
(require 'ido)
(ido-mode)
(ido-everywhere)

(require 'ido-ubiquitous)
(ido-ubiquitous-mode)

(require 'ido-vertical-mode)
(ido-vertical-mode)
;(ido-at-point-mode)

; Fuzzy matching
(setq ido-enable-flex-matching t)

; Buffers
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(provide 'init-ido)
