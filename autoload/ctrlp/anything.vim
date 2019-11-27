if (exists('g:loaded_ctrlp_anything') && g:loaded_ctrlp_anything)
      \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_anything = 1

"
" configuration options

call add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#anything#init()',
      \ 'accept': 'ctrlp#anything#accept',
      \ 'lname': 'anything',
      \ 'sname': 'anything',
      \ 'type': 'line',
      \ 'enter': 'ctrlp#anything#enter()',
      \ 'exit': 'ctrlp#anything#exit()',
      \ 'opts': 'ctrlp#anything#opts()',
      \ 'sort': 0,
      \ 'specinput': 0,
      \ })

function! ctrlp#anything#exec(mode)
  let s:anything_opt_for_sensitivity = "-s"
  let s:word = a:mode
  call ctrlp#init(ctrlp#anything#id())
endfunction

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#anything#init()
  " dim the content part to make it look more tidy
  " eg.
  " app/data/mgmt.rb:31:     def abc
  if !ctrlp#nosy()
    cal ctrlp#hicheck('CtrlPTabExtra', 'Comment')
    syntax match CtrlPTabExtra `:.*$`
  en
  return split(system(s:word), "\n")
endfunction

" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#anything#accept(mode, str)
  call ctrlp#exit()
  call s:open_file(a:mode, a:str)
endfunction

" (optional) Do something before enterting ctrlp
function! ctrlp#anything#enter()
endfunction

" (optional) Do something after exiting ctrlp
function! ctrlp#anything#exit()
endfunction

" (optional) Set or check for user options specific to this extension
function! ctrlp#anything#opts()
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#anything#id()
  return s:id
endfunction

function! s:open_file(mode, str)
  if match(a:str, ':') != -1
    " let [path, line] = split(a:str, ':')
    let [path, line, column; rest] = split(a:str, ':')
    call ctrlp#acceptfile(a:mode, path)
    call cursor(line, column)
  else
    call ctrlp#acceptfile(a:mode, a:str)
  endif
endfunction
