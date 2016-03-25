set number
set cursorline
set laststatus=2
set showmatch
"set list
"set listchars=tab:\ ,eol:,extends:,precedes:
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,]
set confirm
set hidden
set nobackup
set noswapfile
set tabstop=4
"set encoding=utf-8
"set termencoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
"set guifont=Ricty_Diminished:h12
"set guifontwide=Ricty_Diminished:h12
set iminsert=0
set imsearch=-1
set lines=50

" neobundle settings {{{
if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

" neobundle#begin - neobundle#end の間に導入するプラグインを記載します。
NeoBundleFetch 'Shougo/neobundle.vim'
" ↓こんな感じが基本の書き方
NeoBundle 'bundle/tern_for_vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'othree/html5.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }
NeoBundle 'Shougo/neocomplete.vim'
if has('lua')
	  NeoBundleLazy 'Shougo/neocomplete.vim', {
	      \ 'depends' : 'Shougo/vimproc',
	      \ 'autoload' : { 'insert' : 1,}
	      \ }
  endif

  " neocomplete {{{
  " let g:neocomplete#enable_at_startup               = 1
  " let g:neocomplete#auto_completion_start_length    = 3
  " let g:neocomplete#enable_ignore_case              = 1
  " let g:neocomplete#enable_smart_case               = 1
  " let g:neocomplete#enable_camel_case               = 1
  " let g:neocomplete#use_vimproc                     = 1
  " let g:neocomplete#sources#buffer#cache_limit_size = 1000000
  " let g:neocomplete#sources#tags#cache_limit_size   = 30000000
  " let g:neocomplete#enable_fuzzy_completion         = 1
  " let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
  " " }}}
NeoBundle 'Shougo/vimproc'
NeoBundle 'tomtom/tcomment_vim'
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}

" vimshell {{{
" nmap <silent> vs :<C-u>VimShell<CR>
" nmap <silent> vp :<C-u>VimShellPop<CR>
" " }}}
  " vimrc に記述されたプラグインでインストールされていないものがないかチェックする
NeoBundle 'Townk/vim-autoclose'
  NeoBundleCheck
call neobundle#end()
filetype plugin indent on
" どうせだから jellybeans カラースキーマを使ってみましょう
set t_Co=256
syntax on
colorscheme jellybeans
filetype plugin on

" lightlineの設定  これステータスバーを綺麗にする
let g:lightline = {
        \ 'colorscheme': 'jellybeans',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'LightLineModified',
        \   'readonly': 'LightLineReadonly',
        \   'fugitive': 'LightLineFugitive',
        \   'filename': 'LightLineFilename',
        \   'fileformat': 'LightLineFileformat',
        \   'filetype': 'LightLineFiletype',
        \   'fileencoding': 'LightLineFileencoding',
        \   'mode': 'LightLineMode'
        \ }
        \ }

function! LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"lightline end

call plug#begin('~/.vim/plugged')
Plug 'lambdalisue/vim-gita'
call plug#end()

