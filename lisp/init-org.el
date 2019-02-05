(require 'org)
(setq org-src-fontify-natively t)

(setq org-agenda-files '("~/org"))
(global-set-key (kbd "C-c a") 'org-agenda)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (python . t)
   (sh . t)
   (haskell . t)
   (js . t)
   (latex . t)
   (gnuplot . t)
   (C . t)
   (sql . t)
   (ditaa . t)
   ))

(setq org-src-tab-acts-natively t)
(setq org-src-fontify-natively t)
(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
                              "xelatex -interaction nonstopmode %f"))

;; export to markdown mode
(eval-after-load "org"
  '(require 'ox-md nil t))

(provide 'init-org)
