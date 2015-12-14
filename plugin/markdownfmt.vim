" Autocommands

augroup markdownfmt
    autocmd!

    " code formatting on save
    if get(g:, "markdownfmt_autosave", 0)
        autocmd BufWritePre *.{md,mdown,mkd,mkdn,markdown,mdwn} call markdownfmt#Format()
    endif
augroup END
