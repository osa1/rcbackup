" Code adapted from
" https://github.com/vim-airline/vim-airline/blob/master/autoload/airline/extensions/example.vim

let s:spc = g:airline_symbols.space

if !exists('g:airline#extensions#breadcrumbs')
    let g:airline#extensions#breadcrumbs = 42
endif

function! airline#extensions#breadcrumbs#init(ext)
    call airline#parts#define_raw('breadcrumbs', '%{airline#extensions#breadcrumbs#get()}')
    call a:ext.add_statusline_func('airline#extensions#breadcrumbs#apply')

    " A funcref for inactive statuslines (TODO: not sure what this is about)
    " call a:ext.add_inactive_statusline_func('airline#extensions#example#unapply')
endfunction

function! airline#extensions#breadcrumbs#apply(...)
    if &filetype == "rust"
        let w:airline_section_c = get(w:, 'airline_section_c', g:airline_section_c)
        let w:airline_section_c .= s:spc.g:airline_left_alt_sep.s:spc.'%{airline#extensions#breadcrumbs#get()}'
    endif
endfunction

function! airline#extensions#breadcrumbs#get()
    return luaeval("breadcrumbs()")
endfunction
