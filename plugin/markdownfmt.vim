" Autocommands

augroup markdownfmt
    autocmd!

    " code formatting on save
    if get(g:, "markdownfmt_autosave", 1)
        autocmd BufWritePre *.md *.markdown call markdownfmt#Format()
    endif
augroup END
