" ---------- bpayne .vimrc file ----------

" Leader key for custom mapping
let g:mapleader="."

" ----------------------------- SETTINGS ----------------------------- {{{

" Configure initial vim behaviour

" -------------------------- Vim --------------------------

filetype detect
filetype plugin on
filetype indent on

set runtimepath+=~/.vim/autoload
set runtimepath+=~/.vim/compiler
set runtimepath+=~/.vim/indent
set runtimepath+=~/.vim/plugin
set runtimepath+=~/.vim/spell
set runtimepath+=~/.vim/syntax
set runtimepath+=~/.vim/templates
set runtimepath+=~/.vim/ftplugin
set runtimepath+=~/.vim/after
set runtimepath+=~/.vim/ftdetect
set runtimepath+=~/.vim/after/ftplugin

set guioptions-=r guioptions-=L

set lazyredraw

set ttyfast

set noswapfile

set autochdir

set number

set wildmenu wildmode=longest:full,full

set tags=./tags,tags;

set laststatus=2 showtabline=2

set nocompatible

set confirm

if version >= 703
	set undodir=~/.vim/backup
	set undofile
	set undoreload=10000
endif

if has('mouse')
	" Mouse available in all modes
	set mouse=a
	
	" Regular scrolling
	noremap <ScrollWheelDown> 2<C-E>
	noremap <ScrollWheelUp> 2<C-Y>

	" Shift held while scrolling = Half-page scroll
	noremap <S-ScrollWheelDown> <C-F>
	noremap <S-ScrollWheelUp> <C-B>
	
	" Ctrl held while scrolling = One page scroll
	noremap <C-ScrollWheelDown> <C-D>
	noremap <C-ScrollWheelUp> <C-U>
	
	" Scrolling with insert mode = Escape insert mode
	inoremap <ScrollWheelDown> <esc>
	inoremap <ScrollWheelUp> <esc>
endif

" -------------------------- Files & Text --------------------------

set linespace=2

set list

set shiftround

set smarttab noexpandtab

set tabstop=4 softtabstop=4 shiftwidth=4

set hlsearch

set display=lastline

set wrap

set incsearch

set ignorecase

set smartcase

set autoindent

set cursorline

set ruler

set encoding=utf-8

set debug="msg","throw"

set nohlsearch

set foldmethod=indent

syntax on

" }}}

" ----------------------------- HIGHLIGHT GROUPS ----------------------------- {{{

hi modeNormal guibg=#7e7e7e ctermbg=243
hi modeInsert guibg=#008700 ctermbg=028
hi modeVisual guibg=#862ef1 ctermbg=093
hi modeReplace guibg=#d6421d ctermbg=160
hi modeCommand guibg=#2178f7 ctermbg=033

hi statusDefault guifg=#ffffff guibg=#4e4e4e ctermfg=15 ctermbg=239

hi statusFile guifg=#080808 guibg=#d0d0d0 ctermfg=0 ctermbg=252

hi statusModified guifg=#eeeeee guibg=#00d700 ctermfg=15 ctermbg=40

hi statusFlag guifg=#080808 guibg=#ffff5f ctermfg=0 ctermbg=227

hi statusGit guifg=#ff0000 guibg=#ffff00 ctermfg=9 ctermbg=226

hi statusEncode guifg=#000000 guibg=#9e9e9e ctermfg=0 ctermbg=247

hi statusCursor guifg=#000000 guibg=#ffffff ctermfg=0 ctermbg=15

hi statusPercent guifg=#000000 guibg=#00afff ctermfg=0 ctermbg=39

" }}}

" ----------------------------- SCRIPTS ----------------------------- {{{

function! ReturnCurrentMode() abort
	let l:CurrentMode=mode()
	if CurrentMode=='n'
		return '%#modeNormal#' . ' NORMAL'
	elseif CurrentMode=='i'
		return '%#modeInsert#' . ' INSERT'
	elseif CurrentMode=='v'||'V'
		return '%#modeVisual#' . ' VISUAL'
	elseif CurrentMode==''||'b'
		return '%#modeVisual#' . ' V-BLOCK'
	elseif CurrentMode=='R'
		return '%#modeReplace#' . ' REPLACE'
	elseif CurrentMode=='c'
		return '%#modeCommand#' . ' COMMAND'
	endif
endfunction

