(require 'cl)

 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (add-to-list 'package-archives '("melpa" . "http://elpa.emacs-china.org/melpa/") t))

;; config for packages
;; add whatever packages you want here
(defvar zheng/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		smex
		swiper
		counsel
		smartparens
		popwin
		expand-region
		iedit
		;; --- Major Mode ---
		js2-mode
		js2-refactor
		web-mode
		markdown-mode
		;; --- Minor Mode ---
		nodejs-repl
		;; --- Themes ---
		monokai-theme
		;; solarized-theme
		) "Default packages")

(setq package-selected-packages zheng/packages)
(defun zheng/packages-installed-p ()
  (loop for pkg in zheng/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))
(unless (zheng/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg zheng/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; config for hungry-delete
(global-hungry-delete-mode)
;; config for smartparens
(smartparens-global-mode t)
(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)
;; config modes for different files
(setq auto-mode-alist
      (append
       '(("/\\.[^/]*\\'" . fundamental-mode)
	 ("/[^\\./]*\\'" . fundamental-mode)
	 ("/[^\\./]*\\'" . fundamental-mode)
	 ("\\.js\\'" . js2-mode)
	 ("\\`/tmp/fol/" . text-mode)
	 ("\\.texinfo\\'" . texinfo-mode)
	 ("\\.texi\\'" . texinfo-mode)
	 ("\\.el\\'" . emacs-lisp-mode)
	 ("\\.C\\'" . c++-mode)
	 ("\\.c\\'" . c-mode)
	 ("\\.h\\'" . c-mode)
       	 ("\\.markdown\\'" . markdown-mode)
	 ("\\.md\\'" . markdown-mode))
       auto-mode-alist))
;; config for nodejs-repl
(require 'nodejs-repl)
;;config for popwin
(require 'popwin)
(popwin-mode t)
;; config for smex
(require 'smex) ;; Not Needed if you use package.el
(smex-initialize) ;; Can be omitted. This might cause a (minimal) delay
(global-set-key (kbd "M-x") 'smex)
;; config for swiper
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
;;config for company mode
(global-company-mode t)
;; load theme
(load-theme 'monokai t)
;;config for web-mode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)
(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))
  (setq indent-tabs-mode nil))
;; config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)
;;config for imenu
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
	;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
	(imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
				   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
				   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	      (lambda ()
		(setq imenu-create-index-function 'js2-imenu-make-index)))

(provide 'init-packages)
