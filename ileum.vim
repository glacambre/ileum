let g:last_line = ""
let g:exit_code = 0

function Do_Close ()
    call chanclose(g:channel)
    execute("cq! " .. g:exit_code)
endfunction

function On_Stdin (chan, content, name)
  let l:len = len(a:content)
  if l:len == 1 && a:content[0] == ''
    call Do_Close()
  endif
  try
    let a:content[0] = g:last_line .. a:content[0]
    let r = rpcrequest(g:channel, 'nvim_call_function', 'nvim_buf_set_lines', [0, -2, -1, v:false, a:content])
    let g:last_line = a:content[l:len - 1]
  catch
    echo v:exception
    let g:exit_code = 1
  endtry
endfunction

function! Ileum (pwd, addr, cmd) abort
  let g:channel = sockconnect('pipe', a:addr, { 'rpc': v:true })
  let r = rpcrequest(g:channel, 'nvim_command', 'lcd ' .. a:pwd)
  try
    let r = rpcrequest(g:channel, 'nvim_command', a:cmd)
  catch
    echo v:exception
    let g:exit_code = 1
  endtry

  if !has('ttyin')
    call stdioopen({'on_stdin': funcref('On_Stdin'), 'stdin_buffered': v:false, 'rpc': v:false})
  else
    call Do_Close()
  endif
endfunction
