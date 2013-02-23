;;; Configuration for Clojure

(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
(add-to-list 'same-window-buffer-names "*nrepl*")

(setq clojure-swank-command
      (if (or (locate-file "lein" exec-path) (locate-file "lein.bat" exec-path))
	  "lein ritz-in %s" "echo \"lein ritz-in %s\" | $SHELL -l"))

(defun split-and-nrepl-jack-in ()
  "Split window and start nREPL"
  (interactive)
  (split-window-right)
  (nrepl-jack-in nil))

(defun split-and-nrepl ()
  "Split window and start nREPL client"
  (interactive)
  (split-window-right)
  (nrepl "localhost"
	 (string-to-number (read-from-minibuffer "Port: "))))

(defun load-file-in-nrepl ()
  (interactive)
  (keyboard-escape-quit)
  (split-window-right)
  (nrepl-load-current-buffer)
  (nrepl-set-ns (nrepl-current-ns))
  (nrepl-switch-to-repl-buffer))

(defun clojure-bindings ()
  (local-set-key (kbd "C-x <f10>") 'split-and-nrepl-jack-in)
  (local-set-key (kbd "C-x <f5>") 'load-file-in-nrepl)
  (local-set-key (kbd "C-x <f8>") 'split-and-nrepl))

(defun configure-clojure ()
  (subword-mode)
  (paredit-mode)
  (rainbow-delimiters-mode))

(defun configure-clojure-nrepl ()
  (configure-clojure)
  (clojure-test-mode))

(defun configure-clojure-nrepl-inf ()
  (local-set-key (kbd "C-?") 'nrepl-doc)
  (local-set-key (kbd "C-x T") 'clojure-test-run-tests)
  (local-set-key (kbd "C-x t") 'clojure-test-run-test))

(add-hook 'clojure-mode-hook 'clojure-bindings)
(add-hook 'clojure-mode-hook 'configure-clojure)
(add-hook 'nrepl-mode-hook 'configure-clojure-nrepl)
(add-hook 'nrepl-interaction-mode-hook 'configure-clojure-nrepl-inf)

(provide 'config-clojure)
