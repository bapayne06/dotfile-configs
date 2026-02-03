setlocal cindent autoindent

setlocal makeprg=g++\ -Wall\ -Wextra\ -Weffc++\
			\ -Wsign-conversion\ -Wconversion\ -ggdb\
			\ -pedantic-errors\ -std=c++23\ -o\ %<\ %

nnoremap <buffer> <F4> :w<CR>:make<CR>

nnoremap <buffer> <F5> :w<CR>:make<CR>:!./%<<CR>

nnoremap <buffer> <F6> :w<CR>:!./%<<CR>
