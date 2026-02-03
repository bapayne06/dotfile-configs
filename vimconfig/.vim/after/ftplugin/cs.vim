setlocal shiftwidth=4 softtabstop=4 tabstop=4 expandtab cindent

setlocal makeprg=dotnet\ build\
		\ property:GenerateFullPaths=true\
		\ verbosity:quiet\
		\ errorformat=%f(%l\,%c):\ %t%n\ %m\
