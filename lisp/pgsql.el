(add-hook 'sql-interactive-mode-hook (lambda ()
                                       (local-set-key (kbd "<tab>") 'dabbrev-expand)))


(provide 'pgsql)
