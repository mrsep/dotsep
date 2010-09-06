;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

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
