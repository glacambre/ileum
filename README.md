Ileum is a zsh plugin that catches all commands starting with a colon and runs them in the parent neovim instance. To install Ileum, clone this repository somewhere on your disk and add `source /path/to/ileum.sh` to your `.zshrc`.

Example usage:

Print the address of the parent neovim instance:
```
:echo '$NVIM_LISTEN_ADDRESS'
```

Pipe the content of a command to a vertically split buffer:
```
grep mypattern /path/to/file | :vnew
```

Close the terminal buffer:
```
:q
```
