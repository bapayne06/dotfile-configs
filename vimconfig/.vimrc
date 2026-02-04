" ---------- bpayne .vimrc file ----------



" ----------------------------- SETTINGS ----------------------------- {{{

filetype detect
filetype plugin indent on
set lazyredraw
set ttyfast
set noswapfile
set relativenumber
set wildmenu wildmode=longest:full,full
set tags=./tags;
set laststatus=2 showtabline=2
set nocompatible
set confirm
set undodir=~/.vim/backup
set undofile
set undoreload=10000
set shortmess-=I
set encoding=utf-8

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

hi! link SignColumn StatusLine
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
" }}}

" ----------------------------- SCRIPTS ----------------------------- {{{

" For use with status line
function! ReturnCurrentMode() abort
    if mode()=='n'
        return '%#modeNormal#' . ' NORMAL'
    elseif mode()=='i'
        return '%#modeInsert#' . ' INSERT'
    elseif mode()=='v'||'V'
        return '%#modeVisual#' . ' VISUAL'
    elseif mode()==''||'b'
        return '%#modeVisual#' . ' V-BLOCK'
    elseif mode()=='R'
        return '%#modeReplace#' . ' REPLACE'
    elseif mode()=='c'
        return '%#modeCommand#' . ' COMMAND'
    endif
endfunction

" Similar purpose as above
function! GitBranchName() abort
    let branch = trim(system("git rev-parse --abbrev-ref HEAD 2>/dev/null"))
    return branch
endfunction

" }}}

" ----------------------------- PLUGINS ----------------------------- {{{

" Vim-plug used for plugin management

" vim-polygot requires this setting *before* being loaded
let g:polyglot_disabled=['markdown']

if plug#begin('~/.vim/plugged')

    " -- General Plugins --
    Plug 'tpope/vim-commentary'
    Plug 'sheerun/vim-polyglot'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'mattn/emmet-vim'
    Plug 'tpope/vim-dispatch'
    Plug 'preservim/nerdtree'                  " Fie explorer within vim
    Plug 'cdelledonne/vim-cmake'
    Plug 'prabirshrestha/vim-lsp'              " Only works with lsp servers
    Plug 'prabirshrestha/vim-lsp-settings'     "Auto configures lsp server for related file
    Plug 'prabirshrestha/asyncomplete.vim'     " autocomplete for typing (only works with provider like lsp)
    Plug 'prabirshrestha/asyncomplete-lsp.vim' " Compatibility plugin for asyncomplete & vim-lsp
    Plug 'vim-fuzzbox/fuzzbox.vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'davidhalter/jedi-vim'
    Plug 'preservim/vim-indent-guides'

    Plug 'jaredgorski/spacecamp'
    Plug 'fmoralesc/molokayo'
    Plug 'lucasprag/simpleblack'

    call plug#end()
endif

" -- Built-in Vim plugins --
packadd! termdebug

" ----------------------------- PLUGIN SETTINGS ----------------------------- {{{

" ----------------------------- EMMET-VIM  ----------------------------- {{{

" Prevent emmet-vim being used for files other than html or css
let g:user_emmet_install_global=0

" Enable emmet-vim for all modes
let g:user_emmet_mode='a'

" Template for emmet-vim to use
let g:user_emmet_settings = {
\  'variables': {'lang': 'en'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\    },
\  },
\}

" Set html and css as the only filetypes for emmet-vim
augroup setEmmet
    autocmd!
    autocmd FileType html,css EmmetInstall
augroup END

" }}}

let g:EditorConfig_exclude_patterns=['fugitive://.*']

let g:OmniSharp_server_use_mono=1
let g:OmniSharp_highlighting=0

let g:cmake_statusline=1

" Disable default mappings for plugins
let g:fugitive_no_maps=1
let g:fuzzbox_mappings=0


let g:indent_guides_enable_on_vim_startup=1

" }}}

" ----------------------------- LSP CONFIG ----------------------------- {{{

" ----------------------------- CUSTOM LSPs ----------------------------- {{{
" clangd lsp (for C & C++)
if executable('clangd')
    augroup clanglsp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['cpp', 'c'],
        \ })
    augroup END
endif

