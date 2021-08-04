let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'always',
        \ },
        \ 'https://instagram.com': {
            \ 'priority': 1,
            \ 'takeover': 'never',
        \ },
        \ 'https://twitter.com': {
            \ 'priority': 1,
            \ 'takeover': 'never',
        \ },
        \ 'https://www.twitch.tv': {
            \ 'priority': 1,
            \ 'takeover': 'never',
        \ },
    \ }
\ }
