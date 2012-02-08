;;; Emacs Configuration of Hans Peschke, aka sep
;;;

;; package.el
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))

;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))


;; Org-Mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook       (lambda () (paredit-mode +1)))


;; Erlang-Mode
(setq load-path (cons "/usr/lib/erlang/lib/tools-2.6.5/emacs" load-path))
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
(require 'erlang-start)


;; Auctex
(load "auctex.el" nil t t)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
(add-hook 'LaTeX-mode-hook 'turn-on-font-lock)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(setq-default TeX-master nil) ; Query for master file.
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Satzende ". " statt ". ". " f ̈r M-k: l ̈schen bis Satzende usw.
(setq sentence-end "[.?!][]\"’)}]*\\($\\| \\| \\)[
;;]*") ;; Da ist ein "Newline in der Zeile!"
(setq sentence-end-double-space nil)
;;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(load "preview-latex.el" nil t t)
(setq-default ispell-program-name "aspell")
(add-hook 'TeX-language-de-hook
  (function (lambda () (ispell-change-dictionary "german8"))))

(defun TeX-toggle-escape nil (interactive) 
  (setq LaTeX-command 
        (if (string= LaTeX-command "latex") "latex -shell-escape" "latex"))) 

(add-hook 'LaTeX-mode-hook 
          '(lambda () 
             (define-key LaTeX-mode-map "\C-c\C-t\C-x" 'TeX-toggle-escape)))



;; SLIME
;; use the latest version of slime:
;; either: git clone git://github.com/nablaone/slime.git to ~/.emacs.d/
;; or: git pull in ~/.emacs.d/

(add-to-list 'load-path "~/.emacs.d/slime")
(eval-after-load "slime"
  '(progn
     (add-to-list 'load-path "~/.emacs.d/slime/contrib")
     (add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))
     (setq inferior-lisp-program "sbcl"
           slime-protocol-version 'ignore
           slime-net-coding-system 'utf-8-unix
	   ;; lisp-indent-function 'common-lisp-indent-function
	   slime-complete-symbol-function 'slime-fuzzy-complete-symbol
	   slime-complete-symbol*-fancy t
	   slime-startup-animation t)
     ;; common-lisp-hyperspec-root ""
     (set-language-environment "UTF-8")
     (slime-setup '(slime-repl slime-banner slime-fuzzy))
     (defun paredit-mode-enable () (paredit-mode 1))	
     (add-hook 'slime-mode-hook 'paredit-mode-enable)	
     (add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
     (add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
     (add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))))
(require 'slime)
(require 'slime-autoloads)


;; Haskell-Hugs
(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)

(autoload 'hugs-mode "hugs-mode" "Go into hugs mode" t)

(setq auto-mode-alist (append auto-mode-alist
                        '(("\\.hs$" . hugs-mode))))


;; Scheme: quack
(require 'quack)
; Always do syntax highlighting
(global-font-lock-mode 1)

; Also highlight parens
(setq show-paren-delay 0
  show-paren-style 'parenthesis)
(show-paren-mode 1)
(setq *print-pretty* t)
; This is the binary name of my scheme implementation
(setq scheme-program-name "scm")


;; IDO-Mode
(require 'ido)
(setq ido-create-new-buffer 'always)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; custom emacs setup
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(ido-mode (quote both) nil (ido))
 '(menu-bar-mode nil)
 '(quack-newline-behavior (quote indent-newline-indent))
 '(quack-pretty-lambda-p t)
 '(quack-smart-open-paren-p t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))


(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-solarized-1.0.0")

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-solarized-dark)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
