let s:save_cpo = &cpo
set cpo&vim


function! memo#getpath()
    let l:path = g:memo_path
    if l:path !~ '\/$'
        return expand(l:path . '/')
    else
        return expand(l:path)
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


let &cpo = s:save_cpo
unlet s:save_cpo
