" ===============================
" Vim設定ファイル（社内共有用）
" ===============================
" AI開発に適したVim設定

" ===============================
" 基本設定
" ===============================
" 文字コード
set encoding=utf-8
set fileencoding=utf-8

" マウス操作無効化（ターミナルでのコピペを楽にする）
set mouse=

" 行番号表示
set number
set relativenumber

" シンタックスハイライト
syntax on

" インデント設定
set autoindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" 検索設定
set hlsearch
set incsearch
set ignorecase
set smartcase

" ===============================
" 表示設定
" ===============================
" カラースキーム
colorscheme default
set background=dark

" カーソル行をハイライト
set cursorline

" 対応する括弧をハイライト
set showmatch

" ステータスライン
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" ===============================
" ファイル処理
" ===============================
" バックアップファイルを作らない
set nobackup
set noswapfile

" 自動保存
set autowrite

" ===============================
" キーマッピング
" ===============================
" Leader キーをスペースに
let mapleader = " "

" 保存・終了
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wq :wq<CR>

" 検索ハイライトを消す
nnoremap <Leader>h :noh<CR>

" ===============================
" AI開発用設定
" ===============================
" ファイルタイプ別設定
autocmd FileType python setlocal tabstop=4 shiftwidth=4
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2
autocmd FileType markdown setlocal wrap linebreak

" ===============================
" 便利機能
" ===============================
" クリップボード連携（macOS）
if has('mac')
  set clipboard=unnamed
endif

" 分割ウィンドウの移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l