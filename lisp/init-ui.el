;;- turn off tool-bar
;;- turn off scroll-bar
;;- turn off splash screen
;;- set cursor type to bar
;;- full screen
;;- highlight current line
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen t)
(setq-default cursor-type 'bar)
(setq initial-frame-alist (quote ((fullscreen . maximized))))
(global-hl-line-mode t)
(transient-mark-mode t)

;;set mark color
(set-face-background 'region "blue")
(provide 'init-ui)