" vimscript lsp
if executable('vim-language-server')
    augroup vimlsp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'vim-language-server',
        \ 'cmd': {server_info->['vim-language-server', '--stdio']},
        \ 'allowlist': ['vim'],
        \ })
    augroup END
endif

" Python lsp (Jedi)
if executable('jedi-language-server')
    augroup pylsp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'jedi-language-server',
        \ 'cmd': {server_info->['jedi-language-server']},
        \ 'allowlist': ['py'],
        \ })
    augroup END
endif

if executable('csharp-ls')
    augroup cslsp
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'csharp-ls',
        \ 'cmd': {server_info->['csharp-ls']},
        \ 'allowlist': ['cs'],
        \ })
    augroup END
endif

" }}}

" Configuration for vim lsp plugin, requires external lsp servers for their
" respective languages to function

let g:lsp_fold_enabled=0

" LSP Mappings
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    noremap <buffer> gd <plug>(lsp-definition)
    noremap <buffer> gs <plug>(lsp-document-symbol-search)
    noremap <buffer> gS <plug>(lsp-workspace-symbol-search)
    noremap <buffer> gr <plug>(lsp-references)
    noremap <buffer> gi <plug>(lsp-implementation)
    noremap <buffer> gt <plug>(lsp-type-definition)
    noremap <buffer> <leader>rn <plug>(lsp-rename)
    noremap <buffer> [g <plug>(lsp-previous-diagnostic)
    noremap <buffer> ]g <plug>(lsp-next-diagnostic)
    noremap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    augroup LSPSync
        autocmd!
        autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    augroup END

" refer to doc to add more commands
endfunction

augroup LSPInstall
    autocmd!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" }}}

" }}}

" ----------------------------- MAPPINGS ----------------------------- {{{

" Leader key for custom mapping
let g:mapleader="."

" ':mapclear' & ':source' in command line to reset all custom binds

" This section should always come after plugins and their settings 
" To ensure the original keybinds can be overwritten

" -- Mouse --

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

" -- General --

" Save current file
noremap <C-s> :w<CR>
" Run .vimrc file if detectable and :edit to refresh
nnoremap <leader>/ :w<CR>:source ~/.vimrc<CR>:edit<CR>
" edit commmand to refresh
nnoremap <leader>, :w<CR>:edit<CR>
" Toggle highlight search
nnoremap <leader>' :set hlsearch!<CR>:set hlsearch?<CR>
nnoremap re :set expandtab<BAR>retab!<CR>
nnoremap tt :tab split<CR>
nnoremap rr :tab close<CR>
" Global cut
noremap <C-x> "+x
" Global copy
noremap <C-c> "+y
" Global paste
noremap <C-v> "+gP
" Edit current file with superuser permissions
cnoremap :sed :w<CR>:!sudo tee %

" -- Plugin mappings --

nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
" asyncomplete tab completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" }}}

" ----------------------------- AFTER SETTINGS ----------------------------- {{{

" ----------------------------- STATUS LINE ----------------------------- {{{

" Clear status line
" (Backwards slashes followed by spaces are probably intentional for formatting)
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

" ----------------------------- OVERWRITABLES ----------------------------- {{{

" Settings that may otherwise be overwritten

" -------------------------- Display -------------------------- 

set noshowmode

" -- Cursor appearance --
set guicursor=n-v-c:block-screenCursor
set guicursor+=i:ver100-modeInsert
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" -- Text & Files --

set clipboard=unnamedplus
set textwidth=80
set linespace=2
set shiftround
set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set hlsearch
set display=lastline
set wrap
set incsearch
set ignorecase
set smartcase
set foldmethod=manual
set autoindent
set cursorline
set ruler
set debug="msg", "throw"
syntax on
set conceallevel=2
set list
set listchars-=eol

if has('gui_running')
    set guioptions-=r guioptions-=L
    set termguicolors
    set guifont=Hack\ Nerd\ Font\ Mono
    set background=dark
    set lines=42 columns=210
    silent! colorscheme molokayo
    set guiheadroom=45
else
    set t_Co=256
    set background=dark
    silent! colorscheme molokayo
endif

set showcmd

" }}}
" }}}
