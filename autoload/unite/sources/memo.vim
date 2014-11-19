" 読み込み前の&cpo(設定値)を格納後、vimの初期値に戻す
let s:save_cpo = &cpo
set cpo&vim


let s:memo_source = {
            \ 'name' : 'memo',
            \ 'action_table' : {},
            \ 'default_action' : { 'common' : 'execute'}
            \ }
let s:memo_filter = { 'name' : 'memo_filter' }

function! s:memo_source.gather_candidates(args, context)
    let ret = []
    for val in memo#getlist()
        let candidates = {
                    \ "word" : val.title,
                    \ "source" : "memo",
                    \ "kind" : "file",
                    \ "action__path" : val.path,
                    \ "source__memo" : val
                    \ }
        call add (ret, candidates)
    endfor
    return ret
endfunction

function! s:memo_source.change_candidates(args, context)
    let title = a:context.input
    let sub = { ' ' : '-', '　' : '-', '\*' : ''}
    let i = 0
    while i < len(keys(sub))
        let title = substitute(title, keys(sub)[i], values(sub)[i], 'g')
        let i +=1
    endwhile
    let path = expand(memo#getpath() . strftime("%Y-%m-%d") . '_' . title . '.md', ':p')
    let filter = { "date" : strftime("%Y-%m-%d"), "title" : title, "path" : path }
    if title != '' && !filereadable(path)
        return [{
                    \ "abbr" : '[new page] ' . title,
                    \ "word" : title,
                    \ "action__path" : path,
                    \ "action__create" : a:context.input,
                    \ "source" : "memo",
                    \ "source__memo" : filter
                    \ }]
    else
        return []
    endif
endfunction

let s:memo_source.action_table.execute = { 'description' : 'create new memo' }
function! s:memo_source.action_table.execute.func(candidates)
    silent edit `=a:candidates.action__path`
    call append(0, [
                \ '# ' . a:candidates.action__create,
                \ 'date: ' . strftime("%Y-%m-%d"),
                \ '',
                \ ''
                \ ])
    execute '844196'
endfunction

function! s:memo_filter.filter(candidates, context)
    for candidates in a:candidates
        let memo = candidates.source__memo
        let candidates.word = printf("%-60S - %10S", memo.title, memo.date)
    endfor
    return a:candidates
endfunction

function! unite#sources#memo#define()
    return s:memo_source
endfunction
call unite#define_filter(s:memo_filter)
call unite#custom_source('memo', 'sorters', 'sorter_reverse')
call unite#custom_source('memo', 'converters', 'memo_filter')


" 読み込み前の&cpoの値を読み込み
let &cpo = s:save_cpo
" 作業用変数を削除
unlet s:save_cpo
