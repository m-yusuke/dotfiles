if &compatible
 set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.vim/bundles')
 call dein#begin('~/.vim/bundles')

 call dein#add('~/.vim/bundles')
 call dein#add('cohama/lexima.vim')
 call dein#add('bling/vim-airline')
 call dein#add('shougo/neocomplete.vim')
 call dein#add('shougo/neosnippet.vim')
 call dein#add('shougo/neosnippet-snippets')
 call dein#add('vim-airline/vim-airline-themes')
 call dein#add('osyo-manga/vim-anzu')
 call dein#add('scrooloose/nerdtree')
 call dein#add('morhetz/gruvbox')
 call dein#add('airblade/vim-gitgutter')
 call dein#add('Yggdroot/indentLine')
 call dein#add('ctrlpvim/ctrlp.vim')
 call dein#add('tacahiroy/ctrlp-funky')
 call dein#add('suy/vim-ctrlp-commandline')
 call dein#add('tpope/vim-fugitive')
 call dein#add('tomtom/tcomment_vim')
 if !has('nvim')
   call dein#add('roxma/nvim-yarp')
   call dein#add('roxma/vim-hug-neovim-rpc')
 endif

 call dein#end()
 call dein#save_state()
endif

filetype plugin indent on
syntax enable

syntax on
set number

" CtrlPの設定
let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
let g:ctrlp_extensions = ['funky', 'commandline'] " CtrlPの拡張として「funky」と「commandline」を使用

" CtrlPCommandLineの有効化
command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())

" CtrlPFunkyの有効化
let g:ctrlp_funky_matchtype = 'path' 

" OSのclipboardにyank
set clipboard=unnamed,autoselect

" vim-airlineにブランチ情報を表示する
let g:airline#extensions#branch#enabled = 1

" insert mode
imap <C-p> <Up>
imap <C-n> <Down>
imap <C-b> <Left>
imap <C-f> <Right>
imap <C-a> <C-o>:call <SID>home()<CR>
imap <C-e> <End>
imap <C-d> <Del>
imap <C-h> <BS>
inoremap <C-k> <C-o>D

function! s:home()
  let start_column = col('.')
  normal! ^
  if col('.') == start_column
  ¦ normal! 0
  endif
  return ''
endfunction

function! s:kill()
  let [text_before, text_after] = s:split_line()
  if len(text_after) == 0
  ¦ normal! J
  else
  ¦ call setline(line('.'), text_before)
  endif
  return ''
endfunction

function! s:split_line()
  let line_text = getline(line('.'))
  let text_after  = line_text[col('.')-1 :]
  let text_before = (col('.') > 1) ? line_text[: col('.')-2] : ''
  return [text_before, text_after]
endfunction

" テーマ
let g:airline_theme='deus'
" カラースキーム
colorscheme gruvbox
set background=dark
" gruvboxの設定
let g:gruvbox_italic=1
" タブを表示

set laststatus=2
set showtabline=2 " 常にタブラインを表示
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" Powerline系フォントの使用
let g:airline_powerline_fonts = 1
set t_Co=256
" Double
set ambiwidth=double
" mouse on
set mouse=a

" terminal-mode nomalstatus
tnoremap <C-Q> <C-W>N

" indentLineの設定
set list listchars=tab:\|\ 
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '¦'

" 検索系
" 検索結果をハイライト表示
set hlsearch
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" <ESC>二回ででハイライトをOFFにする
nmap <ESC><ESC> :noh<CR>

" <C-t>でツリーの表示・非表示
map <C-t> :NERDTreeToggle<CR>
" ツリーに不可視ファイルを表示
let NERDTreeShowHidden = 1

" anzu-vim setting
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
" statusline
set statusline=%{anzu#search_status()}

" 見た目
set cursorline
set smartindent
set showmatch
set wildmenu
set wildmode=list:longest:full,full

" Tabの設定
"Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=4
" 行頭でのTab文字の表示幅
set shiftwidth=4

" 行番号の色
highlight LineNr ctermfg=blue
" 消すときにBSキーを有効に
set backspace=indent,eol,start

set nocp
filetype plugin on

" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1

" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 2文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 2
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

call lexima#init()
" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-y>" : lexima#expand('<CR>','i')
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
