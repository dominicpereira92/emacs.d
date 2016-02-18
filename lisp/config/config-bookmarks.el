;;; Configuration for bookmarks

(require 'recentf)
(require 'breadcrumb)

(setq recentf-max-menu-items 40)

(defun bc-clear-and-msg ()
  (interactive)
  (bc-clear)
  (message "All breadcrumbs deleted!"))

(global-set-key (kbd "C-c C-: C-;") 'recentf-open-files)
(global-set-key (kbd "C-c C-: C-:") 'bc-list)
(global-set-key (kbd "C-c C-: C-=") 'bc-set)
(global-set-key (kbd "C-c C-: C-#") 'bc-clear-and-msg)
(global-set-key (kbd "C-c C-: C-<left>") 'bc-previous)
(global-set-key (kbd "C-c C-: C-b") 'bc-previous)
(global-set-key (kbd "C-c C-: C-<right>") 'bc-next)
(global-set-key (kbd "C-c C-: C-f") 'bc-next)
(global-set-key (kbd "C-c C-: C-<up>") 'bc-local-previous)
(global-set-key (kbd "C-c C-: C-p") 'bc-local-previous)
(global-set-key (kbd "C-c C-: C-<down>") 'bc-local-next)
(global-set-key (kbd "C-c C-: C-n") 'bc-local-next)

(global-set-key (kbd "C-c : ;") 'recentf-open-files)
(global-set-key (kbd "C-c : :") 'bc-list)
(global-set-key (kbd "C-c : =") 'bc-set)
(global-set-key (kbd "C-c : #") 'bc-clear-and-msg)
(global-set-key (kbd "C-c : <left>") 'bc-previous)
(global-set-key (kbd "C-c : b") 'bc-previous)
(global-set-key (kbd "C-c : <right>") 'bc-next)
(global-set-key (kbd "C-c : f") 'bc-next)
(global-set-key (kbd "C-c : <up>") 'bc-local-previous)
(global-set-key (kbd "C-c : p") 'bc-local-previous)
(global-set-key (kbd "C-c : <down>") 'bc-local-next)
(global-set-key (kbd "C-c : n") 'bc-local-next)

(provide 'config-bookmarks)
