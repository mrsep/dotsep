;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

;; Tabbar-Mode
(require 'tabbar)
(tabbar-mode)

;; Org-Mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

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
(setq reftex-plug-into-AUCTeX t)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; Satzende ". " statt ". ". " f ̈r M-k: l ̈schen bis Satzende usw.
(setq sentence-end "[.?!][]\"’)}]*\\($\\| \\| \\)[
;;]*") ;; Da ist ein "Newline in der Zeile!"
(setq sentence-end-double-space nil)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(load "preview-latex.el" nil t t)
(setq-default ispell-program-name "aspell")
(add-hook 'TeX-language-de-hook
  (function (lambda () (ispell-change-dictionary "german8"))))


;; SLIME
(require 'slime)
(require 'slime-autoloads)
(require 'swank-clojure)
(slime-setup)


;; Adding sbcl to slime
(add-to-list 'slime-lisp-implementations '(sbcl ("sbcl")))

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
(setf *print-pretty* t)
; This is the binary name of my scheme implementation
(setq scheme-program-name "scm")

; WWW: w3m-el-snapshot


; custom emacs setup
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 81 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(require 'color-theme)
(color-theme-initialize)
(color-theme-charcoal-black)