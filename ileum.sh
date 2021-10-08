
ILEUM_PLUGIN_DIR="$(dirname "$0")"
command_not_found_handler() {
  if [[ ":" == "${0:0:1}" ]]; then
    if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
      args="${(qqq)@}"
      pwd="${(qqq)PWD}"
      nvim -u NONE -i NONE --headless --cmd "source $ILEUM_PLUGIN_DIR/ileum.vim" --cmd ":call Ileum($pwd,'$NVIM_LISTEN_ADDRESS',$args)"
    else
      echo "ileum: NVIM_LISTEN_ADDRESS undefined"
    fi
  else
    echo "commant not found: $@"
  fi
}
