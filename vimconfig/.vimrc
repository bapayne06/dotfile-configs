" ---------- bpayne .vimrc file ----------

" Leader key for custom mapping
let g:mapleader="."

" ----------------------------- RUNTIMEPATH ----------------------------- {{{

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

" }}}

" ----------------------------- HIGHLIGHT GROUPS ----------------------------- {{{

hi modeNormal guifg=#000000 guibg=#e4e4e4 ctermfg=0 ctermbg=254
hi modeInsert guifg=#000000 guibg=#00d7ff ctermfg=0 ctermbg=45
hi modeVisual guifg=#000000 guibg=#b723e8 ctermfg=0 ctermbg=92
hi modeReplace guifg=#000000 guibg=#d6421d ctermfg=0 ctermbg=160
hi modeCommand guifg=#000000 guibg=#ffdf00 ctermfg=0 ctermbg=220
hi statusDefault guifg=#ffffff guibg=#4e4e4e ctermfg=15 ctermbg=239
hi statusFile guifg=#080808 guibg=#9393ff ctermfg=0 ctermbg=105
hi statusModified guifg=#eeeeee guibg=#00d700 ctermfg=15 ctermbg=40
hi statusFlag guifg=#080808 guibg=#ffff5f ctermfg=0 ctermbg=227
hi statusGit guifg=#ff0000 guibg=#ffff00 ctermfg=9 ctermbg=226
hi statusEncode guifg=#000000 guibg=#9e9e9e ctermfg=0 ctermbg=247
hi statusCursor guifg=#000000 guibg=#629fef ctermfg=0 ctermbg=33
hi screenCursor guifg=black guibg=white ctermfg=0 ctermbg=15
hi screenInsertCursor guifg=white guibg=#00ff00 ctermfg=15 ctermbg=46

" }}}

" ----------------------------- SETTINGS ----------------------------- {{{

" -------------------------- Vim --------------------------

filetype detect
filetype plugin indent on

set lazyredraw

set ttyfast

set noswapfile

set relativenumber

set wildmenu wildmode=longest:full,full

set tags=./tags,tags;

set laststatus=2 showtabline=2

set nocompatible

set confirm

set undodir=~/.vim/backup
set undofile
set undoreload=10000

set shortmess-=I

" -------------------------- Files & Text --------------------------

set paste

set clipboard=unnamedplus

set textwidth=85

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

set noautoindent

set cursorline

set ruler

set encoding=utf-8

set debug="msg", "throw"

set nohlsearch

set foldmethod=indent

syntax on

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

silent! plug#begin('~/.vim/plugged')

" -- General Plugins --
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'Vimjas/vint'
Plug 'OmniSharp/omnisharp-vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'cdelledonne/vim-cmake'
" -- Colorscheme Plugins --
Plug 'jaredgorski/spacecamp'
Plug 'fmoralesc/molokayo'
Plug 'lucasprag/simpleblack'

call plug#end()

packadd! termdebug

" -------------------- Plugin Settings --------------------

let g:user_emmet_install_global=0

let g:fzf_history_dir='/home/bpayne/.local/share/fzf-history'

let g:ycm_enable_semantic_highlighting=0
let g:ycm_clear_inlay_hints_in_insert_mode=1

" Needed for editor config to work properly
let g:EditorConfig_exclude_patterns=['fugitive://.*']

" Prevents bufferline plugin from echoing to command line
let g:bufferline_echo=0
let g:bufferline_show_bufnr=0

" Turn off git plugin global mappings
let g:fugitive_no_maps=1

let g:OmniSharp_server_use_mono=1
let g:OmniSharp_selector_findusages='fzf'
let g:OmniSharp_highlighting=0

let g:ale_linters={
			\ 'cs': ['OmniSharp'],
			\ 'vim': ['vint'],
			\ }

let g:vimspector_enable_mappings = 'HUMAN'

" }}}

" ----------------------------- MAPPINGS ----------------------------- {{{

" ':mapclear' & ':source' in command line to reset all custom binds

" ---------------- Mouse -----------------

if has('mouse')
" Mouse available in all modes
	set mouse=a

	" Regular scrolling
	noremap <ScrollWheelDown> 2<C-e>
	noremap <ScrollWheelUp> 2<C-y>

" Shift held while scrolling = Half-page scroll
	noremap <S-ScrollWheelDown> <C-f>
	noremap <S-ScrollWheelUp> <C-b>

" Ctrl held while scrolling = One page scroll
	noremap <C-ScrollWheelDown> <C-d>
	noremap <C-ScrollWheelUp> <C-u>

endif

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

" Global cut
vnoremap <C-x> "+x
" Global copy
vnoremap <C-c> "+y
" Global paste
vnoremap <C-v> "+gP

" Edit current file with superuser permissions
cnoremap :sed :w<CR>:!sudo tee %

" ----------------- Plugin mappings -----------------

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

inoremap <C-l> <Plug>(YCMToggleSignatureHelp)

" }}}

" ----------------------------- STATUS LINE ----------------------------- {{{

" Clear status line
set statusline=
set statusline+=%{%ReturnCurrentMode()%}\ 
set statusline+=%#statusDefault#%(%#statusGit#[%{%GitBranchName()%}]%#statusDefault#%)
" File path
set statusline+=%(%#statusFile#\ %F%m\ %)
" File type
set statusline+=%(\|\ %Y\ %)
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

" Settings that may otherwise be overwritten

" -------------------------- Display -------------------------- 

set noshowmode

set fillchars=stlnc:-,vert:\|,fold:-,diff:-

set guicursor=n-v-c:block-screenCursor
set guicursor+=i:ver100-modeInsert
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

if has('gui_running')
	set guioptions-=r guioptions-=L
	set termguicolors
	set guifont=Hack\ Nerd\ Font\ Mono
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
