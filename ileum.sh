
plugin_dir="$(dirname "$0")"
command_not_found_handler() {
  if [[ ":" == "${0:0:1}" ]]; then
    if which nvim >/dev/null 2>/dev/null ; then
      args="${(qqq)@}"
      pwd="${(qqq)PWD}"
      nvim -u NONE -i NONE --headless --cmd "source $plugin_dir/ileum.vim" --cmd ":call Ileum($pwd,'$NVIM_LISTEN_ADDRESS',$args)"
    fi
  else
    echo "commant not found: $@"
  fi
}
