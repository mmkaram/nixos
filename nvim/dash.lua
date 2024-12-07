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
      'Lead them to Paradise.',
      '',
    },
    center = {
      { icon = ' ', desc = 'Find File', action = 'Telescope find_files' },
      { icon = ' ', desc = 'Recent Files', action = 'Telescope oldfiles' },
      { icon = ' ', desc = 'Open Config', action = 'edit ~/.config/nvim/init.lua' },
    },
    footer = {
      '',
      'I must not fear. Fear is the mind-killer.',
      'Fear is the little-death that brings total obliteration.',
      'I will face my fear. I will permit it to pass over me and through me.',
      'And when it has gone past, I will turn the inner eye to see its path.',
      'Where the fear has gone there will be nothing.',
      'Only I will remain.',
    }
  }
})