function! GitBranchName() abort
	let branch = trim(system("git rev-parse --abbrev-ref HEAD 2>/dev/null"))
	return branch
endfunction

" }}}

" ----------------------------- PLUGINS ----------------------------- {{{

" Vim Plugins handled through Vim-Plug

" -------------------------------------------------------------

" vim-polygot requires this setting *before* being loaded
let g:polyglot_disabled=['markdown']

call plug#begin('~/.vim/plugged')

" -- General Plugins --
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'Yggdroot/indentLine'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'LunarWatcher/auto-pairs', {'tag': '*'}
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'Vimjas/vint'
Plug 'OmniSharp/omnisharp-vim'
" -- Colorscheme Plugins --
Plug 'jaredgorski/spacecamp'
Plug 'zautumnz/angr.vim'
Plug 'fmoralesc/molokayo'
Plug 'lucasprag/simpleblack'
Plug 'altercation/vim-colors-solarized'

call plug#end()

" -------------------- More Plugin Settings --------------------

" Sets characters to be used by indentLine plugin
let g:indentLine_char_list=['|','¦','┆','┊'] " "

let g:user_emmet_install_=0

let g:fzf_history_dir='/home/bpayne/.local/share/fzf-history' 

" Syntax highlighting on-off setting from YCM plugin
let g:ycm_enable_semantic_highlighting=0

let g:AutoPairsMapSpace=0

" Needed for editor config to work properly
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" Prevents bufferline plugin from echoing to command line
let g:bufferline_echo=0
let g:bufferline_show_bufnr =0

" Turn off git plugin global mappings
let g:fugitive_no_maps=1

" }}} 

" ----------------------------- MAPPINGS ----------------------------- {{{

" ':mapclear' & ':source' in command line to reset all custom binds

" ---------------- General -----------------

" Save current file
noremap <C-s> :w<CR>

" Run .vimrc file if detectable and :edit to refresh
nnoremap <leader>/ :w<CR>:source ~/.vimrc<CR>:edit<CR>

" edit commmand to refresh
nnoremap <leader>, :w<CR>:edit<CR>

" Toggle highlight search
nnoremap <leader>' :set hlsearch!<CR>:set hlsearch?<CR>

" Retab
nnoremap re :set noexpandtab<BAR>retab!<CR>

"Split tab
nnoremap tt :tab split<CR>
" Close tab
nnoremap rr :tab close<CR>

" Cut
vnoremap <C-x> "+x
" copy
vnoremap <C-c> "+y
" Paste
vnoremap <C-v> "+gP

" Edit current file with superuser permissions
cnoremap :sed :w<CR>:!sudo tee %

" ----------------- Plugin mappings -----------------

" Vim-Plug shortform
cnoremap :PlugIn :PlugInstall<CR>

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

imap <C-l> <Plug>(YCMToggleSignatureHelp)

" }}}

" ----------------------------- STATUS LINE ----------------------------- {{{

" Clear status line
set statusline=
set statusline+=%{%ReturnCurrentMode()%}\ 
set statusline+=%#statusDefault#%(%#statusGit#[%{%GitBranchName()%}]%#statusDefault#%)
" File path
set statusline+=%(%#statusFile#\ %F%m\ %)
" File type
set statusline+=%(%Y\ %)
" File flags
set statusline+=%#statusDefault#%(%#statusFlag#\ %R\ %H\ %W\ %#statusDefault#%)

" Right-align all components after this
set statusline+=%=

set statusline+=%#statusDefault#%(%#statusEncode#\ %{&fileencoding?&fileencoding:&encoding}\ %)
" Column position of cursor
set statusline+=%#statusCursor#\ \Col:\ %c%V\,
" Current line in file
set statusline+=\ %l
" Amount of lines in buffer
set statusline+=\/%L\ \|
" Lines passed in file as percentage
set statusline+=\ %p%%\ 

" }}}

" ----------------------------- AFTER ----------------------------- {{{

" Any settings that may otherwise be overwritten

" -------------------------- Display -------------------------- 

set noshowmode

set fillchars=stlnc:-,vert:\|,fold:-,diff:-

if has('gui_running')
	set termguicolors
	set background=dark
	set lines=40 columns=170
	silent! colorscheme molokayo
	set guiheadroom=45
else
	set t_Co=256
	set background=dark
	silent! colorscheme molokayo
endif

set showcmd

" }}}
