;;Install
;; virtualenv (apt-get)
;; mkvirtualenv (pip install)

;;;;; ZSH config ;;;;;;;;;;;;;;;;;;;
;export WORKON_HOME=$HOME/.virtualenvs
;export PROJECT_HOME=$HOME/projects
;export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
;source /usr/local/bin/virtualenvwrapper_lazy.sh
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Debug
;;------------------
(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))

(defun manu/configure-python-venv ()
  "Set `python-shell-virtualenv-path' to the virtualenv directory."
  (interactive)
  (require 'projectile)
  (let* ((project-name (projectile-project-name))
         (virtualenv-path
          (file-truename
           (concat venv-location project-name))))
    (when (file-directory-p virtualenv-path)
      (setq python-shell-virtualenv-path virtualenv-path))))


(use-package python
  :ensure t
  :mode ("\\.py\\'" . python-mode)
  :config
  ;; Ignored Python bytecode in dired
  (add-to-list 'dired-omit-extensions ".pyc")
  (add-hook 'python-mode-hook #'my:configure-python-venv)
  (define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)

  (use-package virtualenvwrapper
    :ensure t
    :config
    (setq venv-location "~/.virtualenvs/")))

(provide 'init-python)
