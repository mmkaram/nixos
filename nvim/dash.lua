local db = require('dashboard')

db.setup({
  theme = 'doom',
  config = {
    header = {
      '',
      '                                ',
      '#                              #',
      '###                          ###',
      '####                       #####',
      ' #####                    ##### ',
      '   #####                #####   ',
      '  ## #####            ##### ##  ',
      '   ### #####  ####  ##### ###   ',
      '     ### ##### ## ##### ###     ',
      '       ### ########## ###       ',
      '        ################        ',
      '          ### #### ###          ',
      '           ## #### ##           ',
      '            # #### #            ',
      '              ####              ',
      '               ##               ',
      '',
      'Welcome to Caladan, Paul!',
      '',
    },
    center = {
      { icon = ' ', desc = 'Find File', action = 'Telescope find_files' },
      { icon = ' ', desc = 'Recent Files', action = 'Telescope oldfiles' },
      { icon = ' ', desc = 'Open Config', action = 'edit ~/.config/nvim/init.lua' },
    },
    footer = {
      '',
      'I have no fear, for fear is the little death that kills me over and over.',
      'Without fear, I die but once.',
    }
  }
})

