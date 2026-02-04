setlocal cindent autoindent expandtab shiftwidth=4 softtabstop=4 tabstop=4

setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c23\
            \ -pedantic-errors\ -o\ %<\ %

nnoremap <buffer> <F4> :w<CR>:make<CR>

nnoremap <buffer> <F5> :w<CR>:make<CR>:!./%<<CR>

nnoremap <buffer> <F6> :w<CR>:!./%<<CR>

