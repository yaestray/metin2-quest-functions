BREAK > indexed_articles.txt
SETLOCAL EnableDelayedExpansion
FOR /L %%n IN (1 1 500) DO IF "!__cd__:~%%n,1!" neq "" SET /a "len=%%n+1"
SETLOCAL DisableDelayedExpansion
FOR /r . %%g IN (*.md) DO (
	SET "absPath=%%g"
	SETLOCAL EnableDelayedExpansion
	SET "relPath=!absPath:~%len%!"
	SET "relPath=!relPath:\=/!"
	SET "relPath=!relPath:indexed_articles/=!"
	SET "relPath=!relPath:.md=!"
	echo(!relPath!>>indexed_articles.txt
	ENDLOCAL
)
