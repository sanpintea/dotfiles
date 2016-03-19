(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;; ロードパスの追加
 (setq load-path (append
                  '("~/.emacs.d/elpa"
                    "~/.emacs.d/el-get"
                    )
load-path))

;;パッケージ管理 el-getの設定

(add-to-list 'load-path (locate-user-emacs-file "~/.emacs.d/el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;;パッケージインストールリスト
(el-get-bundle ace-jump-mode)
(el-get-bundle minimap)
(el-get-bundle pkg-info)
(el-get-bundle yasnippet)
(el-get-bundle emmet-mode)
(el-get-bundle helm)
(el-get-bundle ac-js2)
(el-get-bundle company)
(el-get-bundle popup)
(el-get-bundle js2-mode)
(el-get-bundle company-tern)
(el-get-bundle anzu)
(el-get-bundle diminish)
(el-get-bundle rainbow-delimiters)
(el-get-bundle auto-complete)
(el-get-bundle auto-compile)
(el-get-bundle migemo)


;;======================================  emacs環境の設定 始まり
;;;対応するカッコを強調表示
(show-paren-mode t)
;;;時刻表示
(display-time)
;; (setq display-time-string-forms
;;        '((propertize (concat " " 24-hours ":" minutes " ")
;;  		    'face 'egoge-displaeey-time)))
;;(setq display-time-format "%m/%d (%a) %H:%M")
(setq display-time-format "%d日 %H:%M")
;;; Localeに合わせた環境の設定
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)
;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
(tool-bar-mode -1)
;; スクロールバー非表示
(set-scroll-bar-mode nil)

;;行番号表示
(global-linum-mode t)

;; 予約語を色分けする
(global-font-lock-mode t)

