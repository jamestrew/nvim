let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ 'https://leetcode\.com/.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 1,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
        \ '.*': {
            \ 'priority': 0,
            \ 'takeover': 'never',
        \ },
    \ }
\ }

function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    set guifont=JetBrains_Mono:h12
    nnoremap <leader>slc :set guifont=JetBrains_Mono:h14<CR>
  else
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

