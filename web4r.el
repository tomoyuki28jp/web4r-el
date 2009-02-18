; web4r.el
; 
; Copyright (c) Tomoyuki Matsumoto
; BSD license - http://www.opensource.org/licenses/bsd-license.php
; 
; Configurations:
;  1. Make sure web4r.el is in your load-path
;  2. Add following line to your .emacs file
;     (load "web4r")
; 
;  Note: this elisp affects entire lisp mode.

; --- auto-mode-alist -------------------------------------------

(defvar web4r-additional-extensions '("\\.shtml$"))

(mapcar #'(lambda (e)
            (add-to-list 'auto-mode-alist (cons e 'lisp-mode)))
          web4r-additional-extensions)

; --- Indentations and Font lock faces --------------------------

(defun web4r-face (symbol face)
  (let* ((key (symbol-name symbol))
         (reg (concat "\\(" key " \\|" key "\n\\)")))
    (font-lock-add-keywords
     'lisp-mode (list (cons reg face)))))

(defun web4r-func (symbol indent face)
  (put symbol 'lisp-indent-function indent))
  (web4r-face symbol face))

(put 'defpage 'lisp-indent-hook 'defun)
(web4r-face 'defpage 'font-lock-keyword-face)

(web4r-func 'while                1   'font-lock-keyword-face)
(web4r-func 'aif                  2   'font-lock-keyword-face)
(web4r-func 'awhen                1   'font-lock-keyword-face)
(web4r-func 'aand                 nil 'font-lock-keyword-face)
(web4r-func 'awhile               1   'font-lock-keyword-face)
(web4r-func 'define-shtml         nil 'font-lock-keyword-face)
(web4r-func 'form-for/cont/       1   'font-lock-function-name-face)
(web4r-func 'a/cont/              1   'font-lock-function-name-face)
(web4r-func 'form/cont/           1   'font-lock-function-name-face)
(web4r-func 'multipart-form/cont/ 1   'font-lock-function-name-face)
(web4r-func 'page-lambda          2   'font-lock-keyword-face)
(web4r-func 'defpclass            3   'font-lock-keyword-face)

(mapcar
 #'(lambda (x) (web4r-face x 'font-lock-function-name-face))
   '(bdo/       big/       blockquote/  body/        button/
     caption/   cite/      code/        colgroup/    dd/
     del/       dfn/       div/         dl/          dt/
     em/        fieldset/  form/        font/        h1/
     h2/        h3/        h4/          h5/          h6/
     head/      html/      i/           ins/         kbd/
     label/     legend/    li/          map/         noscript/
     object/    ol/        optgroup/    option/      p/
     pre/       q/         samp/        script/      select/
     small/     span/      strong/      style/       sub/
     sup/       table/     textarea/    tbody/       td/
     tfoot/     th/        thead/       title/       tr/
     tt/        ul/        var/         a/           b/
     br/        area/      base/        basefont/    col/
     frame/     hr/        img/         input/       isindex/
     link/      meta/      param/       input-text/  submit/))
