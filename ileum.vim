function Do_Close ()
    call chanclose(g:channel)
    qall!
endfunction

function On_Stdin (chan, content, name)
  if len(a:content) == 1 && a:content[0] == ''
    call Do_Close()
  endif
  let r = rpcrequest(g:channel, 'nvim_call_function', 'nvim_buf_set_lines', [0, -1, -1, v:false, a:content])
endfunction

function! Ileum (pwd, addr, cmd) abort
  let g:channel = sockconnect('pipe', a:addr, { 'rpc': v:true })
  let r = rpcrequest(g:channel, 'nvim_command', 'lcd ' .. a:pwd)
  let r = rpcrequest(g:channel, 'nvim_command', a:cmd)

  if !has('ttyin')
    call stdioopen({'on_stdin': funcref('On_Stdin'), 'stdin_buffered': v:false, 'rpc': v:false})
  else
    call Do_Close()
  endif
endfunction
