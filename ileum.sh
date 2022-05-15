
ILEUM_PLUGIN_DIR="$(dirname "$0")"
command_not_found_handler() {
  if [[ ":" == "${0:0:1}" ]]; then
    ADDR="$NVIM_LISTEN_ADDRESS"
    if [ -z "$ADDR" ]; then
      ADDR="$NVIM"
    fi
    if [ -n "$ADDR" ]; then
      args="${(qqq)@}"
      pwd="${(qqq)PWD}"
      nvim -u NONE -i NONE --headless --cmd "source $ILEUM_PLUGIN_DIR/ileum.vim" --cmd ":call Ileum($pwd,'$ADDR',$args)"
    else
      echo "ileum: NVIM_LISTEN_ADDRESS and NVIM undefined"
    fi
  else
    echo "command not found: $@"
  fi
}
