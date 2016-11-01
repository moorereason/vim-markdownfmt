" Copyright 2015 Cameron Moore. All rights reserved.
"
" Copyright 2011 The Go Authors. All rights reserved.
" Use of this source code is governed by a BSD-style
" license that can be found in the LICENSE file.
"
" markdownfmt.vim: Vim command to format Markdown files with markdownfmt.
"
" This filetype plugin add a new command for markdown buffers:
"
"   :Fmt
"
"       Filter the current Markdown buffer through markdownfmt.
"       It tries to preserve cursor position and avoids
"       replacing the buffer with stderr output.

if !exists("g:markdownfmt_command")
    let g:markdownfmt_command = "markdownfmt"
endif

if !exists('g:markdownfmt_fail_silently')
    let g:markdownfmt_fail_silently = 0
endif

if !exists('g:markdownfmt_options')
    let g:markdownfmt_options = ''
endif

"  we have those problems :
"  http://stackoverflow.com/questions/12741977/prevent-vim-from-updating-its-undo-tree
"  http://stackoverflow.com/questions/18532692/golang-formatter-and-vim-how-to-destroy-history-record?rq=1
"
"  The below function is an improved version that aims to fix all problems.
"  it doesn't undo changes and break undo history.  If you are here reading
"  this and have VimL experience, please look at the function for
"  improvements, patches are welcome :)
function! markdownfmt#Format()
    " save cursor position and many other things
    let l:curw=winsaveview()

    " Write current unsaved buffer to a temp file
    let l:tmpname = tempname()
    call writefile(getline(1, '$'), l:tmpname)

    " get the command first so we can test it
    let fmt_command = g:markdownfmt_command

    if !executable(fmt_command)
        echohl Error | echomsg "markdownfmt: " . fmt_command . " executable not found." | echohl None
        return
    end
    " populate the final command with user based fmt options
    let command = fmt_command . ' -w ' . g:markdownfmt_options

    " execute our command...
    let out = system(command . " " . l:tmpname)

    "if there is no error on the temp file replace the output with the current
    "file (if this fails, we can always check the outputs first line with:
    "splitted =~ 'package \w\+')
    if v:shell_error == 0
        " remove undo point caused via BufWritePre
        try | silent undojoin | catch | endtry

        " Replace current file with temp file, then reload buffer
        let old_fileformat = &fileformat
        call rename(l:tmpname, expand('%'))
        silent edit!
        let &fileformat = old_fileformat
        let &syntax = &syntax

        " " clean up previous location list
        " call go#list#Clean()
        " call go#list#Window()
    elseif g:markdownfmt_fail_silently == 0
        " let splitted = split(out, '\n')
        " "otherwise get the errors and put them to location list
        " let errors = []
        " for line in splitted
        "     let tokens = matchlist(line, '^\(.\{-}\):\(\d\+\):\(\d\+\)\s*\(.*\)')
        "     if !empty(tokens)
        "         call add(errors, {"filename": @%,
        "                     \"lnum":     tokens[2],
        "                     \"col":      tokens[3],
        "                     \"text":     tokens[4]})
        "     endif
        " endfor
        " if empty(errors)
        "     % | " Couldn't detect markdownfmt error format, output errors
        " endif
        " if !empty(errors)
        "     call go#list#Populate(errors)
        "     echohl Error | echomsg "markdownfmt returned error" | echohl None
        " endif
        "
        " call go#list#Window(len(errors))

        " We didn't use the temp file, so clean up
        call delete(l:tmpname)
    endif

    " restore our cursor/windows positions
    call winrestview(l:curw)
    norm zv
endfunction

" vim:ts=4:sw=4:et
