# README _pluginName_

A nvim-lua wrapper that uses `todo.sh`, to create a _'interactive'_ session,
and store the data somewhere in your _nvim_ files.

## DEPENDENCIES

- todo.sh

## USE

First add install it manually or with your favorite plugin-manager

### lazy.nvim

```lua init.lua
-- Together with other files --
return {
    -- ... other plugins
    { 'LibereCode/todo-sh.nvim' },
    -- ... other plugins
}

-------------------------------------

-- Standalone file --
return { 'LibereCode/todo-sh.nvim' },
```

### vim.pack

```lua init.lua
-- This is the builtin package manager for nvim. see `:h vim.pack`
vim.pack.add({
    -- ... other plugins
    'https://github.com/LibereCode/todo-sh.nvim',
    -- ... other plugins
})

-- No `require('todo-sh').setup()` is needed... yet
-- (because this plugin is in its infantcy, and hasen't come to that yet...)
```
