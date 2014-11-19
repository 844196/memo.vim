memo.vim
===

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

## License
Do What The F*ck You Want To Public Licens Version 2 (WTFPL-2.0)
