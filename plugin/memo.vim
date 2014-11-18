" g:loaded_logが読み込めたら、以降のコードを読み込まない
if exists("g:loaded_memo")
  finish
endif
" g:loaded_logを宣言
let g:loaded_memo = 1

" 読み込み前の&cpo(設定値)を格納後、vimの初期値に戻す
let s:save_cpo = &cpo
set cpo&vim


" （ない場合）空のg:memopathを宣言
if !exists('g:memopath')
    let g:memopath = ''
endif

" パス取得
function! s:memopath()
    if g:memopath !~ '\/$'
        return expand(g:memopath . '/')
    else
        return expand(g:memopath)
    endif
endfunction

" メモ作成
function! s:memonew()
    " g:memopathが定義されていなければエラーメッセージを出力して終了
    if empty(g:memopath)
        redraw | echohl ErrorMsg | echo 'g:memopathが定義されていません' | echohl None

    " g:memopathがディレクトリじゃなかったらエラーメッセージを出力して終了
    elseif !isdirectory(s:memopath())
        redraw | echohl ErrorMsg | echo g:memopath . 'はディレクトリはでないか、または存在しません' | echohl None

    else
        " タイトル取得
        let s:title = input('Title: ')
        " ファイルネーム生成
        let s:filename = s:memopath() . strftime('%Y-%m-%d_') . s:title . '.md'

        " タイトルが空ならエラーメッセージを出力して終了
        if empty(s:title)
            redraw | echohl ErrorMsg | echo 'ファイル名がありません' | echohl None

        " 同名ファイルがすでに存在するならエラーメッセージを出力して終了
        elseif filereadable(expand(s:filename))
            redraw | echohl ErrorMsg | echo '同名のファイルが存在します' | echohl None

        " 問題ない場合テンプレートをバッファに書き込み保存
        else
            " テンプレート
            let s:template = [
                        \'# ' . s:title,
                        \'date : ' . strftime("%Y-%m-%d"),
                        \'',
                        \'',
                        \]

            " 保存
            execute 'new ' . s:filename
            call setline(1, s:template)
            execute '999'
            execute 'write'
        endif
    endif
endfunction

command! -nargs=0 MemoNew call s:memonew()
nnoremap <silent> <Plug>(memo_new) :<C-u>MemoNew<CR>


" 読み込み前の&cpoの値を読み込み
let &cpo = s:save_cpo
" 作業用変数を削除
unlet s:save_cpo
