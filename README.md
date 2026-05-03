# README _pluginName_

A nvim-lua wrapper that uses `todo.sh`, to create a _'interactive'_ session,
and store the data somewhere in your _nvim_ files.

> [!WARNING] DISCLAIMER
> This plugin is MEGA alpha, and will 100% have many bugs/weird behavior.
> If you see any obvious shit code, please tell me 🥰.
>
> ALSO NOTE:
> The script `todo.sh` is not created by me. Checkout the original
> repo called: [todo.txt-cli](https://github.com/todotxt/todo.txt-cli)

## DEPENDENCIES

- [todo.txt-cli](https://github.com/todotxt/todo.txt-cli)

## USE

First add install it manually or with your favorite plugin-manager

### lazy.nvim

```lua init.lua
-- Together with other files -- or remove one set of {} if alone in file
return {
    -- ... other plugins
    { 'LibereCode/todo-sh.nvim' },
    -- ... other plugins
}
```

### vim.pack

```lua init.lua
-- This is the builtin package manager for nvim. see `:h vim.pack`
vim.pack.add({
    -- ... other plugins
    'https://github.com/LibereCode/todo-sh.nvim',
    -- ... other plugins
})

local todo, map = require('todo-sh'), vim.keymap.set
todo.setup() -- loads default config
-- OR --
map({'n', 't'}, '<leader>td', todo.toggle_todo,
    {silent = true, desc = "todo.sh plugin?"})
```
