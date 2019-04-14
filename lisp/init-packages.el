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

(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'yasnippet)
(require 'org-pomodoro)
;;只在编程环境下激活
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
;;实现了vim的大部分功能
;;这里只完成了一部分配置，参考day7 emacs21
;;(evil-mode 1)
;;使evil的insert state map状态清空，回退到emacs state状态中
;;(setcdr evil-insert-state-map nil)
;;(define-key evil-insert-state-map [escape] 'evil-normal-state)

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook
	  (lambda ()
	    (set (make-local-variable 'company-backends) '((company-anaconda company-dabbrev-code)
							   company-dabbrev))))

(provide 'init-packages)
