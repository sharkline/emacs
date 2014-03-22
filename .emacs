;;;;;;;;;;;;;;;;;;;;;
;; Env configs
;;;;;;;;;;;;;;;;;;;;;

;; Load .emacs directory
(add-to-list 'load-path "~/.emacs.d")

;; Live dangerously, set options to y/n
(fset `yes-or-no-p `y-or-n-p)

;; Set four spaces to indent
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; Enable ido mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)
(setq ido-auto-merge-work-directories-length -1)

;; Spell check in text mode
(add-hook 'text-mode-hook 'turn-on-flyspell)

;;;;;;;;;;;;;;;;;;;;;
;; Python configs
;;;;;;;;;;;;;;;;;;;;;

;; Enable mouse support
(require 'mouse)
(xterm-mouse-mode t)
(defun track-mouse (e)) 
(setq mouse-sel-mode t)

(when (load "flymake" t)
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.emacs.d/flymake-python/pyflymake.py" (list local-file))))
      ;;     check path

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Always turn flymake on
(add-hook 'find-file-hook 'flymake-find-file-hook)

;; Automatically remove trailing whitespace when file is saved.
(add-hook 'python-mode-hook
      (lambda()
        (add-hook 'local-write-file-hooks
              '(lambda()
                 (save-excursion
                   (delete-trailing-whitespace))))))

;; Show pylint/pep8 info messages
(defun python-flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))

(add-hook 'post-command-hook 'python-flymake-show-help)

;; Enable spell check in python
(add-hook 'python-mode-hook 'flyspell-prog-mode)

;;;;;;;;;;;;;;;;;;;;;
;; Go configs
;;;;;;;;;;;;;;;;;;;;;

;; Enable go-mode
(add-to-list 'load-path "~/.emacs.d/flymake-go")
(require 'go-mode-load)