;; C-x C-b でバッファリストを開く時に、ウィンドウを分割しない
(global-set-key "\C-x\C-b" 'buffer-menu)

;;; 現在行を目立たせる
(global-hl-line-mode)

;;; カーソルの位置が何文字目かを表示する
(column-number-mode t)

;;; カーソルの位置が何行目かを表示する
(line-number-mode t)

;;; カーソルの場所を保存する
(require 'saveplace)
(setq-default save-place t)

;;; バックアップファイルを作らない
(setq backup-inhibited t)
;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;; タブにスペースを使用する
(setq-default tab-width 4 indent-tabs-mode nil)


;; ウィンドウを透明にする
;; アクティブウィンドウ／非アクティブウィンドウ（alphaの値で透明度を指定）
(add-to-list 'default-frame-alist '(alpha . (0.85 0.85)))

;; カーソルの点滅をやめる
(blink-cursor-mode 0)

;;; 右から左に読む言語に対応させないことで描画高速化
(setq-default bidi-display-reordering nil)

;; 起動時のウィンドウサイズ、色などを設定
(if (boundp 'window-system)
    (setq default-frame-alist
          (append (list
                   ;; '(foreground-color . "black")  ; 文字色
                   ;; '(background-color . "white")  ; 背景色
                   ;; '(border-color     . "white")  ; ボーダー色
                   ;; '(mouse-color      . "black")  ; マウスカーソルの色
                   ;;'(cursor-color     . "black") ; カーソルの色
                   '(cursor-type      . box)      ; カーソルの形状
                   '(top . 50) ; ウィンドウの表示位置（Y座標）
                   '(left . 200) ; ウィンドウの表示位置（X座標）
                   '(width . 100) ; ウィンドウの幅（文字数）
                   '(height . 40) ; ウィンドウの高さ（文字数）
                   )
                  default-frame-alist)))
(setq initial-frame-alist default-frame-alist )

;;フォントファミリーの設定
;;(frame-parameter nil 'font)をscratchで実行して情報を調べる
;;(add-to-list 'default-frame-alist '(font . "Ricty Diminished" ))
(add-to-list 'default-frame-alist '(font . "-outline-Ricty Diminished-normal-normal-normal-mono-16-*-*-*-c-*-iso8859-1" ))

(set-face-attribute 'default t :font "Ricty Diminished" )

;; scratchの初期メッセージ消去
(setq initial-scratch-message "")
;; タイトルバーにファイルのフルパス表示
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
;; 括弧の範囲内を強調表示
(show-paren-mode t)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; 括弧の範囲色
(set-face-background 'show-paren-match-face "#500")
;; 選択領域の色
(set-face-background 'region "#555")


;;全角スペース等を表示する
(setq whitespace-style
      '(tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(require 'whitespace)
(global-whitespace-mode 1)
(set-face-foreground 'whitespace-space "LightSlateGray")
(set-face-background 'whitespace-space "DarkSlateGray")
(set-face-foreground 'whitespace-tab "LightSlateGray")
(set-face-background 'whitespace-tab "DarkSlateGray")

;; モードラインの割合表示を総行数表示
(defvar my-lines-page-mode t)
(defvar my-mode-line-format)
(when my-lines-page-mode
  (setq my-mode-line-format "%d")
  (if size-indication-mode
      (setq my-mode-line-format (concat my-mode-line-format " of %%I")))
  (cond ((and (eq line-number-mode t) (eq column-number-mode t))
         (setq my-mode-line-format (concat my-mode-line-format " (%%l,%%c)")))
        ((eq line-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " L%%l")))
        ((eq column-number-mode t)
         (setq my-mode-line-format (concat my-mode-line-format " C%%c"))))

  (setq mode-line-position
        '(:eval (format my-mode-line-format
                        (count-lines (point-max) (point-min))))))

(when (equal window-system 'w32)
(setq default-directory "C:/Users/takeshi/"))

;;================================================  emacs環境の設定 終わり

;;パッケージ管理 package
(require 'package) ;; You might already have this line
;;(add-to-list 'package-archives
;;             '("melpa" . "https://melpa.org/packages/"))
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;;   )


;;(add-to-list 'package-archives
;;            '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
'("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(package-initialize) ;; You might already have this line


;;パッケージ毎の設定
;;; smooth-scroll
(require 'smooth-scroll)
(smooth-scroll-mode t)

(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/mySnippets" 
        ))

;; yas起動
(yas-global-mode 1)

(require 'diminish)
(require 'tern)
(require 'anzu)

(global-company-mode) ; 全バッファで有効にする 
(setq company-idle-delay 0.3) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る
(tern-mode t)
(company-tern t)
(setq company-tern-property-marker "")
(defun company-tern-depth (candidate)
  "Return depth attribute for CANDIDATE. 'nil' entries are treated as 0."
  (let ((depth (get-text-property 0 'depth candidate)))
    (if (eq depth nil) 0 depth)))
;;(add-hook 'js2-mode-hook 'tern-mode) ; 自分が使っているjs用メジャーモードに変える
(add-to-list 'company-backends 'company-tern) ; backendに追加

;(require 'js2-mode)
;(add-to-list 'auto-mode-alist '("\\.js\\" . js2-mode))

(global-anzu-mode +1)
(diminish 'anzu-mode "az")
(diminish 'company-mode "Cmp")
(diminish 'helm-mode "h")


;;migemo-----------------------------------------------------
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))
(when (equal window-system 'w32)
  (setq migemo-dictionary "C:\\cmigemo-default-win64\\dict\\utf-8\\migemo-dict"))
(when (equal window-system 'x)
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict"))
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)
;;--------------------------------------------------------------
;;auto-compile
;; (setq load-prefer-newer t)
;; (package-initialize)
;; (require 'auto-compile)
;; (auto-compile-on-save-mode)
;;--------------------------------------------------------------



;;move-text
(require 'move-text)
(move-text-default-bindings)
(global-set-key [down] 'move-text-down)
(global-set-key [up] 'move-text-up)

;;ace-jump-mode
(autoload
      'ace-jump-mode
      "ace-jump-mode"
      "Emacs quick move minor mode"
      t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;;Themeの設定
(load-theme 'monokai t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "38ba6a938d67a452aeb1dada9d7cdeca4d9f18114e9fc8ed2b972573138d4664" default)))
 '(minimap-always-recenter nil)
 '(minimap-window-location (quote right)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
