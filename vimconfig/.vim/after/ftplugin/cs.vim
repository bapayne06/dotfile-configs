" .cs settings

setlocal makeprg=dotnet\ build\
		\ property:GenerateFullPaths=true\
		\ verbosity:quiet\
		\ errorformat=%f(%l\,%c):\ %t%n\ %m\
