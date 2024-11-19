require('dashboard').setup {
  header = { "Welcome to Neovim!" }, -- Customize your header
  center = {
    { icon = ' ', desc = 'Find File', action = 'Telescope find_files' },
    { icon = ' ', desc = 'Recent Files', action = 'Telescope oldfiles' },
    { icon = ' ', desc = 'Open Config', action = 'edit ~/.config/nvim/init.lua' },
  },
  footer = { "Have a great coding session!" }, -- Customize your footer
}
