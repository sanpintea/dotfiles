(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))

;;el-getの設定
(add-to-list 'load-path (locate-user-emacs-file "el-get/el-get"))
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))


;;; ロードパスの追加
 (setq load-path (append
                  '("~/.emacs.d/elpa"
                    "~/.emacs.d/el-get"
                    "~/.emacs.d/packages")
load-path))

;;;対応するカッコを強調表示
(show-paren-mode t)
;;;時刻表示
(display-time)
;;; Localeに合わせた環境の設定
(set-locale-environment nil)
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)
;; スタートアップメッセージを表示させない
(setq inhibit-startup-message t)
;; メニューバーを消す
(menu-bar-mode -1)
;; ツールバーを消す
;; (tool-bar-mode -1)

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

;;; 終了時にオートセーブファイルを消す
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
                   '(foreground-color . "black")  ; 文字色
                   '(background-color . "white")  ; 背景色
                   '(border-color     . "white")  ; ボーダー色
                   '(mouse-color      . "black")  ; マウスカーソルの色
                   '(cursor-color     . "black")  ; カーソルの色
                   '(cursor-type      . box)      ; カーソルの形状
                   '(top . 50) ; ウィンドウの表示位置（Y座標）
                   '(left . 200) ; ウィンドウの表示位置（X座標）
                   '(width . 80) ; ウィンドウの幅（文字数）
                   '(height . 40) ; ウィンドウの高さ（文字数）
                   )
                  default-frame-alist)))
(setq initial-frame-alist default-frame-alist )

;;パッケージ管理
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))


(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize) ;; You might already have this line

;;パッケージインストールリスト
(el-get-bundle helm)
(el-get-bundle ac-js2)
(el-get-bundle company)
(el-get-bundle popup)
;;(el-get-bundle auto-complete)
(el-get-bundle js2-mode)
(el-get-bundle company-tern)
(el-get-bundle anzu)
(el-get-bundle diminish)

;;パッケージ毎の設定
(require 'diminish)

(require 'anzu)
;; (require 'auto-complete)
;; (require 'auto-complete-config)    ; 必須ではないですが一応
;; (global-auto-complete-mode t)

(global-company-mode) ; 全バッファで有効にする 
(add-hook 'ruby-mode-hook 'company-mode)
(setq company-idle-delay 0.3) ; デフォルトは0.5
(setq company-minimum-prefix-length 2) ; デフォルトは4
(setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

(setq company-tern-property-marker "")
(defun company-tern-depth (candidate)
  "Return depth attribute for CANDIDATE. 'nil' entries are treated as 0."
  (let ((depth (get-text-property 0 'depth candidate)))
    (if (eq depth nil) 0 depth)))
;;(add-hook 'js2-mode-hook 'tern-mode) ; 自分が使っているjs用メジャーモードに変える
(add-to-list 'company-backends 'company-tern) ; backendに追加
(global-anzu-mode +1)

(diminish 'anzu-mode "Az")
(diminish 'company-mode "Comp")




