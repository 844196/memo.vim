" 読み込み前の&cpo(設定値)を格納後、vimの初期値に戻す
let s:save_cpo = &cpo
set cpo&vim


function! memo#getpath()
    if g:memopath !~ '\/$'
        return expand(g:memopath . '/')
    else
        return expand(g:memopath)
    endif
endfunction

function! memo#getlist()
    let list = split(glob(memo#getpath() . '*.md'), '\n')
    return map(list, '{
                \ "date" : fnamemodify(v:val, ":t:r")[0:9],
                \ "title" : substitute(fnamemodify(v:val, ":t:r"), "^....-..-.._", "", ""),
                \ "path" : v:val
                \ }')
endfunction


" 読み込み前の&cpoの値を読み込み
let &cpo = s:save_cpo
" 作業用変数を削除
unlet s:save_cpo
