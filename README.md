# memo.vim
[![](http://img.shields.io/github/tag/844196/memo.vim.svg?style=flat)](https://github.com/844196/memo.vim/releases)
[![](http://img.shields.io/github/issues/844196/memo.vim.svg?style=flat)](https://github.com/844196/memo.vim/issues)
[![](http://img.shields.io/badge/license-WTFPL%202.0-red.svg?style=flat)](LICENSE)

![](http://38.media.tumblr.com/3ef24bb9094deb07fd2b6e796365ba69/tumblr_nfjhjf0enF1s7qf9xo1_1280.gif)

## Usage
### Installation
```vim
" add .vimrc
NeoBundle '844196/memo.vim', {
    \ 'depends' : 'Shougo/unite.vim'
    \ }
```

### Basic usage

```vim
" set g:memopath
let g:memopath = '~/yukimura/aoichan/kawaii/'
```

- `:Unite memo` create new memo & view memo list

### Additional usages
```vim
" create new memo & view memo list
nnoremap <silent> <F2> :<C-u>Unite memo
    \ -buffer-name=memo_list -winheight=10 -max-multi-lines=1
    \ <CR>

" grep memo
nnoremap <silent> <C-n> :<C-u>execute(
    \ 'Unite grep:' . memo#getpath() . ' -no-empty -winheight=10'
    \ )<CR>
```
