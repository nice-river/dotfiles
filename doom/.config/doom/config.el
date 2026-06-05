;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Maple Mono NF CN" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq doom-font-increment 1)
(map! :desc "Increase font" "C-=" #'doom/increase-font-size)
(map! :desc "Decrease font" "C--" #'doom/decrease-font-size)

;;; Python configuration — basedpyright + ruff

;; Use basedpyright as the Python LSP server (instead of default pyright)
(with-eval-after-load 'eglot
  (setf (alist-get 'python-mode eglot-server-programs)
        '("basedpyright-langserver" "--stdio"))
  (setf (alist-get 'python-ts-mode eglot-server-programs)
        '("basedpyright-langserver" "--stdio")))

;; basedpyright LSP settings — enables ruff integration for additional diagnostics
(with-eval-after-load 'python
  (add-hook 'python-mode-hook
            (lambda ()
              (setq-local eglot-workspace-configuration
                          '(:basedpyright (:analysis
                                           (:typeCheckingMode "standard"
                                            :diagnosticMode "openDocumentsOnly")
                                           :disableLanguageServices nil))))))

;; Ruff as the formatter (requires :editor format)
(set-formatter! 'ruff-format
  '("ruff" "format" "--stdin-filename" filepath)
  :modes '(python-mode python-ts-mode))

;; Make ruff-format the default formatter for Python
(with-eval-after-load 'apheleia
  (setf (alist-get 'python-mode apheleia-mode-alist) 'ruff-format)
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'ruff-format))

;;; Rust configuration — rust-analyzer

;; Use rust-analyzer as the Rust LSP server
(with-eval-after-load 'eglot
  (setf (alist-get 'rust-mode eglot-server-programs)
        '("rust-analyzer"))
  (setf (alist-get 'rust-ts-mode eglot-server-programs)
        '("rust-analyzer")))

;; rust-analyzer LSP settings
(with-eval-after-load 'rust-mode
  (add-hook 'rust-mode-hook
            (lambda ()
              (setq-local eglot-workspace-configuration
                          '(:rust-analyzer
                            (:check (:command "clippy"
                                     :extraArgs ["--"]
                                     :allTargets t)
                             :cargo (:allTargets t)))))))

;; Rustfmt as the formatter (requires :editor format)
(set-formatter! 'rustfmt
  '("rustfmt" "--emit" "stdout")
  :modes '(rust-mode rust-ts-mode))

;; Make rustfmt the default formatter for Rust
(with-eval-after-load 'apheleia
  (setf (alist-get 'rust-mode apheleia-mode-alist) 'rustfmt)
  (setf (alist-get 'rust-ts-mode apheleia-mode-alist) 'rustfmt))
