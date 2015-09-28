
;; Debug

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(require 'python)
(define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)

;; Ignored Python bytecode in dired
(add-to-list 'dired-omit-extensions ".pyc")

(require 'virtualenvwrapper)
(venv-initialize-interactive-shells) ;; if you want interactive shell support
(venv-initialize-eshell) ;; if you want eshell support
(setq venv-location "~/.virtualenvs/")

(defun my:configure-python-venv ()
  "Set `python-shell-virtualenv-path' to the virtualenv directory."
  (interactive)
  (require 'projectile)
  (let* ((project-name (projectile-project-name))
         (virtualenv-path
          (file-truename
           (concat venv-location project-name))))
    (when (file-directory-p virtualenv-path)
      (setq python-shell-virtualenv-path virtualenv-path))))

(add-hook 'python-mode-hook #'my:configure-python-venv)

(provide 'init-python)
