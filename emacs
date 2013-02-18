; disable menu-bar-mode
;(menu-bar-mode nil)

; disable tool-bar-mode
(tool-bar-mode nil)

;; cololum and line number on minibuffer
(setq column-number-mode t)
(setq line-number-mode t)

; no startup message
(setq inhibit-startup-message t)

; image file mode
(setq auto-image-file-mode t)

; display time
(display-time-mode t)
(setq display-time-24hr-format t)

; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

; show match parenthsis
(show-paren-mode t)

; selection-highlighting
(transient-mark-mode t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; plugins
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/")

; irc clinet on emacs
(require 'erc)

; git-emacs
(add-to-list 'load-path "~/.emacs.d/plugins/git-emacs")
(require 'git-emacs)

; ibuffer-mode
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

; ido
(add-to-list 'load-path "~/.emacs.d/plugins/ido")
(require 'ido)
(ido-mode t)
