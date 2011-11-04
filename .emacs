
(add-to-list 'load-path "~/.emacs.d/elpa/color-theme-solarized-1.0.0")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
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


;; Tabbar-Mode
;(require 'tabbar)
;(tabbar-mode)

;; Org-Mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


;; Git Mode Magit
(autoload 'magit-status "magit" nil t)


;; paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))

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


;; SLIME
(eval-after-load "slime"
  '(progn 
     (slime-setup '(slime-repl))	
     (defun paredit-mode-enable () (paredit-mode 1))	
     (add-hook 'slime-mode-hook 'paredit-mode-enable)	
     (add-hook 'slime-repl-mode-hook 'paredit-mode-enable)
     (setq slime-protocol-version 'ignore)))
(require 'slime)
(require 'slime-autoloads)
;(require 'swank-clojure)


;; Adding sbcl to slime
;(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

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

; WWW: w3m-el-snapshot


; custom emacs setup
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (require 'color-theme-solarized)
     (color-theme-solarized-dark)))


