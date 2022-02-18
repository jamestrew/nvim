function! s:Capture(bang, cmd)
  let message = execute(a:cmd)

  if a:bang
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
  endif

  call append('.', split(message, '\r\?\n'))
  redraw!
endfunction

command! -bang -nargs=+ -complete=command Capture call <SID>Capture("<bang>" == '!', <q-args>)
