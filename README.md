vim-markdownfmt
===============

Markdown formatting plugin for Vim.  Designed to work with "gofmt-style"
commands such as [markdownfmt](https://github.com/shurcooL/markdownfmt).

<!-- and [mdfmt](https://github.com/moorereason/mdfmt). -->

Installation
------------

### Vundle

If you use [Vundle](https://github.com/gmarik/vundle), add the following to your `vimrc`:

```vim
Plugin 'moorereason/markdownfmt'
```

The install with:

```vim
:PluginInstall
```

### Pathogen

If you use [Pathogen](https://github.com/tpope/vim-pathogen), do this:

```sh
cd ~/.vim/bundle
git clone https://github.com/moorereason/vim-markdownfmt.git
```

## Options

### Command Executable

Define which "fmt" executable you want to use.  It must be in your PATH.
Default is `markdownfmt`.

```vim
let g:markdownfmt_command = 'markdownfmt'
```

### Command Options

Define options to be passed to command executable.  Default is `-w`.

```vim
let g:markdownfmt_options = '-w'
```

### Fail Silently

Set whether you want to fail silently (1) or show errors (0).
Default is 0 (show errors).

```vim
let g:markdownfmt_fail_silently=0
```

## Credits

* The Go Authors for their `gofmt` Vim plugin.
* [vim-go Contributors](https://github.com/fatih/vim-go/graphs/contributors) for inspiration.
* [Contributors](https://github.com/moorereason/vim-markdownfmt/graphs/contributors) of vim-markdownfmt.

## License

MIT License.  See file `LICENSE` for more details.
