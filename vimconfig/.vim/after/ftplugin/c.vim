setlocal shiftwidth=4 tabstop=4  cindent autoindent

setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c23\ -o\ %<\ %

nnoremap <buffer> <F4> :w<CR>:make<CR>

nnoremap <buffer> <F5> :w<CR>:make<CR>:!./%<<CR>

nnoremap <buffer> <F6> :w<CR>:!./%<<CR>

