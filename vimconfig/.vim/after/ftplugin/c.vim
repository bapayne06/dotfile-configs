setlocal foldmethod=indent
setlocal makeprg=gcc\ -Wall\ -Wextra\ -std=c23\ -o\ %<\ %
setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab cindent

nnoremap <buffer> <F4> :w<CR>:make<CR>

nnoremap <buffer> <F5> :w<CR>:make<CR>:!./%<<CR>

nnoremap <buffer> <F6> :w<CR>:!./%<<CR>

