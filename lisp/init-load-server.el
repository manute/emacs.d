;;----------------------------------------------
;;Load emacs-server -> $ emacsclient "filename"
;;----------------------------------------------

(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init-load-server)
